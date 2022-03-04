package com.example.rma.service;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.UserDto;
import com.example.rma.repository.InstitutionRepo;
import com.example.rma.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.persistence.EntityManager;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private MailSender mailSender;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private InstitutionRepo institutionRepo;

    @Override
    public UserDetails loadUserByUsername(String userName)
            throws UsernameNotFoundException {
        return userRepo.findByUsername(userName);
    }

    public Institution findInstitutionByUser(User user){
        return institutionRepo.findByUser(user);
    }

    public boolean addUser(User user){
        if (checkUserName(user.getUsername()))
            return false;

        user.setActive(true);
        user.setRole(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);
        //TODO  отправка почты
       /* if(!StringUtils.isEmpty(user.getEmail())) {
            sendMailActivation(user);
        }*/
        return true;

    }

    public List<Institution> getByEnterprise(Enterprise enterprise){

        return institutionRepo.findByEnterprise(enterprise);
    }

    public boolean checkUserName(String userName) {
        User userFromDb =  userRepo.findByUsername(userName);

        if(userFromDb != null) {
            return true;
        }
        return false;
    }

    public Map<String, String> addUserForAdmin(String userName, String email){
        Map<String, String> send = new HashMap<>();

        if(StringUtils.isEmpty(userName)){
            send.put("userNameError", "Имя пользователя не должно быть пустым");
        }
        if(StringUtils.isEmpty(email)){
            send.put("emailError", "Email не должен быть пустым");
        }
        if(checkUserName(userName))
            send.put("userNameError", "Пользователь с таким имененм уже есть");

        if(send.size() == 0){
           User user =  new User(userName,"123456",email );
           boolean result = addUser(user);
           if(!result){
               send.put("errorCreate", "Ошибка создания пользователя");
           }
        }
        return send;
    }

    public void sendMailActivation(User user) {

        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Hello %s! \n" +
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

    public Page<UserDto> findAllUserDto(Pageable pageable) {
        return userRepo.findUserDto(pageable);

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
            user.setPassword(passwordEncoder.encode(password));
        }

        userRepo.save(user);
        if(isChange) {
            sendMailActivation(user);
        }

    }
    public String getCurrentUsername() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getName();
    }

    public User getCurrentUser(){
        String userName = getCurrentUsername();
        return userRepo.findByUsername(userName);
    }
}
