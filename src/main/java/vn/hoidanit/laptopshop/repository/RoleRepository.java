package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.hoidanit.laptopshop.domain.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {

    public Role findByName(String name);
}
