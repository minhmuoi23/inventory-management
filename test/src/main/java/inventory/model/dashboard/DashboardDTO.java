package inventory.model.dashboard;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class DashboardDTO {
    private long totalProducts;
    private long totalCategories;
    private long totalStock;
    private long totalReceipts;
    private long totalIssues;
    private BigDecimal stockValue = BigDecimal.ZERO;
    private List<String> chartLabels = new ArrayList<>();
    private List<Integer> receiptData = new ArrayList<>();
    private List<Integer> issueData = new ArrayList<>();
    private List<StockItem> topStockProducts = new ArrayList<>();
    private List<StockItem> lowStockProducts = new ArrayList<>();
    private List<CategoryStock> categoryStocks = new ArrayList<>();

    public long getTotalProducts() { return totalProducts; }
    public void setTotalProducts(long totalProducts) { this.totalProducts = totalProducts; }
    public long getTotalCategories() { return totalCategories; }
    public void setTotalCategories(long totalCategories) { this.totalCategories = totalCategories; }
    public long getTotalStock() { return totalStock; }
    public void setTotalStock(long totalStock) { this.totalStock = totalStock; }
    public long getTotalReceipts() { return totalReceipts; }
    public void setTotalReceipts(long totalReceipts) { this.totalReceipts = totalReceipts; }
    public long getTotalIssues() { return totalIssues; }
    public void setTotalIssues(long totalIssues) { this.totalIssues = totalIssues; }
    public BigDecimal getStockValue() { return stockValue; }
    public void setStockValue(BigDecimal stockValue) { this.stockValue = stockValue; }
    public List<String> getChartLabels() { return chartLabels; }
    public void setChartLabels(List<String> chartLabels) { this.chartLabels = chartLabels; }
    public List<Integer> getReceiptData() { return receiptData; }
    public void setReceiptData(List<Integer> receiptData) { this.receiptData = receiptData; }
    public List<Integer> getIssueData() { return issueData; }
    public void setIssueData(List<Integer> issueData) { this.issueData = issueData; }
    public List<StockItem> getTopStockProducts() { return topStockProducts; }
    public void setTopStockProducts(List<StockItem> topStockProducts) { this.topStockProducts = topStockProducts; }
    public List<StockItem> getLowStockProducts() { return lowStockProducts; }
    public void setLowStockProducts(List<StockItem> lowStockProducts) { this.lowStockProducts = lowStockProducts; }
    public List<CategoryStock> getCategoryStocks() { return categoryStocks; }
    public void setCategoryStocks(List<CategoryStock> categoryStocks) { this.categoryStocks = categoryStocks; }

    public static class StockItem {
        private String code;
        private String name;
        private String categoryName;
        private int qty;
        private BigDecimal price = BigDecimal.ZERO;
        public StockItem() {}
        public StockItem(String code, String name, String categoryName, int qty, BigDecimal price) {
            this.code = code; this.name = name; this.categoryName = categoryName; this.qty = qty;
            if (price != null) this.price = price;
        }
        public String getCode() { return code; }
        public String getName() { return name; }
        public String getCategoryName() { return categoryName; }
        public int getQty() { return qty; }
        public BigDecimal getPrice() { return price; }
    }

    public static class CategoryStock {
        private String categoryName;
        private int qty;
        public CategoryStock() {}
        public CategoryStock(String categoryName, int qty) { this.categoryName = categoryName; this.qty = qty; }
        public String getCategoryName() { return categoryName; }
        public int getQty() { return qty; }
    }
}
