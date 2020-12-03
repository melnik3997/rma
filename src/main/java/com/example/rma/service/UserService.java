package com.example.rma.service;

import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String userName)
            throws UsernameNotFoundException {
        return userRepo.findByUsername(userName);
    }

    public boolean addUser(User user){
        User userFromDb =  userRepo.findByUsername(user.getUsername());

        if(userFromDb != null) {
            return false;
        }
        user.setActive(true);
        user.setRole(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        userRepo.save(user);

        sendMailActivation(user);

        return true;

    }

    public void sendMailActivation(User user) {
        if(!StringUtils.isEmpty(user.getEmail())){
            String message = String.format(
                    "Hello %s! \n"+
                            " http://localhost:8080/activate/%s",
                    user.getUsername(), user.getActivationCode()

            );
            mailSender.send(user.getEmail(), "Activation code RMA", message);

        }
    }

    public boolean activateUser(String code) {
        User user =  userRepo.findByActivationCode(code);

        if (user == null){
            return false;
        }
        user.setActivationCode(null);
        userRepo.save(user);

        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();

    }

    public void editUser(User user, Map<String, String> form, String username) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRole().clear();

        for (String key : form.keySet()) {
            if(roles.contains(key)){
                user.getRole().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String email) {

        String userEmail = user.getEmail();

        boolean isChange = (email != null && !email.equals(userEmail)) ||
                (userEmail != null && !userEmail.equals(email));

        if(isChange){
            user.setEmail(email);
            if(!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if(!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        userRepo.save(user);
        if(isChange) {
            sendMailActivation(user);
        }

    }
}
