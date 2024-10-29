package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class UserService {
    
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> findAllUser(){
        return this.userRepository.findAll();
    }

    public List<User> getAllUsersByEmail(){
        return this.userRepository.findAll();
    }

    public List<User> findByEmailAndAddress(String email, String address){
        return userRepository.findByEmailAndAddress(email, address);
    }

    public User handleSaveUser(User user){
        return userRepository.save(user);
    }
}
