package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Cart;


@Repository
public interface CartDetailRepositoty extends JpaRepository<CartDetail, Long>{

        @SuppressWarnings("unchecked")
        CartDetail save(CartDetail cartDetail);

        long countProductByCart(Cart cart);
    
}