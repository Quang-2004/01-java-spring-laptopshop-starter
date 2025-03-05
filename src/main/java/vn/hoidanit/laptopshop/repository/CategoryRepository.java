package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long>{
    Category findByName(String name);
}
