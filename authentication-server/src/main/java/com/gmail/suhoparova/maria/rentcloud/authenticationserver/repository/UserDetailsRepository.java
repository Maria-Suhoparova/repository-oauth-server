package com.gmail.suhoparova.maria.rentcloud.authenticationserver.repository;

import com.gmail.suhoparova.maria.rentcloud.authenticationserver.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.jws.soap.SOAPBinding;
import java.util.Optional;

@Repository
public interface UserDetailsRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String name);
}
