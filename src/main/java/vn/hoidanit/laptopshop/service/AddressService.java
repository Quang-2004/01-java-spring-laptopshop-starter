package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Address;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.AddressRepository;

@Service
public class AddressService {
    private final AddressRepository addressRepository;

    public AddressService(AddressRepository addressRepository) {
        this.addressRepository = addressRepository;
    }

    public void save(Address address){
        this.addressRepository.save(address);
    }

    public List<Address> findByUser(User user){
        return this.addressRepository.findByUser(user);
    }

    public Address findByUserAndDefaultAddress(User user, boolean defaultAddress){
        return this.addressRepository.findByUserAndDefaultAddress(user, defaultAddress);
    }

    public void clearDefaultAddressesForUser(boolean defaultAddress, User user){
        Address address = findByUserAndDefaultAddress(user, defaultAddress);
        address.setDefaultAddress(false);
        this.addressRepository.save(address);
    }

    public Address findById(long id){
        return this.addressRepository.findById(id);
    }
}
