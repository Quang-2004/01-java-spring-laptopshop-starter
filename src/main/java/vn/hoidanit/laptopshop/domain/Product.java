package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotNull
    @NotEmpty(message = "Name không được để trống!")
    private String name;

    @NotNull
    @DecimalMin(value = "0", inclusive = false, message = "Price phải lớn hơn 0!")
    private double price;

    
    private String image;

    @NotNull
    @NotEmpty(message = "DetailDesc không được để trống!")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    @NotNull
    @NotEmpty(message = "ShortDetail không được để trống!")
    private String shortDesc;

    @NotNull()
    @DecimalMin(value = "0", inclusive = false, message = "Quantity phải lớn hơn 0!")
    private long quantity;

    private long sold;

    @NotNull()
    @NotEmpty(message = "Factory không được để trống!")
    private String factory;

    private String target;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;



    public Product() {
    }
    public Product(long id, String name, double price, String image, String detailDesc, String shortDesc, long quantity,
            long sold, String factory, String target) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.detailDesc = detailDesc;
        this.shortDesc = shortDesc;
        this.quantity = quantity;
        this.sold = sold;
        this.factory = factory;
        this.target = target;
    }
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getDetailDesc() {
        return detailDesc;
    }
    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }
    public String getShortDesc() {
        return shortDesc;
    }
    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }
    public long getQuantity() {
        return quantity;
    }
    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }
    public long getSold() {
        return sold;
    }
    public void setSold(long sold) {
        this.sold = sold;
    }
    public String getFactory() {
        return factory;
    }
    public void setFactory(String factory) {
        this.factory = factory;
    }
    public String getTarget() {
        return target;
    }
    public void setTarget(String target) {
        this.target = target;
    }
    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }
    
    

    

}
