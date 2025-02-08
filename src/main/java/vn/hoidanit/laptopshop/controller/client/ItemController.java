package vn.hoidanit.laptopshop.controller.client;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepositoty;
import vn.hoidanit.laptopshop.repository.CartRepositoty;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class ItemController {

    private final ProductService productService;
    private final CartRepositoty cartRepositoty;
    private final UserService userService;
    private final CartDetailRepositoty cartDetailRepositoty;

    
    public ItemController(ProductService productService, CartRepositoty cartRepositoty
    , UserService userService, CartDetailRepositoty cartDetailRepositoty) {
        this.productService = productService;
        this.cartRepositoty = cartRepositoty;
        this.userService = userService;
        this.cartDetailRepositoty = cartDetailRepositoty;
    }

    @GetMapping("/product/{id}")
    public String getDetailProduct(Model model, @PathVariable long id) {
        Product product = this.productService.findById(id);
        
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(Model model, @PathVariable long id, HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        String email = (String)session.getAttribute("email"); // username
        this.productService.handleAddProductToCart(email, id, session);

        return "redirect:/";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartProduct(Model model, @PathVariable long id, HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        String email = (String)session.getAttribute("email"); // username
        this.productService.handleDeleteProductToCart(email, id, session);

        return "redirect:/cart";
    }

    
    @GetMapping("/cart")
    public String getCartDetailPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        String email = (String)session.getAttribute("email"); // username
        // get user
        User currentUser = this.userService.findByEmail(email);
        // get cart
        Cart currentCart = this.cartRepositoty.findCartByUser(currentUser);
        List<CartDetail> listCartDetail =  this.cartDetailRepositoty.findByCart(currentCart);
       
        double totalPrice = 0;
        for (CartDetail cd : listCartDetail) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        
        model.addAttribute("listCartDetail", listCartDetail);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/show";
    }
}
