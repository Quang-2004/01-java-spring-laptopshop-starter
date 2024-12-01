package vn.hoidanit.laptopshop.service.validator;

import java.util.regex.Pattern;

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

        // Check if first fields match
        if (user.getFirstName().length() < 3) {
            addConstraintViolation(context, "First must have at least 3 characters!", "firstName");
            valid = false;
        }

        // Check if email fields match
        if (this.userService.checkEmailExist(user.getEmail())) {
            addConstraintViolation(context, "Email already exists!", "email");
            valid = false;
        }

        // Check if password matches the criteria
        if (user.getPassword().length() < 5) {
            addConstraintViolation(context, "Password must have at least 5 characters!", "password");
            valid = false;
        }

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
