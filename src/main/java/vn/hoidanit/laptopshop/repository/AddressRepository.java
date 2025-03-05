package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Address;
import vn.hoidanit.laptopshop.domain.User;

import java.util.List;


@Repository
public interface AddressRepository extends JpaRepository<Address, Long>{
    @SuppressWarnings("unchecked")
    Address save(Address address);

    List<Address> findByUser(User user);

    Address findByUserAndDefaultAddress(User user, boolean defaultAddress);

    Address findById(long id);
}
