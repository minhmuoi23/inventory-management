package inventory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import inventory.model.Category;
import inventory.model.Paging;
import inventory.model.ProductInStock;
import inventory.model.Supplier;
import inventory.service.ProductInStockService;
import inventory.service.ProductService;

@Controller
public class ProductInStockController {
	@Autowired
	private ProductInStockService productInStockService;
	@Autowired
	private ProductService productService;
	static final Logger log = Logger.getLogger(ProductInStockController.class);
	
	@GetMapping({"/product-in-stock/list","/product-in-stock/list/"})
	public String redirect() {
		return "redirect:/product-in-stock/list/1";
	}
	@RequestMapping(value="/product-in-stock/list/{page}")
	public String list(Model model, @ModelAttribute("searchForm") ProductInStock productInStock,@PathVariable("page") int page) {
		Paging paging = new Paging(10);
		paging.setIndexPage(page);
		List<ProductInStock> productInStocks = productInStockService.getAll(productInStock, paging);
		model.addAttribute("products", productInStocks);
		model.addAttribute("pageInfo", paging);
		model.addAttribute("mapCategory", buildMapCategory(true, "-- Tất cả --"));
		model.addAttribute("mapSupplier", buildMapSupplier(true, "-- Tất cả --"));
		return "product-in-stock";
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