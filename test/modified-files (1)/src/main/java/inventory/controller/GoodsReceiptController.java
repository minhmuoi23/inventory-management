package inventory.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inventory.model.Invoice;
import inventory.model.Paging;
import inventory.model.ProductInfo;
import inventory.model.Users;
import inventory.service.GoodsReceiptReport;
import inventory.service.InvoiceService;
import inventory.service.ProductService;
import inventory.service.UserService;
import inventory.util.Constant;
import inventory.validate.InvoiceValidator;

@Controller
public class GoodsReceiptController {

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private InvoiceValidator invoiceValidator;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    static final Logger log =
            Logger.getLogger(GoodsReceiptController.class);

    @InitBinder
    private void initBinder(WebDataBinder binder) {

        if (binder.getTarget() == null) {
            return;
        }

        SimpleDateFormat sdf =
                new SimpleDateFormat(
                        "yyyy-MM-dd HH:mm:ss"
                );

        binder.registerCustomEditor(
                Date.class,
                new CustomDateEditor(sdf, true)
        );

        binder.registerCustomEditor(
                Integer.class,
                new CustomNumberEditor(Integer.class, true)
        );

        if (binder.getTarget().getClass()
                == Invoice.class) {

            binder.setValidator(
                    invoiceValidator
            );
        }
    }

    @RequestMapping(
            value = {
                    "/goods-receipt/list",
                    "/goods-receipt/list/"
            }
    )
    public String redirect() {
        return "redirect:/goods-receipt/list/1";
    }

    @RequestMapping(
            value = "/goods-receipt/list/{page}"
    )
    public String showInvoiceList(
            Model model,
            HttpSession session,
            @ModelAttribute("searchForm")
            Invoice invoice,
            @PathVariable("page") int page) {

        Paging paging =
                new Paging(5);

        paging.setIndexPage(page);

        if (invoice == null) {
            invoice = new Invoice();
        }

        invoice.setType(
                Constant.TYPE_GOODS_RECEIPT
        );

        List<Invoice> invoices =
                invoiceService.getList(
                        invoice,
                        paging
                );

        if (session.getAttribute(
                Constant.MSG_SUCCESS) != null) {

            model.addAttribute(
                    Constant.MSG_SUCCESS,
                    session.getAttribute(
                            Constant.MSG_SUCCESS
                    )
            );

            session.removeAttribute(
                    Constant.MSG_SUCCESS
            );
        }

        if (session.getAttribute(
                Constant.MSG_ERROR) != null) {

            model.addAttribute(
                    Constant.MSG_ERROR,
                    session.getAttribute(
                            Constant.MSG_ERROR
                    )
            );

            session.removeAttribute(
                    Constant.MSG_ERROR
            );
        }

        model.addAttribute(
                "pageInfo",
                paging
        );

        model.addAttribute(
                "invoices",
                invoices
        );

        model.addAttribute(
                "mapProduct",
                initMapProduct()
        );

        model.addAttribute(
                "mapUser",
                initMapUser()
        );

        return "goods-receipt-list";
    }

    @GetMapping("/goods-receipt/add")
    public String add(Model model) {

        model.addAttribute(
                "titlePage",
                "Thêm Phiếu Nhập"
        );

        model.addAttribute(
                "modelForm",
                new Invoice()
        );

        model.addAttribute(
                "viewOnly",
                false
        );

        model.addAttribute(
                "mapProduct",
                initMapProduct()
        );

        return "goods-receipt-action";
    }

    @GetMapping("/goods-receipt/edit/{id}")
    public String edit(
            Model model,
            @PathVariable("id") int id) {

        log.info(
                "Edit invoice with id="
                + id
        );

        List<Invoice> invoices =
                invoiceService.find(
                        "id",
                        id
                );

        if (invoices == null
                || invoices.isEmpty()) {

            return "redirect:/goods-receipt/list";
        }

        Invoice invoice =
                invoices.get(0);

        model.addAttribute(
                "titlePage",
                "Sửa Phiếu Nhập"
        );

        model.addAttribute(
                "modelForm",
                invoice
        );

        model.addAttribute(
                "viewOnly",
                false
        );

        model.addAttribute(
                "mapProduct",
                initMapProduct()
        );

        return "goods-receipt-action";
    }

    @GetMapping("/goods-receipt/view/{id}")
    public String view(
            Model model,
            @PathVariable("id") int id) {

        log.info(
                "View invoice with id="
                + id
        );

        List<Invoice> invoices =
                invoiceService.find(
                        "id",
                        id
                );

        if (invoices == null
                || invoices.isEmpty()) {

            return "redirect:/goods-receipt/list";
        }

        Invoice invoice =
                invoices.get(0);

        model.addAttribute(
                "titlePage",
                "Xem Phiếu Nhập"
        );

        model.addAttribute(
                "modelForm",
                invoice
        );

        model.addAttribute(
                "viewOnly",
                true
        );

        return "goods-receipt-action";
    }

    @PostMapping("/goods-receipt/save")
    public String save(
            Model model,
            @ModelAttribute("modelForm")
            @Validated Invoice invoice,
            BindingResult result,
            HttpSession session) {

        invoice.setType(
                Constant.TYPE_GOODS_RECEIPT
        );

        if (result.hasErrors()) {

            if (invoice.getId() != null
                    && invoice.getId() != 0) {

                model.addAttribute(
                        "titlePage",
                        "Sửa Phiếu Nhập"
                );

            } else {

                model.addAttribute(
                        "titlePage",
                        "Thêm Phiếu Nhập"
                );
            }

            model.addAttribute(
                    "mapProduct",
                    initMapProduct()
            );

            model.addAttribute(
                    "modelForm",
                    invoice
            );

            model.addAttribute(
                    "viewOnly",
                    false
            );

            return "goods-receipt-action";
        }

        try {

            if (invoice.getId() != null
                    && invoice.getId() != 0) {

                invoiceService.update(
                        invoice
                );

                session.setAttribute(
                        Constant.MSG_SUCCESS,
                        "Update success!!!"
                );

            } else {

                invoice.setCreatedBy(
                        (Users) session.getAttribute(
                                Constant.USER_INFO
                        )
                );

                invoiceService.save(
                        invoice
                );

                session.setAttribute(
                        Constant.MSG_SUCCESS,
                        "Insert success!!!"
                );
            }

        } catch (Exception e) {

            log.error(
                    "Goods receipt error",
                    e
            );

            session.setAttribute(
                    Constant.MSG_ERROR,
                    e.getMessage()
            );
        }

        return "redirect:/goods-receipt/list";
    }

    @GetMapping("/goods-receipt/export")
    public ModelAndView exportReport() {

        ModelAndView modelAndView =
                new ModelAndView();

        Invoice invoice =
                new Invoice();

        invoice.setType(
                Constant.TYPE_GOODS_RECEIPT
        );

        List<Invoice> invoices =
                invoiceService.getList(
                        invoice,
                        null
                );

        modelAndView.addObject(
                Constant.KEY_GOODS_RECEIPT_REPORT,
                invoices
        );

        modelAndView.setView(
                new GoodsReceiptReport()
        );

        return modelAndView;
    }

    private Map<String, String> initMapProduct() {

        List<ProductInfo> productInfos =
                productService.getAllProductInfo(
                        null,
                        null
                );

        Map<String, String> mapProduct =
                new HashMap<>();

        for (ProductInfo productInfo
                : productInfos) {

            mapProduct.put(
                    productInfo.getId().toString(),
                    productInfo.getName()
            );
        }

        return mapProduct;
    }

    private Map<String, String> initMapUser() {

        List<Users> users =
                userService.getUsersList(
                        null,
                        null
                );

        Map<String, String> mapUser =
                new HashMap<>();

        for (Users user
                : users) {

            mapUser.put(
                    user.getId().toString(),
                    user.getName()
            );
        }

        return mapUser;
    }
}
