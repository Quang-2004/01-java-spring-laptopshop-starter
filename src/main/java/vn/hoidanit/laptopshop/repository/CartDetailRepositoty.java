package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Cart;
import java.util.List;



@Repository
public interface CartDetailRepositoty extends JpaRepository<CartDetail, Long>{

        @SuppressWarnings("unchecked")
        CartDetail save(CartDetail cartDetail);

        boolean existsByCartAndProduct(Cart cart, Product product);

        List<CartDetail> findByCart(Cart cart);


        CartDetail findCartDetailByProduct(Product product);

        CartDetail findByCartAndProduct(Cart cart, Product product);

        @Transactional
        void deleteByCartAndProduct(Cart cart, Product product);

    
}