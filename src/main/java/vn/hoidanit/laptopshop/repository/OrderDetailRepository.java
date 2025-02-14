package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import java.util.List;


@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long>{
    @SuppressWarnings("unchecked")
    OrderDetail save(OrderDetail orderDetail);

    List<OrderDetail> findByOrder(Order order);

    @Transactional
    void deleteByOrder(Order order);
    
}
