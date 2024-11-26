package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.RestController;


import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.RoleService;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class UserController {

    private final UserService userService;
    private final RoleService roleService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;


    public UserController(UserService userService, UploadService uploadService,
         PasswordEncoder passwordEncoder, RoleService roleService) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
        this.roleService = roleService;
    }

    // @GetMapping("/")
    // public String getHomePage(Model model){
    //     model.addAttribute("quanggggg", "test");      
    //     return "hello";
    // }

    @GetMapping("/admin/user")
    public String getUserPage(Model model) {
        List<User> listUsers = this.userService.findAllUser();
        model.addAttribute("listUsers", listUsers);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.findById(id);
        
        model.addAttribute("newUser", new User());
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUser(Model model, @PathVariable long id) {
        User currentUser = this.userService.findById(id);
        
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String updateUser(Model model, 
        @ModelAttribute("updateUser") @Valid User updateUser,
        BindingResult newUserBindingResult,
        @RequestParam("hoidanitFile") MultipartFile file) {

        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors ) {
            System.out.println (">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if(newUserBindingResult.hasErrors()){
            return "admin/user/update";
        }

        User currentUser = this.userService.findById(updateUser.getId());
        if(currentUser != null){
            String avatar = "";
            if(!file.isEmpty()){
                avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
            }

            currentUser.setAddress(updateUser.getAddress());
            currentUser.setFullName(updateUser.getFullName());
            currentUser.setPhoneNumber(updateUser.getPhoneNumber());
            currentUser.setAvatar(avatar);
            currentUser.setRole(this.roleService.findByName(updateUser.getRole().getName()));
            this.userService.handleSaveUser(currentUser);
        }
        
        System.out.println("run here");
        return "redirect:/admin/user";
    }

    @GetMapping(value = "/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping(value = "/admin/user/delete")
    public String deleteUserPage(Model model, @ModelAttribute("newUser") User user) {
        this.userService.deleteById(user.getId());
        return "redirect:/admin/user";
    }


    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model){
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUserPage(Model model, 
        @ModelAttribute("newUser") @Valid User hoidanit, 
        BindingResult newUserBindingResult,                                            
        @RequestParam("hoidanitFile") MultipartFile file
        ){

        
        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors ) {
            System.out.println (">>>>>>>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if(newUserBindingResult.hasErrors()){
            return "admin/user/create";
        }
        
        // upload file
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        
            
        String hashPassword = this.passwordEncoder.encode(hoidanit.getPassword());

        hoidanit.setAvatar(avatar);
        hoidanit.setPassword(hashPassword);
        
        
        hoidanit.setRole(this.roleService.findByName(hoidanit.getRole().getName()));
        this.userService.handleSaveUser(hoidanit);

        // link url, not link file
        return "redirect:/admin/user";
        
    }

}