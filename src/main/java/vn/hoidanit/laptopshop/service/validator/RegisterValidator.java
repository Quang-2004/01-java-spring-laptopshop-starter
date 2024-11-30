package vn.hoidanit.laptopshop.service.validator;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.service.UserService;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if email fields match
        if (this.userService.checkEmailExist(user.getEmail())) {
            addConstraintViolation(context, "Email already exists!", "email");
            valid = false;
        }

        // // Check if password matches the criteria
        // if (!user.getPassword().matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!*()]).{8,}$")) {
        //     addConstraintViolation(context, "Weak password!", "password");
        //     valid = false;
        // }

        // Check if password fields match
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            addConstraintViolation(context, "Passwords do not match!", "confirmPassword");
            valid = false;
        }

        return valid;
    }

    private void addConstraintViolation(ConstraintValidatorContext context, String message, String propertyNode) {
        context.disableDefaultConstraintViolation();
        context.buildConstraintViolationWithTemplate(message)
               .addPropertyNode(propertyNode)
               .addConstraintViolation();
    }
}
