package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;
import java.util.List;


// crud: create, read, update, delete
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @SuppressWarnings("unchecked")
    User save(User hoidanit);

    List<User> findByEmailAndAddress(String email, String address);

    User findById(long id);

    User findByEmail(String email);

    User findTop1ByEmail(String email);

    void deleteById(long id);

    boolean existsByEmail(String email);

    long count();
}
