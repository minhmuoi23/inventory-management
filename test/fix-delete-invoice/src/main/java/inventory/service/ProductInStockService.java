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

import inventory.dao.ProductInStockDAO;
import inventory.model.Invoice;
import inventory.model.Paging;
import inventory.model.ProductInStock;
import inventory.model.ProductInfo;
import inventory.util.Constant;

@Service
@Transactional(rollbackFor = Exception.class)
public class ProductInStockService {

    @Autowired
    private ProductInStockDAO<ProductInStock> productInStockDAO;

    private static final Logger log =
            Logger.getLogger(ProductInStockService.class);

    public List<ProductInStock> getAll(
            ProductInStock productInStock,
            Paging paging) {

        log.info("show all productInStock");

        StringBuilder queryStr =
                new StringBuilder();

        Map<String, Object> mapParams =
                new HashMap<>();

        if (productInStock != null
                && productInStock.getProductInfo() != null) {

            if (productInStock.getProductInfo().getCategory() != null
                    && !StringUtils.isEmpty(
                            productInStock
                                    .getProductInfo()
                                    .getCategory()
                                    .getName())) {

                queryStr.append(
                        " and model.productInfo.category.name like :cateName"
                );

                mapParams.put(
                        "cateName",
                        "%"
                                + productInStock
                                        .getProductInfo()
                                        .getCategory()
                                        .getName()
                                + "%"
                );
            }

            if (!StringUtils.isEmpty(
                    productInStock
                            .getProductInfo()
                            .getCode())) {

                queryStr.append(
                        " and model.productInfo.code=:code"
                );

                mapParams.put(
                        "code",
                        productInStock
                                .getProductInfo()
                                .getCode()
                );
            }

            if (!StringUtils.isEmpty(
                    productInStock
                            .getProductInfo()
                            .getName())) {

                queryStr.append(
                        " and model.productInfo.name like :name"
                );

                mapParams.put(
                        "name",
                        "%"
                                + productInStock
                                        .getProductInfo()
                                        .getName()
                                + "%"
                );
            }
        }

        return productInStockDAO.findAll(
                queryStr.toString(),
                mapParams,
                paging
        );
    }

    public void saveOrUpdate(
            Invoice invoice) throws Exception {

        validateInvoice(invoice);

        ProductInStock product =
                findProductInStock(
                        invoice.getProductInfo().getId()
                );

        if (invoice.getType()
                == Constant.TYPE_GOODS_RECEIPT) {

            receiveStock(
                    product,
                    invoice
            );

        } else if (invoice.getType()
                == Constant.TYPE_GOODS_ISSUES) {

            issueStock(
                    product,
                    invoice
            );

        } else {

            throw new Exception(
                    "Invalid invoice type"
            );
        }
    }

    public void adjustStock(
            Invoice oldInvoice,
            Invoice newInvoice) throws Exception {

        if (oldInvoice == null) {
            throw new Exception(
                    "Old invoice is required"
            );
        }

        if (newInvoice == null) {
            throw new Exception(
                    "New invoice is required"
            );
        }

        if (oldInvoice.getProductInfo() == null
                || oldInvoice.getProductInfo().getId() == null) {

            throw new Exception(
                    "Old product is required"
            );
        }

        if (newInvoice.getProductInfo() == null
                || newInvoice.getProductInfo().getId() == null) {

            throw new Exception(
                    "New product is required"
            );
        }

        if (oldInvoice.getType()
                != newInvoice.getType()) {

            throw new Exception(
                    "Invoice type cannot be changed"
            );
        }

        if (!oldInvoice.getProductInfo()
                .getId()
                .equals(
                        newInvoice.getProductInfo()
                                .getId()
                )) {

            throw new Exception(
                    "Product cannot be changed when updating invoice"
            );
        }

        if (newInvoice.getQty() <= 0) {
            throw new Exception(
                    "Quantity must be greater than zero"
            );
        }

        int oldQty =
                oldInvoice.getQty();

        int newQty =
                newInvoice.getQty();

        int difference =
                newQty - oldQty;

        if (difference == 0) {
            return;
        }

        ProductInStock product =
                findProductInStock(
                        newInvoice
                                .getProductInfo()
                                .getId()
                );

        if (product == null) {
            throw new Exception(
                    "Product does not exist in stock"
            );
        }

        int currentQty =
                product.getQty();

        int finalQty;

        if (newInvoice.getType()
                == Constant.TYPE_GOODS_RECEIPT) {

            finalQty =
                    currentQty
                    + difference;

        } else if (newInvoice.getType()
                == Constant.TYPE_GOODS_ISSUES) {

            finalQty =
                    currentQty
                    - difference;

        } else {

            throw new Exception(
                    "Invalid invoice type"
            );
        }

        if (finalQty < 0) {
            throw new Exception(
                    "Not enough stock. Current stock: "
                    + currentQty
                    + ", requested adjustment: "
                    + difference
            );
        }

        product.setQty(
                finalQty
        );

        if (newInvoice.getType()
                == Constant.TYPE_GOODS_RECEIPT
                && newInvoice.getPrice() != null) {

            product.setPrice(
                    newInvoice.getPrice()
            );
        }

        product.setUpdateDate(
                new Date()
        );

        productInStockDAO.update(
                product
        );

        log.info(
                "Adjust stock from "
                        + currentQty
                        + " to "
                        + finalQty
        );
    }

    public void revertStock(
            Invoice invoice) throws Exception {

        validateInvoice(invoice);

        ProductInStock product =
                findProductInStock(
                        invoice.getProductInfo().getId()
                );

        if (product == null) {
            throw new Exception(
                    "Product does not exist in stock"
            );
        }

        int currentQty =
                product.getQty();

        int newQty;

        if (invoice.getType()
                == Constant.TYPE_GOODS_RECEIPT) {

            newQty =
                    currentQty
                    - invoice.getQty();

            if (newQty < 0) {
                throw new Exception(
                        "Not enough stock to delete this receipt. Current stock: "
                        + currentQty
                );
            }

        } else if (invoice.getType()
                == Constant.TYPE_GOODS_ISSUES) {

            newQty =
                    currentQty
                    + invoice.getQty();

        } else {

            throw new Exception(
                    "Invalid invoice type"
            );
        }

        product.setQty(
                newQty
        );

        product.setUpdateDate(
                new Date()
        );

        productInStockDAO.update(
                product
        );

        log.info(
                "Revert stock from "
                        + currentQty
                        + " to "
                        + newQty
        );
    }

    private ProductInStock findProductInStock(
            Integer productId) {

        List<ProductInStock> products =
                productInStockDAO.findByProperty(
                        "productInfo.id",
                        productId
                );

        if (products != null
                && !products.isEmpty()) {

            return products.get(0);
        }

        return null;
    }

    private void validateInvoice(
            Invoice invoice) throws Exception {

        if (invoice == null) {
            throw new Exception(
                    "Invoice is required"
            );
        }

        if (invoice.getProductInfo() == null
                || invoice.getProductInfo().getId() == null) {

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

    private void receiveStock(
            ProductInStock product,
            Invoice invoice) {

        if (product == null) {

            product =
                    new ProductInStock();

            ProductInfo productInfo =
                    new ProductInfo();

            productInfo.setId(
                    invoice
                            .getProductInfo()
                            .getId()
            );

            product.setProductInfo(
                    productInfo
            );

            product.setActiveFlag(1);
            product.setCreateDate(
                    new Date()
            );
            product.setQty(
                    invoice.getQty()
            );
            product.setPrice(
                    invoice.getPrice()
            );
            product.setUpdateDate(
                    new Date()
            );

            productInStockDAO.save(
                    product
            );

            log.info(
                    "Create stock with qty="
                            + invoice.getQty()
            );

        } else {

            int currentQty =
                    product.getQty();

            int newQty =
                    currentQty
                    + invoice.getQty();

            product.setQty(
                    newQty
            );

            if (invoice.getPrice() != null) {
                product.setPrice(
                        invoice.getPrice()
                );
            }

            product.setUpdateDate(
                    new Date()
            );

            productInStockDAO.update(
                    product
            );

            log.info(
                    "Increase stock from "
                            + currentQty
                            + " to "
                            + newQty
            );
        }
    }

    private void issueStock(
            ProductInStock product,
            Invoice invoice) throws Exception {

        if (product == null) {
            throw new Exception(
                    "Product does not exist in stock"
            );
        }

        int currentQty =
                product.getQty();

        if (invoice.getQty()
                > currentQty) {

            throw new Exception(
                    "Not enough stock. Current stock: "
                            + currentQty
                            + ", requested quantity: "
                            + invoice.getQty()
            );
        }

        int newQty =
                currentQty
                - invoice.getQty();

        product.setQty(
                newQty
        );

        product.setUpdateDate(
                new Date()
        );

        productInStockDAO.update(
                product
        );

        log.info(
                "Decrease stock from "
                        + currentQty
                        + " to "
                        + newQty
        );
    }
}
