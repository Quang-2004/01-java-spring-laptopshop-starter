package vn.hoidanit.laptopshop.controller.client;


import java.util.ArrayList;
import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepositoty;
import vn.hoidanit.laptopshop.repository.CartRepositoty;
import vn.hoidanit.laptopshop.service.OrderService;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class ItemController {

    private final ProductService productService;
    private final CartRepositoty cartRepositoty;
    private final UserService userService;
    private final CartDetailRepositoty cartDetailRepositoty;
    private final OrderService orderService;

    
    public ItemController(ProductService productService, CartRepositoty cartRepositoty
    , UserService userService, CartDetailRepositoty cartDetailRepositoty,  OrderService orderService) {
        this.productService = productService;
        this.cartRepositoty = cartRepositoty;
        this.userService = userService;
        this.cartDetailRepositoty = cartDetailRepositoty;
        this.orderService = orderService;
    }

    @GetMapping("/product/{id}")
    public String getDetailProduct(Model model, @PathVariable long id) {
        Product product = this.productService.findById(id);
        
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(Model model, @PathVariable long id, 
        HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        String email = (String)session.getAttribute("email"); // username
        this.productService.handleAddProductToCart(email, id, session, 1);

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
        
        model.addAttribute("cartDetails", listCartDetail);
        model.addAttribute("totalPrice", totalPrice);

        model.addAttribute("cart", currentCart);
        return "client/cart/show";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
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
        
        model.addAttribute("cartDetails", listCartDetail);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", new Cart());
        

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request,
        @RequestParam("receiverName") String receiverName,
        @RequestParam("receiverAddress") String receiverAddress,
        @RequestParam("receiverPhone") String receiverPhone) {
        
        HttpSession session = request.getSession(false);

        this.orderService.handleSaveOrder(session, receiverName, receiverAddress, receiverPhone);
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage() {
        return "client/cart/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        // get username
        String username = (String) session.getAttribute("email");
        // get user
        User user = this.userService.findByEmail(username);

        // get Order
        List<Order> orders = this.orderService.findOrderByUser(user);
        if(orders != null){
            model.addAttribute("orders", orders);
        }
        return "client/cart/order-history";
    }
    
    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
        @RequestParam("id") long id,
        @RequestParam("quantity") long quantity,
        HttpServletRequest request
        ) {

        HttpSession session = request.getSession(false);

        String email = (String)session.getAttribute("email"); // username
        this.productService.handleAddProductToCart(email, id, session, quantity);

        return "redirect:/product/" + id;
    }

}
