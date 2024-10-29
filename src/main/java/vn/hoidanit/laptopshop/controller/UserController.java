package vn.hoidanit.laptopshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.RequestMethod;



// import vn.hoidanit.laptopshop.service.UserService;

// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model){
        List<User> arrUsers = this.userService.findAllUser();
        System.out.println(arrUsers);

        List<User> arrEmailAndAddress = this.userService.findByEmailAndAddress("zxvxcvxzvcxc@gmail.com", "234");
        System.out.println(arrEmailAndAddress);

        
        model.addAttribute("quanggggg", "test");      
        return "hello";
    }

    @RequestMapping(value = "/admin/user", method = RequestMethod.GET)
    public String getUserPage(Model model){
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String submitNewUser(Model model, @ModelAttribute("newUser") User hoidanit){
        System.out.println("run here " + hoidanit.toString());
        this.userService.handleSaveUser(hoidanit);
        return "hello";
    }
    

}