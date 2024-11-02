package vn.hoidanit.laptopshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

import vn.hoidanit.laptopshop.domain.User;
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
        
        User tmp = this.userService.findById(3);
        System.out.println("noooo" + tmp);

        User tmp2 = this.userService.findFirstByEmail("zxvxcvxzvcxc@gmail.com");
        System.out.println(tmp2);

        User tmp3 = this.userService.findTop1ByEmail("zxvxcvxzvcxc@gmail.com");
        System.out.println(tmp3);

        model.addAttribute("quanggggg", "test");      
        return "hello";
    }

    @RequestMapping(value = "/admin/user", method=RequestMethod.GET)
    public String getTableUser(Model model) {
        List<User> listUsers = this.userService.findAllUser();
        model.addAttribute("listUsers", listUsers);

        return "admin/user/tableUser";
    }
    

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.GET)
    public String getUserPage(Model model){
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String submitNewUser(Model model, @ModelAttribute("newUser") User hoidanit){

        //CACH 1
        // this.userService.handleSaveUser(hoidanit);

        // List<User> listUsers = this.userService.findAllUser();
        // model.addAttribute("listUsers", listUsers);
        // return "admin/user/tableUser";

        // CACH 2
        this.userService.handleSaveUser(hoidanit);
        // link url, not link file
        return "redirect:/admin/user";
        
    }
    
    // delete User
    // @RequestMapping(value = "/admin/user/deleteUser", method = RequestMethod.GET)
    // public String deleteUser(Model model, @ModelAttribute("idUser") long idUser){
    //     this.userService.deleteById(idUser);
    //     return "admin/user/tableUser";
    // }

    // view User
    @RequestMapping(value = "/admin/user/informationUser", method = RequestMethod.GET)
    public String informationUser(Model model, @ModelAttribute("idUser") String id){
        long idUser = Long.parseLong(id);
        System.out.println("zmdfnbdfbskdfb" + idUser);
        User user = this.userService.findById(idUser);
        model.addAttribute("user", user);
        return "admin/user/viewUser";
    }

    // update User
    // @RequestMapping(value = "/admin/user/informationUser", method = RequestMethod.GET)
    // public String updateUser(Model model, @ModelAttribute("idUser") long idUser){
    //     User user = this.userService.findById(idUser);
    //     this.userService.updateUser(user);
    //     return "admin/user/tableUser";
    // }

}