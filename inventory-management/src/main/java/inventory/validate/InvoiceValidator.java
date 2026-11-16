package inventory.validate;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import inventory.model.Invoice;
import inventory.service.InvoiceService;

@Component
public class InvoiceValidator implements Validator {

    @Autowired
    private InvoiceService invoiceService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Invoice.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Invoice invoice = (Invoice) target;

        ValidationUtils.rejectIfEmptyOrWhitespace(
                errors,
                "code",
                "msg.required"
        );

        ValidationUtils.rejectIfEmpty(
                errors,
                "qty",
                "msg.required"
        );

        ValidationUtils.rejectIfEmpty(
                errors,
                "price",
                "msg.required"
        );

        if (invoice.getCode() != null
                && !invoice.getCode().trim().isEmpty()) {

            Invoice searchInvoice = new Invoice();

            searchInvoice.setCode(
                    invoice.getCode().trim()
            );

            searchInvoice.setType(
                    invoice.getType()
            );

            List<Invoice> results =
                    invoiceService.getList(
                            searchInvoice,
                            null
                    );

            if (results != null
                    && !results.isEmpty()) {

                boolean codeExists = false;

                for (Invoice result : results) {

                    if (invoice.getId() == null
                            || invoice.getId() == 0) {

                        codeExists = true;
                        break;
                    }

                    if (result.getId() != null
                            && !result.getId()
                                    .equals(invoice.getId())) {

                        codeExists = true;
                        break;
                    }
                }

                if (codeExists) {
                    errors.rejectValue(
                            "code",
                            "msg.code.exist"
                    );
                }
            }
        }

        if (invoice.getQty() <= 0) {
            errors.rejectValue(
                    "qty",
                    "msg.wrong.format"
            );
        }

        if (invoice.getPrice() == null) {

            if (!hasFieldError(errors, "price")) {
                errors.rejectValue(
                        "price",
                        "msg.required"
                );
            }

        } else if (invoice.getPrice()
                .compareTo(BigDecimal.ZERO) <= 0) {

            errors.rejectValue(
                    "price",
                    "msg.wrong.format"
            );
        }

        if (invoice.getFromDate() != null
                && invoice.getToDate() != null
                && invoice.getFromDate()
                        .after(invoice.getToDate())) {

            errors.rejectValue(
                    "fromDate",
                    "msg.wrong.date"
            );
        }
    }

    private boolean hasFieldError(
            Errors errors,
            String field) {

        return errors.hasFieldErrors(field);
    }
}
