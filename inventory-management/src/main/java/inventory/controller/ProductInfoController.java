package inventory.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import inventory.model.ProductInfo;
import inventory.model.Category;
import inventory.model.Supplier;
import inventory.model.Paging;
import inventory.service.ProductService;
import inventory.util.Constant;
import inventory.validate.ProductInfoValidator;

@Controller
public class ProductInfoController {
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductInfoValidator productInfoValidator;
	static final Logger log = Logger.getLogger(ProductInfoController.class);
	@InitBinder
	private void initBinder(WebDataBinder binder) {
		if(binder.getTarget()==null) {
			return;
		}
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
		if(binder.getTarget().getClass()== ProductInfo.class) {
			binder.setValidator(productInfoValidator);
		}
	}
	@RequestMapping(value= {"/product-info/list","/product-info/list/"})
	
	public String redirect() {
		return "redirect:/product-info/list/1";
	}
	
	@RequestMapping(value="/product-info/list/{page}")
	public String showProductInfoList(Model model,HttpSession session , @ModelAttribute("searchForm") ProductInfo productInfo,@PathVariable("page") int page) {
		Paging paging = new Paging(5);
		paging.setIndexPage(page);
		List<ProductInfo> products = productService.getAllProductInfo(productInfo,paging);
		if(session.getAttribute(Constant.MSG_SUCCESS)!=null ) {
			model.addAttribute(Constant.MSG_SUCCESS, session.getAttribute(Constant.MSG_SUCCESS));
			session.removeAttribute(Constant.MSG_SUCCESS);
		}
		if(session.getAttribute(Constant.MSG_ERROR)!=null ) {
			model.addAttribute(Constant.MSG_ERROR, session.getAttribute(Constant.MSG_ERROR));
			session.removeAttribute(Constant.MSG_ERROR);
		}
		model.addAttribute("pageInfo", paging);
		model.addAttribute("products", products);
		model.addAttribute("mapSupplier", buildMapSupplier(true, "-- Tất cả --"));
		model.addAttribute("mapCategory", buildMapCategory(true, "-- Tất cả --"));
		return "productInfo-list";
		
	}
	@GetMapping("/product-info/add")
	public String add(Model model) {
		model.addAttribute("titlePage", "Thêm sản phẩm");
		ProductInfo newProductInfo = new ProductInfo();
		newProductInfo.setSupplierId(0);
		model.addAttribute("modelForm", newProductInfo);
		List<Category> categories = productService.getAllCategory(null, null);
		Map<String, String> mapCategory = new HashMap<>();
		for(Category category : categories) {
			mapCategory.put(String.valueOf(category.getId()), category.getName());
		}
		model.addAttribute("mapCategory", mapCategory);
		model.addAttribute("mapSupplier", buildMapSupplier(true));
		model.addAttribute("viewOnly", false);
		return "productInfo-action";
	}
	@GetMapping("/product-info/edit/{id}")
	public String edit(Model model , @PathVariable("id") int id) {
		log.info("Edit productInfo with id="+id);
		ProductInfo productInfo = productService.findByIdProductInfo(id);
		if(productInfo!=null) {
			List<Category> categories = productService.getAllCategory(null, null);
			Map<String, String> mapCategory = new HashMap<>();
			for(Category category : categories) {
				mapCategory.put(String.valueOf(category.getId()), category.getName());
			}
			productInfo.setCateId(productInfo.getCategory().getId());
			if(productInfo.getSupplier()!=null) {
				productInfo.setSupplierId(productInfo.getSupplier().getId());
			} else {
				productInfo.setSupplierId(0);
			}
			model.addAttribute("mapCategory", mapCategory);
			model.addAttribute("mapSupplier", buildMapSupplier(true));
			model.addAttribute("titlePage", "Sửa sản phẩm");
			model.addAttribute("modelForm", productInfo);
			model.addAttribute("viewOnly", false);
			return "productInfo-action";
		}
		return "redirect:/product-info/list";
	}
	@GetMapping("/product-info/view/{id}")
	public String view(Model model , @PathVariable("id") int id) {
		log.info("View productInfo with id="+id);
		ProductInfo productInfo = productService.findByIdProductInfo(id);
		if(productInfo!=null) {
			model.addAttribute("titlePage", "Xem sản phẩm");
			model.addAttribute("modelForm", productInfo);
			model.addAttribute("viewOnly", true);
			return "productInfo-action";
		}
		return "redirect:/product-info/list";
	}
	@PostMapping("/product-info/save")
	public String save(Model model,@ModelAttribute("modelForm") @Validated ProductInfo productInfo,BindingResult result,HttpSession session) {
		if(result.hasErrors()) {
			if(productInfo.getId()!=null) {
				model.addAttribute("titlePage", "Sửa sản phẩm");
			}else {
				model.addAttribute("titlePage", "Thêm sản phẩm");
			}
			List<Category> categories = productService.getAllCategory(null, null);
			Map<String, String> mapCategory = new HashMap<>();
			for(Category category : categories) {
				mapCategory.put(String.valueOf(category.getId()), category.getName());
			}
			model.addAttribute("mapCategory", mapCategory);
			model.addAttribute("mapSupplier", buildMapSupplier(true));
			model.addAttribute("modelForm", productInfo);
			model.addAttribute("viewOnly", false);
			return "productInfo-action";
			
		}
		Category category = new Category();
		category.setId(productInfo.getCateId());
		productInfo.setCategory(category);
		if(productInfo.getSupplierId()!=null && productInfo.getSupplierId()!=0) {
			Supplier supplier = new Supplier();
			supplier.setId(productInfo.getSupplierId());
			productInfo.setSupplier(supplier);
		} else {
			productInfo.setSupplier(null);
		}
		if(productInfo.getId()!=null && productInfo.getId()!=0) {
			try {
				
				productService.updateProductInfo(productInfo);
				session.setAttribute(Constant.MSG_SUCCESS, "Cập nhật thành công!!!");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				log.error(e.getMessage());
				session.setAttribute(Constant.MSG_ERROR, "Cập nhật thất bại");
			}
			
		}else {
				try {
					productService.saveProductInfo(productInfo);
					session.setAttribute(Constant.MSG_SUCCESS, "Thêm mới thành công!!!");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					session.setAttribute(Constant.MSG_ERROR, "Thêm mới thất bại!!!");
				}
		}
		return "redirect:/product-info/list";
		
	}
	@GetMapping("/product-info/delete/{id}")
	public String delete(Model model , @PathVariable("id") int id,HttpSession session) {
		log.info("Delete productInfo with id="+id);
		ProductInfo productInfo = productService.findByIdProductInfo(id);
		if(productInfo!=null) {
			try {
				productService.deleteProductInfo(productInfo);
				session.setAttribute(Constant.MSG_SUCCESS, "Xoá thành công!!!");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				session.setAttribute(Constant.MSG_ERROR, "Xoá thất bại!!!");
			}
		}
		return "redirect:/product-info/list";
	}

	private Map<String, String> buildMapCategory(boolean includeBlankOption, String blankLabel) {
		List<Category> categories = productService.getAllCategory(null, null);
		Map<String, String> mapCategory = new HashMap<>();
		if (includeBlankOption) {
			mapCategory.put("0", blankLabel);
		}
		for (Category category : categories) {
			mapCategory.put(String.valueOf(category.getId()), category.getName());
		}
		return mapCategory;
	}

	private Map<String, String> buildMapSupplier(boolean includeBlankOption) {
		return buildMapSupplier(includeBlankOption, "-- Không chọn --");
	}

	private Map<String, String> buildMapSupplier(boolean includeBlankOption, String blankLabel) {
		List<Supplier> suppliers = productService.getAllSupplier(null, null);
		Map<String, String> mapSupplier = new HashMap<>();
		if (includeBlankOption) {
			mapSupplier.put("0", blankLabel);
		}
		for (Supplier supplier : suppliers) {
			mapSupplier.put(String.valueOf(supplier.getId()), supplier.getName());
		}
		return mapSupplier;
	}

}