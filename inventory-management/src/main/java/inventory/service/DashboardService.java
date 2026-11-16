package inventory.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import inventory.dao.CategoryDAO;
import inventory.dao.InvoiceDAO;
import inventory.dao.ProductInfoDAO;
import inventory.dao.ProductInStockDAO;
import inventory.model.Category;
import inventory.model.Invoice;
import inventory.model.Paging;
import inventory.model.ProductInStock;
import inventory.model.ProductInfo;
import inventory.model.dashboard.DashboardDTO;
import inventory.model.dashboard.DashboardDTO.CategoryStock;
import inventory.model.dashboard.DashboardDTO.StockItem;
import inventory.util.Constant;

@Service
public class DashboardService {
    @Autowired private ProductInfoDAO<ProductInfo> productInfoDAO;
    @Autowired private CategoryDAO<Category> categoryDAO;
    @Autowired private ProductInStockDAO<ProductInStock> productInStockDAO;
    @Autowired private InvoiceDAO<Invoice> invoiceDAO;

    @Transactional(readOnly = true)
    public DashboardDTO getDashboard() {
        DashboardDTO dto = new DashboardDTO();
        List<ProductInfo> products = productInfoDAO.findAll("", null, null);
        List<Category> categories = categoryDAO.findAll("", null, null);
        List<ProductInStock> stocks = productInStockDAO.findAll("", null, null);
        List<Invoice> invoices = invoiceDAO.findAll("", null, null);

        long totalProducts = 0;
        if (products != null) {
            for (ProductInfo p : products) if (p != null && p.getActiveFlag() == 1) totalProducts++;
        }
        long totalCategories = 0;
        if (categories != null) {
            for (Category c : categories) if (c != null && c.getActiveFlag() == 1) totalCategories++;
        }
        dto.setTotalProducts(totalProducts);
        dto.setTotalCategories(totalCategories);
        dto.setTotalReceipts(countInvoice(invoices, Constant.TYPE_GOODS_RECEIPT));
        dto.setTotalIssues(countInvoice(invoices, Constant.TYPE_GOODS_ISSUES));

        Map<Integer, BigDecimal> costPriceByProduct = new HashMap<>();
        if (stocks != null) {
            for (ProductInStock stock : stocks) {
                if (stock == null || stock.getProductInfo() == null || stock.getActiveFlag() != 1) continue;
                costPriceByProduct.put(
                        stock.getProductInfo().getId(),
                        stock.getPrice() == null ? BigDecimal.ZERO : stock.getPrice()
                );
            }
        }

        BigDecimal revenue = calculateRevenue(invoices);
        BigDecimal costOfGoodsSold = calculateCostOfGoodsSold(invoices, costPriceByProduct);
        dto.setTotalRevenue(revenue);
        dto.setTotalProfit(revenue.subtract(costOfGoodsSold));

        Map<String, Integer> categoryMap = new HashMap<>();
        List<StockItem> stockItems = new ArrayList<>();
        long totalStock = 0;
        BigDecimal stockValue = BigDecimal.ZERO;
        if (stocks != null) {
            for (ProductInStock stock : stocks) {
                if (stock == null || stock.getProductInfo() == null || stock.getActiveFlag() != 1) continue;
                ProductInfo p = stock.getProductInfo();
                int qty = stock.getQty();
                totalStock += qty;
                BigDecimal price = stock.getPrice() == null ? BigDecimal.ZERO : stock.getPrice();
                stockValue = stockValue.add(price.multiply(BigDecimal.valueOf(qty)));
                String categoryName = p.getCategory() == null ? "Chưa phân loại" : p.getCategory().getName();
                categoryMap.put(categoryName, categoryMap.containsKey(categoryName)
                        ? categoryMap.get(categoryName) + qty : qty);
                stockItems.add(new StockItem(p.getCode(), p.getName(), categoryName, qty, price));
            }
        }
        dto.setTotalStock(totalStock);
        dto.setStockValue(stockValue);

        Collections.sort(stockItems, new Comparator<StockItem>() {
            public int compare(StockItem a, StockItem b) { return Integer.compare(b.getQty(), a.getQty()); }
        });
        dto.setTopStockProducts(new ArrayList<StockItem>(stockItems.subList(0, Math.min(5, stockItems.size()))));
        List<StockItem> low = new ArrayList<>();
        for (StockItem item : stockItems) if (item.getQty() <= 10) low.add(item);
        Collections.sort(low, new Comparator<StockItem>() {
            public int compare(StockItem a, StockItem b) { return Integer.compare(a.getQty(), b.getQty()); }
        });
        dto.setLowStockProducts(new ArrayList<StockItem>(low.subList(0, Math.min(10, low.size()))));

        List<CategoryStock> categoryStocks = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : categoryMap.entrySet()) {
            categoryStocks.add(new CategoryStock(entry.getKey(), entry.getValue()));
        }
        Collections.sort(categoryStocks, new Comparator<CategoryStock>() {
            public int compare(CategoryStock a, CategoryStock b) { return Integer.compare(b.getQty(), a.getQty()); }
        });
        dto.setCategoryStocks(categoryStocks);

        buildMonthlyChart(dto, invoices, costPriceByProduct);
        return dto;
    }

    private long countInvoice(List<Invoice> invoices, int type) {
        long count = 0;
        if (invoices != null) {
            for (Invoice invoice : invoices) {
                if (invoice.getType() == type && invoice.getActiveFlag() == 1) count++;
            }
        }
        return count;
    }

    private BigDecimal calculateCostOfGoodsSold(
            List<Invoice> invoices,
            Map<Integer, BigDecimal> costPriceByProduct) {

        BigDecimal cost = BigDecimal.ZERO;
        if (invoices != null) {
            for (Invoice invoice : invoices) {
                if (invoice.getType() == Constant.TYPE_GOODS_ISSUES
                        && invoice.getActiveFlag() == 1
                        && invoice.getProductInfo() != null) {

                    BigDecimal costPrice = costPriceByProduct.get(
                            invoice.getProductInfo().getId()
                    );
                    if (costPrice == null) {
                        costPrice = BigDecimal.ZERO;
                    }
                    cost = cost.add(
                            costPrice.multiply(BigDecimal.valueOf(invoice.getQty()))
                    );
                }
            }
        }
        return cost;
    }

    private BigDecimal calculateRevenue(List<Invoice> invoices) {
        BigDecimal revenue = BigDecimal.ZERO;
        if (invoices != null) {
            for (Invoice invoice : invoices) {
                if (invoice.getType() == Constant.TYPE_GOODS_ISSUES
                        && invoice.getActiveFlag() == 1
                        && invoice.getPrice() != null) {
                    revenue = revenue.add(
                            invoice.getPrice().multiply(BigDecimal.valueOf(invoice.getQty()))
                    );
                }
            }
        }
        return revenue;
    }

    private void buildMonthlyChart(
            DashboardDTO dto,
            List<Invoice> invoices,
            Map<Integer, BigDecimal> costPriceByProduct) {

        Calendar now = Calendar.getInstance();
        Calendar start = (Calendar) now.clone();
        start.set(Calendar.DAY_OF_MONTH, 1);
        start.add(Calendar.MONTH, -11);
        Map<String, Integer> receipt = new LinkedHashMap<>();
        Map<String, Integer> issue = new LinkedHashMap<>();
        Map<String, BigDecimal> revenue = new LinkedHashMap<>();
        Map<String, BigDecimal> profit = new LinkedHashMap<>();
        SimpleDateFormat keyFormat = new SimpleDateFormat("yyyy-MM");
        SimpleDateFormat labelFormat = new SimpleDateFormat("MM/yyyy");
        Calendar cursor = (Calendar) start.clone();
        for (int i = 0; i < 12; i++) {
            String key = keyFormat.format(cursor.getTime());
            receipt.put(key, 0); issue.put(key, 0);
            revenue.put(key, BigDecimal.ZERO); profit.put(key, BigDecimal.ZERO);
            dto.getChartLabels().add(labelFormat.format(cursor.getTime()));
            cursor.add(Calendar.MONTH, 1);
        }
        if (invoices != null) {
            for (Invoice invoice : invoices) {
                if (invoice.getActiveFlag() != 1) continue;
                Date date = invoice.getUpdateDate() != null ? invoice.getUpdateDate() : invoice.getCreateDate();
                if (date == null) continue;
                String key = keyFormat.format(date);
                if (invoice.getType() == Constant.TYPE_GOODS_RECEIPT && receipt.containsKey(key)) {
                    receipt.put(key, receipt.get(key) + invoice.getQty());
                } else if (invoice.getType() == Constant.TYPE_GOODS_ISSUES && issue.containsKey(key)) {
                    issue.put(key, issue.get(key) + invoice.getQty());

                    if (invoice.getPrice() != null && revenue.containsKey(key)) {
                        BigDecimal lineRevenue =
                                invoice.getPrice().multiply(BigDecimal.valueOf(invoice.getQty()));
                        revenue.put(key, revenue.get(key).add(lineRevenue));

                        BigDecimal costPrice =
                                invoice.getProductInfo() != null
                                        ? costPriceByProduct.get(invoice.getProductInfo().getId())
                                        : null;
                        if (costPrice == null) costPrice = BigDecimal.ZERO;
                        BigDecimal lineCost = costPrice.multiply(BigDecimal.valueOf(invoice.getQty()));
                        profit.put(key, profit.get(key).add(lineRevenue.subtract(lineCost)));
                    }
                }
            }
        }
        dto.setReceiptData(new ArrayList<Integer>(receipt.values()));
        dto.setIssueData(new ArrayList<Integer>(issue.values()));

        List<Double> revenueList = new ArrayList<>();
        for (BigDecimal v : revenue.values()) revenueList.add(v.doubleValue());
        dto.setRevenueData(revenueList);

        List<Double> profitList = new ArrayList<>();
        for (BigDecimal v : profit.values()) profitList.add(v.doubleValue());
        dto.setProfitData(profitList);
    }
}