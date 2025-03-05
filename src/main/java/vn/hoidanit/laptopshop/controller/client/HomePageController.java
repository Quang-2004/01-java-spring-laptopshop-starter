package vn.hoidanit.laptopshop.controller.client;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
import vn.hoidanit.laptopshop.domain.Address;
import vn.hoidanit.laptopshop.domain.Category;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.service.AddressService;
import vn.hoidanit.laptopshop.service.CategoryService;
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
    private final CategoryService categoryService;
    private final AddressService addressService;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder,
            RoleService roleService, UploadService uploadService, CategoryService categoryService,
            AddressService addressService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.roleService = roleService;
        this.uploadService = uploadService;
        this.categoryService = categoryService;
        this.addressService = addressService;
    }

    @GetMapping("/")
    public String getHomePage(
            Model model,
            HttpServletRequest request,
            @RequestParam("page") Optional<String> pageOptional,
            @RequestParam("categoryName") Optional<String> categoryNameOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // TODO: handle exception
        }

        String categoryName = categoryNameOptional.isPresent() ? categoryNameOptional.get() : "";
        Category category = this.categoryService.findByName(categoryName);

        Pageable pageable = PageRequest.of(page - 1, 12);
        Page<Product> prs = this.productService.findAllProductsByCategoryWithSpec(pageable, category);

        List<Product> products = prs.getContent();

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
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

            // update session
            HttpSession session = request.getSession(false);
            session.setAttribute("fullName", currentUser.getFullName());
            session.setAttribute("avatar", currentUser.getAvatar());
        }

        return "redirect:/";
    }

    @GetMapping("/account/add-address")
    public String getAddAddressPage(Model model) {
        Address address = new Address();
        address.setDefaultAddress(false);
        model.addAttribute("address", address);
        return "client/my-account/address";
    }

    @PostMapping("/account/add-address")
    public String handleSaveAddress(
            Model model,
            @Valid @ModelAttribute("address") Address address,
            BindingResult newAddressBindingResult,
            HttpServletRequest request) {

        List<FieldError> errors = newAddressBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if (newAddressBindingResult.hasErrors()) {
            return "client/my-account/address";
        }

        // get User
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("email");
        User currentUser = this.userService.findByEmail(username);

        // check address
        List<Address> addresses = this.addressService.findByUser(currentUser);
        if(addresses.size() == 0){
            address.setDefaultAddress(true);
        }
        else if (addresses.size() > 0){
            if(address.isDefaultAddress()){ // true
                // reset DefaultAddress
                for (Address address2 : addresses) {
                    address2.setDefaultAddress(false);
                }
            }
        }

        // save address
        address.setUser(currentUser);
        this.addressService.save(address);
        
        String redirectTo = (String) session.getAttribute("redirectTo");
        if(redirectTo.equals("/checkout")){
            return "redirect:" + redirectTo;
        }
        else if(redirectTo.equals("/account/change-address")){
            return "redirect:" + redirectTo;
        }
        return "redirect:/checkout";
    }

    @GetMapping("/account/change-address")
    public String getChangeAddressPage(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("email");
        User currentUser = this.userService.findByEmail(username);

        // get address
        Address myAddress = this.addressService.findByUserAndDefaultAddress(currentUser, true);
        List<Address> addresses = this.addressService.findByUser(currentUser);
        

        // add redirect after add-address 
        session.setAttribute("redirectTo", "/account/change-address");


        model.addAttribute("myAddress", myAddress);
        model.addAttribute("addresses", addresses);
        return "client/my-account/change-address";
    }


    @GetMapping("/account/update-address")
    public String getUpdateAddresPage(Model model, @RequestParam("id") Optional<String> IdOpional) {
        long id = IdOpional.isPresent() ? Long.parseLong(IdOpional.get()) : 0;
        Address address = this.addressService.findById(id);
        model.addAttribute("updateAddress", address);
        return "client/my-account/update-address";
    }
    

    @PostMapping("/account/update-address")
    public String handleUpdateAddress(
        Model model,
        @Valid @ModelAttribute("updateAddress") Address updateAddress,
        BindingResult newAddressBindingResult,
        HttpServletRequest request) {
        
            
            List<FieldError> errors = newAddressBindingResult.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println(">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
            }
    
            // validate
            if (newAddressBindingResult.hasErrors()) {
                return "client/my-account/update-address";
            }

            Address currentAddress = this.addressService.findById(updateAddress.getId());
            if(updateAddress != null){
                currentAddress.setReceiverAddress(updateAddress.getReceiverAddress());
                currentAddress.setDefaultAddress(updateAddress.isDefaultAddress());
                currentAddress.setReceiverName(updateAddress.getReceiverName());
                currentAddress.setReceiverPhone(updateAddress.getReceiverPhone());

                // save 
                this.addressService.save(currentAddress);
            }
        
        return "redirect:/checkout";
    }
    
    @PostMapping("/account/change-default-address")
    public String handleChangeDefaultAddress(@RequestParam("id") Optional<String> IdOpional, HttpServletRequest request) {
        
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("email");
        User currentUser = this.userService.findByEmail(username);

        //reset defaultAddress of user
        this.addressService.clearDefaultAddressesForUser(true, currentUser);
        long id = IdOpional.isPresent() ? Long.parseLong(IdOpional.get()) : 0;
        Address address = this.addressService.findById(id);
        address.setDefaultAddress(true);
        this.addressService.save(address);

        return "redirect:/checkout";
    }
    
    

}
