package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.hoidanit.laptopshop.domain.Product;


public interface ProductRepository extends JpaRepository<Product, Long>{
    
    Product findById(long id);

    void deleteById(long id);
}
