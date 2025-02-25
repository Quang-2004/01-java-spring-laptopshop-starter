package vn.hoidanit.laptopshop.service.specification;


import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.Predicate;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;

public class ProductSpecs {

    public static Specification<Product> nameLike(String name) {
        return (root, query, createriaBuilder) -> {
            return createriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
        };
    }

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

    public static Specification<Product> matchListTarget(List<String> target) {
        return (root, query, createriaBuilder) -> {
            return createriaBuilder.in(root.get(Product_.TARGET)).value(target);
        };
    }


    // case 5
    public static Specification<Product> matchPrice(String price) {
        return (root, query, createriaBuilder) -> {
            
            double min = 0, max = 0;
            switch (price) {
                case "duoi-10-trieu":
                    min = 0;
                    max = 10000000;
                    break;
                case "10-toi-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-toi-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "tren-20-trieu":
                    min = 20000000;
                    max = 200000000;
                    break;
                // and more case as needed
            }
            if(min != 0 && max != 0){
                return createriaBuilder.between(root.get(Product_.PRICE), min, max);
            }
            return null;

           
        };
    }

    // case 6
    public static Specification<Product> matchListPrice(List<String> prices) {
        return (root, query, createriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            Predicate predicate;
            for (String price : prices) {
                double min = 0, max = 0;
                switch (price) {
                    case "duoi-10-trieu":
                        min = 0;
                        max = 10000000;
                        break;
                    case "10-toi-15-trieu":
                        min = 10000000;
                        max = 15000000;
                        break;
                    case "15-toi-20-trieu":
                        min = 15000000;
                        max = 20000000;
                        break;
                    case "tren-20-trieu":
                        min = 20000000;
                        max = 200000000;
                        break;
                    // and more case as needed
                }
                if(min != 0 && max != 0){
                    predicate = createriaBuilder.between(root.get(Product_.PRICE), min, max);
                    predicates.add(predicate); 
                }
                
            }
            
            return createriaBuilder.or(predicates.toArray(new Predicate[0]));
        };
    }

    

}
