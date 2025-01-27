package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface CartRepositoty extends JpaRepository<Cart, Long>{

    @SuppressWarnings("unchecked")
    Cart save(Cart cart);
    
    Cart findByUser(User user);
} 
