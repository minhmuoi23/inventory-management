package inventory.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import inventory.dao.InvoiceDAO;
import inventory.model.Invoice;
import inventory.model.Paging;
import inventory.model.ProductInfo;
import inventory.util.Constant;

@Service
@Transactional(rollbackFor = Exception.class)
public class InvoiceService {

    @Autowired
    private HistoryService historyService;

    @Autowired
    private ProductInStockService productInStockService;

    @Autowired
    private InvoiceDAO<Invoice> invoiceDAO;

    static final Logger log =
            Logger.getLogger(InvoiceService.class);

    public void save(
            Invoice invoice) throws Exception {

        validateInvoice(
                invoice
        );

        ProductInfo productInfo =
                new ProductInfo();

        productInfo.setId(
                invoice.getProductId()
        );

        invoice.setProductInfo(
                productInfo
        );

        invoice.setActiveFlag(1);
        invoice.setCreateDate(
                new Date()
        );
        invoice.setUpdateDate(
                new Date()
        );

        productInStockService.saveOrUpdate(
                invoice
        );

        invoiceDAO.save(
                invoice
        );

        historyService.save(
                invoice,
                Constant.ACTION_ADD
        );
    }

    public void update(
            Invoice invoice) throws Exception {

        validateInvoice(
                invoice
        );

        if (invoice.getId() == null
                || invoice.getId() == 0) {

            throw new Exception(
                    "Invoice ID is required"
            );
        }

        Invoice oldInvoice =
                invoiceDAO.findById(
                        Invoice.class,
                        invoice.getId()
                );

        if (oldInvoice == null) {
            throw new Exception(
                    "Invoice not found"
            );
        }

        if (oldInvoice.getProductInfo() == null
                || oldInvoice.getProductInfo().getId() == null) {

            throw new Exception(
                    "Old product is invalid"
            );
        }

        if (oldInvoice.getType()
                != invoice.getType()) {

            throw new Exception(
                    "Invoice type cannot be changed"
            );
        }

        ProductInfo productInfo =
                new ProductInfo();

        productInfo.setId(
                invoice.getProductId()
        );

        invoice.setProductInfo(
                productInfo
        );

        invoice.setCreatedBy(
                oldInvoice.getCreatedBy()
        );

        productInStockService.adjustStock(
                oldInvoice,
                invoice
        );

        invoice.setUpdateDate(
                new Date()
        );

        invoiceDAO.update(
                invoice
        );

        historyService.save(
                invoice,
                Constant.ACTION_EDIT
        );
    }

    public List<Invoice> find(
            String property,
            Object value) {

        return invoiceDAO.findByProperty(
                property,
                value
        );
    }

    public List<Invoice> getList(
            Invoice invoice,
            Paging paging) {

        StringBuilder queryStr =
                new StringBuilder();

        Map<String, Object> mapParams =
                new HashMap<>();

        if (invoice != null) {

            if (invoice.getType() != 0) {

                queryStr.append(
                        " and model.type=:type"
                );

                mapParams.put(
                        "type",
                        invoice.getType()
                );
            }

            if (!StringUtils.isEmpty(
                    invoice.getCode())) {

                queryStr.append(
                        " and model.code =:code "
                );

                mapParams.put(
                        "code",
                        invoice.getCode()
                );
            }

            if (invoice.getFromDate()
                    != null) {

                queryStr.append(
                        " and model.updateDate >= :fromDate"
                );

                mapParams.put(
                        "fromDate",
                        invoice.getFromDate()
                );
            }

            if (invoice.getToDate()
                    != null) {

                queryStr.append(
                        " and model.updateDate <= :toDate"
                );

                mapParams.put(
                        "toDate",
                        invoice.getToDate()
                );
            }

            if (invoice.getProductId()
                    != null) {

                queryStr.append(
                        " and model.productInfo.id=:productId"
                );

                mapParams.put(
                        "productId",
                        invoice.getProductId()
                );
            }

            if (invoice.getCreatedById()
                    != null) {

                queryStr.append(
                        " and model.createdBy.id=:createdById"
                );

                mapParams.put(
                        "createdById",
                        invoice.getCreatedById()
                );
            }
        }

        return invoiceDAO.findAll(
                queryStr.toString(),
                mapParams,
                paging
        );
    }

    private void validateInvoice(
            Invoice invoice) throws Exception {

        if (invoice == null) {
            throw new Exception(
                    "Invoice is required"
            );
        }

        if (invoice.getProductId() == null) {
            throw new Exception(
                    "Product is required"
            );
        }

        if (invoice.getQty() <= 0) {
            throw new Exception(
                    "Quantity must be greater than zero"
            );
        }

        if (invoice.getType()
                != Constant.TYPE_GOODS_RECEIPT
                && invoice.getType()
                != Constant.TYPE_GOODS_ISSUES) {

            throw new Exception(
                    "Invalid invoice type"
            );
        }
    }
}
