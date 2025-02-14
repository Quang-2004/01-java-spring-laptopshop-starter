package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>{
    
    @SuppressWarnings("unchecked")
    Order save(Order order);

    Order findOrderByUser(User user);

    Order findById(long id);

    @Transactional
    void deleteById(long id);

    long count();
} 