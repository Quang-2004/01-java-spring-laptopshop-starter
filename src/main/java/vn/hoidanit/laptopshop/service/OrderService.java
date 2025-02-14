package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;


import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepositoty;
import vn.hoidanit.laptopshop.repository.CartRepositoty;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final ProductService productService; 
    private final CartRepositoty cartRepositoty;
    private final CartDetailRepositoty cartDetailRepositoty;
    private final OrderDetailRepository orderDetailRepository;


    public OrderService(OrderRepository orderRepository, 
        UserRepository userRepository, 
        ProductService productService,
        CartRepositoty cartRepositoty,
        CartDetailRepositoty cartDetailRepositoty,
        OrderDetailRepository orderDetailRepository) {


        this.orderRepository = orderRepository;
        this.userRepository = userRepository;
        this.productService = productService;
        this.cartRepositoty = cartRepositoty;
        this.cartDetailRepositoty = cartDetailRepositoty;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Order> findOrderByUser(User user){
        return this.orderRepository.findOrderByUser(user);
    }


    public List<Order> findAll(){
        return this.orderRepository.findAll();
    }

    public void handleSaveOrder(HttpSession session, 
        String receiverName, 
        String receiverAddress,
        String receiverPhone){
        
        // get user
        String username = (String) session.getAttribute("email");
        User currentUser = this.userRepository.findByEmail(username);

        
        Cart cart = this.cartRepositoty.findCartByUser(currentUser);
        if(cart != null){
            List<CartDetail> CartDetails =  this.cartDetailRepositoty.findByCart(cart);
       
        double totalPrice = 0;
        for (CartDetail cd : CartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        Order order = new Order();

        order.setTotalPrice(totalPrice);
        order.setUser(currentUser);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReveiverAddress(receiverAddress);
        order.setStatus("PENDING");

        // save Order
        order = this.orderRepository.save(order);

        
        // add OrderDetail
        handleSaveOrderDetails(cart, order, CartDetails, session);
        }
        

    }

    public void handleSaveOrderDetail(Cart cart, Order order, long productID){
        // create orderDetail
        OrderDetail orderDetail = new OrderDetail();

        Product product = this.productService.findById(productID);
        Optional<CartDetail> cartDetailOptional = Optional.ofNullable(this.cartDetailRepositoty.findByCartAndProduct(cart, product));
        if(cartDetailOptional.isPresent()){
            CartDetail cartDetail = cartDetailOptional.get();

            orderDetail.setPrice(product.getPrice());
            orderDetail.setQuantity(cartDetail.getQuantity());
            orderDetail.setOrder(order);
            orderDetail.setProduct(product);

            // save orderDetail
            this.orderDetailRepository.save(orderDetail);

            // tru ton kho
            Product productInventory = this.productService.findById(productID); // san pham trong kho
            productInventory.setQuantity(productInventory.getQuantity() - product.getQuantity());
            productInventory.setSold(productInventory.getSold() + product.getQuantity());
            // save
            this.productService.handleSaveProduct(productInventory);
        }

        
    }

    public void handleSaveOrderDetails(Cart cart, Order order, List<CartDetail> CartDetails, HttpSession session){

        for (CartDetail cartDetail : CartDetails) {
            handleSaveOrderDetail(cart, order, cartDetail.getProduct().getId());
        }

        // delete cartDetail and cart
        this.productService.handleClearCart(session);

    }

    public List<OrderDetail> findByOrder(Order order){
        return this.orderDetailRepository.findByOrder(order);
    }

    public Order findById(long id){
        return this.orderRepository.findById(id);
    }

    public Order handleSaveOrder(Order order){
        return this.orderRepository.save(order);
    }

    public void deleteById(long id){
        this.orderRepository.deleteById(id);
    }

    public void deleteByOrder(Order order){
        this.orderDetailRepository.deleteByOrder(order);
    }

    public long count(){
        return this.orderRepository.count();
    }
}
