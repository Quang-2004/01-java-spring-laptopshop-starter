package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.hoidanit.laptopshop.service.UserService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class UserController {
    
    @RequestMapping("/")
    public String getHomePage(){

        return "quang.html";
    }
}

// @RestController
// public class UserController {

//     // DI: dependency injection
//     private UserService userService;
    
//     public UserController(UserService userService) {
//         this.userService = userService;
//     }


//     @GetMapping("")
//     public String getHomePage(){

//         return userService.handleHello();
//     }
// }
