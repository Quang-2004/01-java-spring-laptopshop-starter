package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.RoleService;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;
    private final UploadService uploadService;

    public HomePageController(ProductService productService,
            UserService userService,
            PasswordEncoder passwordEncoder,
            RoleService roleService, UploadService uploadService) {

        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.roleService = roleService;
        this.uploadService = uploadService;
    }

    @GetMapping("/")
    public String getHomePage(Model model, HttpServletRequest request) {

        List<Product> products = this.productService.findAllProducts();
        model.addAttribute("products", products);
        return "client/homepage/show";
    }

    @GetMapping("/login")
    public String login(Model model) {
        return "client/auth/login";
    }

    @PostMapping("/login")
    public String handleLoginPage(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegisterPage(Model model,
            @Valid @ModelAttribute("registerUser") RegisterDTO registerUser,
            BindingResult newUserBindingResult) {

        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if (newUserBindingResult.hasErrors()) {
            return "client/auth/register";
        }

        User user = userService.registerDTOtoUser(registerUser);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());

        user.setPassword(hashPassword);

        user.setRole(this.roleService.findByName("USER"));
        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {
        return "client/access-deny/deny";
    }

    @GetMapping("/account/my-profile")
    public String getMyProfilepage(Model model,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        // get username
        String username = (String) session.getAttribute("email");
        // get user
        User user = this.userService.findByEmail(username);

        model.addAttribute("user", user);
        model.addAttribute("updateUser", user);
        return "client/my-account/my-profile";
    }

    @PostMapping("/account/my-profile")
    public String handleUpdateUser(@ModelAttribute("updateUser") @Valid User updateUser,
            BindingResult newUserBindingResult,
            @RequestParam("avatarPreview") MultipartFile file,
            HttpServletRequest request) {

        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if (newUserBindingResult.hasErrors()) {
            return "client/my-account/my-profile";
        }

        User currentUser = this.userService.findById(updateUser.getId());
        if (currentUser != null) {
            String avatar = "";

            currentUser.setFullName(updateUser.getFullName());
            currentUser.setPhoneNumber(updateUser.getPhoneNumber());
            if (!file.isEmpty()) {
                avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(avatar);
            }

            this.userService.handleSaveUser(currentUser);

            //update session
            HttpSession session = request.getSession(false);
            session.setAttribute("fullName", currentUser.getFullName());
            session.setAttribute("avatar", currentUser.getAvatar());
        }

        return "redirect:/";
    }

}
