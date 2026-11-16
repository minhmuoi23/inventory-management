package inventory.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
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

import inventory.model.Paging;
import inventory.model.Supplier;
import inventory.service.ProductService;
import inventory.util.Constant;
import inventory.validate.SupplierValidator;

@Controller
public class SupplierController {
	@Autowired
	private ProductService productService;
	@Autowired
	private SupplierValidator supplierValidator;
	static final Logger log = Logger.getLogger(SupplierController.class);

	@InitBinder
	private void initBinder(WebDataBinder binder) {
		if (binder.getTarget() == null) {
			return;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
		if (binder.getTarget().getClass() == Supplier.class) {
			binder.setValidator(supplierValidator);
		}
	}

	@RequestMapping(value = { "/supplier/list", "/supplier/list/" })
	public String redirect() {
		return "redirect:/supplier/list/1";
	}

	@RequestMapping(value = "/supplier/list/{page}")
	public String showSupplierList(Model model, HttpSession session, @ModelAttribute("searchForm") Supplier supplier,
			@PathVariable("page") int page) {
		Paging paging = new Paging(5);
		paging.setIndexPage(page);
		List<Supplier> suppliers = productService.getAllSupplier(supplier, paging);
		if (session.getAttribute(Constant.MSG_SUCCESS) != null) {
			model.addAttribute(Constant.MSG_SUCCESS, session.getAttribute(Constant.MSG_SUCCESS));
			session.removeAttribute(Constant.MSG_SUCCESS);
		}
		if (session.getAttribute(Constant.MSG_ERROR) != null) {
			model.addAttribute(Constant.MSG_ERROR, session.getAttribute(Constant.MSG_ERROR));
			session.removeAttribute(Constant.MSG_ERROR);
		}
		model.addAttribute("pageInfo", paging);
		model.addAttribute("suppliers", suppliers);
		return "supplier-list";
	}

	@GetMapping("/supplier/add")
	public String add(Model model) {
		model.addAttribute("titlePage", "Thêm nhà cung cấp");
		model.addAttribute("modelForm", new Supplier());
		model.addAttribute("viewOnly", false);
		return "supplier-action";
	}

	@GetMapping("/supplier/edit/{id}")
	public String edit(Model model, @PathVariable("id") int id) {
		log.info("Edit supplier with id=" + id);
		Supplier supplier = productService.findByIdSupplier(id);
		if (supplier != null) {
			model.addAttribute("titlePage", "Sửa nhà cung cấp");
			model.addAttribute("modelForm", supplier);
			model.addAttribute("viewOnly", false);
			return "supplier-action";
		}
		return "redirect:/supplier/list";
	}

	@GetMapping("/supplier/view/{id}")
	public String view(Model model, @PathVariable("id") int id) {
		log.info("View supplier with id=" + id);
		Supplier supplier = productService.findByIdSupplier(id);
		if (supplier != null) {
			model.addAttribute("titlePage", "Xem nhà cung cấp");
			model.addAttribute("modelForm", supplier);
			model.addAttribute("viewOnly", true);
			return "supplier-action";
		}
		return "redirect:/supplier/list";
	}

	@PostMapping("/supplier/save")
	public String save(Model model, @ModelAttribute("modelForm") @Validated Supplier supplier, BindingResult result,
			HttpSession session) {
		if (result.hasErrors()) {
			if (supplier.getId() != null) {
				model.addAttribute("titlePage", "Sửa nhà cung cấp");
			} else {
				model.addAttribute("titlePage", "Thêm nhà cung cấp");
			}
			model.addAttribute("modelForm", supplier);
			model.addAttribute("viewOnly", false);
			return "supplier-action";
		}
		if (supplier.getId() != null && supplier.getId() != 0) {
			try {
				productService.updateSupplier(supplier);
				session.setAttribute(Constant.MSG_SUCCESS, "Cập nhật thành công!!!");
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.getMessage());
				session.setAttribute(Constant.MSG_ERROR, "Cập nhật thất bại");
			}
		} else {
			try {
				productService.saveSupplier(supplier);
				session.setAttribute(Constant.MSG_SUCCESS, "Thêm mới thành công!!!");
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute(Constant.MSG_ERROR, "Thêm mới thất bại!!!");
			}
		}
		return "redirect:/supplier/list";
	}

	@GetMapping("/supplier/delete/{id}")
	public String delete(Model model, @PathVariable("id") int id, HttpSession session) {
		log.info("Delete supplier with id=" + id);
		Supplier supplier = productService.findByIdSupplier(id);
		if (supplier != null) {
			try {
				productService.deleteSupplier(supplier);
				session.setAttribute(Constant.MSG_SUCCESS, "Xoá thành công!!!");
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute(Constant.MSG_ERROR, "Xoá thất bại!!!");
			}
		}
		return "redirect:/supplier/list";
	}

}
