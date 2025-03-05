package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "addresses")
public class Address {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long id;

    @NotNull
    @Size(min = 2, message = "Tên quá ngắn. Yêu cầu tối thiểu 2 ký tự!")
    private String receiverName;

    @NotNull
    @Size(min=0,max=10, message = "Số điện thoại không hợp lệ!")
    @Pattern(regexp = "^$|^\\d{10}$", message = "Số điện thoại không hợp lệ!")
    private String receiverPhone;

    @NotNull
    @Size(min = 5, message = "Địa chỉ quá ngắn!")
    private String receiverAddress;

    private String typeAddress;

    private boolean defaultAddress;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    
    public Address() {
    }

    public Address(long id, String receiverName, String receiverPhone, String receiverAddress, String typeAddress, boolean defaultAddress) {
        this.id = id;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.receiverAddress = receiverAddress;
        this.typeAddress = typeAddress;
        this.defaultAddress = defaultAddress;
    }
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getReceiverName() {
        return receiverName;
    }
    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }
    public String getReceiverPhone() {
        return receiverPhone;
    }
    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }
    public String getReceiverAddress() {
        return receiverAddress;
    }
    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }
    public String getTypeAddress() {
        return typeAddress;
    }
    public void setTypeAddress(String typeAddress) {
        this.typeAddress = typeAddress;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public boolean isDefaultAddress() {
        return defaultAddress;
    }

    public void setDefaultAddress(boolean defaultAddress) {
        this.defaultAddress = defaultAddress;
    }

    
    
}
