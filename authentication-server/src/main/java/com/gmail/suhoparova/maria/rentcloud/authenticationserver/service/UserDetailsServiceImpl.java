package com.gmail.suhoparova.maria.rentcloud.authenticationserver.service;

import com.gmail.suhoparova.maria.rentcloud.authenticationserver.model.AuthUserDetails;
import com.gmail.suhoparova.maria.rentcloud.authenticationserver.model.User;
import com.gmail.suhoparova.maria.rentcloud.authenticationserver.repository.UserDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.security.authentication.AccountStatusUserDetailsChecker;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.jnlp.IntegrationService;
import java.util.Optional;

@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private UserDetailsRepository userDetailsRepository;

    @Override
    public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
        Optional<User> userOptional = userDetailsRepository.findByUsername(name);
        UserDetails userDetails = new AuthUserDetails(userOptional.orElseThrow(
                () -> new UsernameNotFoundException("Username or password are wrong")
        ));
        new AccountStatusUserDetailsChecker().check(userDetails);
        return userDetails;
    }
}
