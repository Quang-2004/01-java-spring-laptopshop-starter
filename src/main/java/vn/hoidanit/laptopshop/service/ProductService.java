package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepositoty;
import vn.hoidanit.laptopshop.repository.CartRepositoty;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {
    
    private final ProductRepository productRepository;
    private final CartRepositoty cartRepositoty;
    private final CartDetailRepositoty cartDetailRepositoty;
    private final UserService userService;

    

    public ProductService(ProductRepository productRepository, CartRepositoty cartRepositoty,
            CartDetailRepositoty cartDetailRepositoty, UserService userService) {
        this.productRepository = productRepository;
        this.cartRepositoty = cartRepositoty;
        this.cartDetailRepositoty = cartDetailRepositoty;
        this.userService = userService;
    }

    public Page<Product> findAllProducts(Pageable page){
        return this.productRepository.findAll(page);
    }

    public Product findById(long id){
        return this.productRepository.findById(id);
    }

    public void deleteById(long id){
        this.productRepository.deleteById(id);
    }

    public Product handleSaveProduct(Product product){
        return this.productRepository.save(product);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity){
        
        User user = this.userService.findByEmail(email);
        if(user != null){
            // check user đã có cart chưa, nếu chưa thì tạo mới
            Cart cart = this.cartRepositoty.findCartByUser(user);
            if(cart == null){
                // create new cart
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);
                
                // save cart
                cart = this.cartRepositoty.save(otherCart);

            }

            // find product by findById
            Optional<Product> productOptional = Optional.ofNullable(this.productRepository.findById(productId));
            if(productOptional.isPresent()){
                Product realProduct = productOptional.get();

                // check từng sản phẩm đã đuơc thêm vào trước đó chưa
                CartDetail oldCartDetail = this.cartDetailRepositoty.findByCartAndProduct(cart, realProduct);

                if(oldCartDetail == null){
                    // set information cart_detail
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(realProduct);
                    cartDetail.setPrice(realProduct.getPrice());
                    cartDetail.setQuantity(quantity);
                    this.cartDetailRepositoty.save(cartDetail);

                    // update sum
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepositoty.save(cart); 
                    session.setAttribute("sum", s);
                }
                else{
                    oldCartDetail.setQuantity(oldCartDetail.getQuantity() + quantity);
                    this.cartDetailRepositoty.save(oldCartDetail);
                }
            }
        }  
    }

    public void handleDeleteProductToCart(String email, long cartDetailId, HttpSession session){
        User user = this.userService.findByEmail(email);

        Cart cart = this.cartRepositoty.findCartByUser(user);
        // find product by findById
        Optional<CartDetail> cartDetailOptional = Optional.ofNullable(this.cartDetailRepositoty.findById(cartDetailId));
        if(cartDetailOptional.isPresent()){
            CartDetail realCartDetail= cartDetailOptional.get();

            // delete product 
            this.cartDetailRepositoty.deleteById(realCartDetail.getId());


            // update cart
            int s = cart.getSum();

            cart.setSum(s - 1);
            this.cartRepositoty.save(cart);
            session.setAttribute("sum", s - 1);
              
        }
    }

    public void handleClearCart(HttpSession session){
        String username = (String) session.getAttribute("email");
        User user = this.userService.findByEmail(username);

        Cart cart = this.cartRepositoty.findCartByUser(user);
        
        List<CartDetail> cartDetails = this.cartDetailRepositoty.findByCart(cart);
        for (CartDetail cartDetail : cartDetails) {
            this.cartDetailRepositoty.delete(cartDetail);
        }
        // update cart

        cart.setSum(0);
        this.cartRepositoty.save(cart);
        session.setAttribute("sum", 0);
              
        
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails){
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = Optional.ofNullable(this.cartDetailRepositoty.findById(cartDetail.getId()));
            if(cdOptional.isPresent()){
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepositoty.save(currentCartDetail);
            }
        }    
    }

    public long count(){
        return this.productRepository.count();
    }
}

    
