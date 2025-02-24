package vn.hoidanit.laptopshop.service.specification;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.Predicate;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;

public class ProductSpecs {

    // public static Specification<Product> nameLike(String name) {
    //     return (root, query, createriaBuilder) -> {
    //         return createriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    //     };
    // }

    // // for factory and use purpose(mục đích sử dụng)
    // public static Specification<Product> filterByFactory(String factory) {
    //     return (root, query, createriaBuilder) -> {
    //         return createriaBuilder.equal(root.get(Product_.FACTORY), factory);
    //     };
    // }

    // public static Specification<Product> filterByPrice(double start, double end) {
    //     return (root, query, createriaBuilder) -> {
    //         return createriaBuilder.between(root.get(Product_.PRICE), start, end);
    //     };
    // }

    // public static Specification<Product> filterByPriceAndFactory(String factory, double start, double end) {
    //     return (root, query, createriaBuilder) -> {
    //         List<Predicate> predicates = new ArrayList<>();
    //         Predicate equal1 = createriaBuilder.equal(root.get(Product_.FACTORY), factory);
    //         predicates.add(equal1);
    //         Predicate equal2 = createriaBuilder.between(root.get(Product_.PRICE), start, end);
    //         predicates.add(equal2);

    //         return createriaBuilder.or(predicates.toArray(new Predicate[0]));
    //     };
    // }

    // case 1
    public static Specification<Product> minPrice(double min) {
        return (root, query, createriaBuilder) -> {
            return createriaBuilder.greaterThan(root.get(Product_.PRICE), min);
        };
    }

    // case 2
    public static Specification<Product> maxPrice(double max) {
        return (root, query, createriaBuilder) -> {
            return createriaBuilder.lessThan(root.get(Product_.PRICE), max);
        };
    }


    // case 3
    public static Specification<Product> matchFactory(String factory) {
        return (root, query, createriaBuilder) -> {
            return createriaBuilder.equal(root.get(Product_.FACTORY), factory);
        };
    }


    // case 4
    public static Specification<Product> matchListFactory(List<String> factory) {
        return (root, query, createriaBuilder) -> {
            return createriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
        };
    }

    // case 5
    public static Specification<Product> matchListPrice(List<String> prices) {
        return (root, query, createriaBuilder) -> {

            List<Predicate> predicates = new ArrayList<>();
            Predicate predicate;
            for (String price : prices) {
                if(price.equals("duoi-10-trieu")){
                    predicate = createriaBuilder.lessThan(root.get(Product_.PRICE), 10000000);
                    predicates.add(predicate);
                }
                else if(price.equals("10-toi-15-trieu")){
                    predicate = createriaBuilder.and(createriaBuilder.gt(root.get(Product_.PRICE), 10000000),
                                                createriaBuilder.le(root.get(Product_.PRICE), 15000000));
                    predicates.add(predicate);
                }
                else if(price.equals("15-toi-20-trieu")){
                    predicate = createriaBuilder.and(createriaBuilder.gt(root.get(Product_.PRICE), 15000000),
                                                createriaBuilder.le(root.get(Product_.PRICE), 20000000));
                    predicates.add(predicate);                            
                }
                else if(price.equals("tren-20-trieu")){
                    predicate = createriaBuilder.greaterThan(root.get(Product_.PRICE), 20000000);
                    predicates.add(predicate);
                }
            }
            
            return createriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

}
