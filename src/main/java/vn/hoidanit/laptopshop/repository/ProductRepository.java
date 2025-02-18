package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import vn.hoidanit.laptopshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>{

    @SuppressWarnings("unchecked")
    Product save(Product product);
    
    Product findById(long id);

    @Transactional
    void deleteById(long id);

    long count();
}
