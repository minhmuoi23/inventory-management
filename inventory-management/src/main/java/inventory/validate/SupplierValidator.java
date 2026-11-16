package inventory.validate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import inventory.model.Supplier;
import inventory.service.ProductService;

@Component
public class SupplierValidator implements Validator {
	@Autowired
	private ProductService productService;

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz == Supplier.class;
	}

	@Override
	public void validate(Object target, Errors errors) {
		Supplier supplier = (Supplier) target;
		ValidationUtils.rejectIfEmpty(errors, "code", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "name", "msg.required");
		if (supplier.getCode() != null) {
			List<Supplier> results = productService.findSupplier("code", supplier.getCode());
			if (results != null && !results.isEmpty()) {
				if (supplier.getId() != null && supplier.getId() != 0) {
					if (results.get(0).getId() != supplier.getId()) {
						errors.rejectValue("code", "msg.code.exist");
					}
				} else {
					errors.rejectValue("code", "msg.code.exist");
				}
			}
		}
	}

}
