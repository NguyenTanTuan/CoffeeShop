/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.security;

import com.iviettech.coffeeshop.entities.AccountEntity;
import com.iviettech.coffeeshop.entities.RoleEntity;
import com.iviettech.coffeeshop.services.AccountService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 *
 * @author admin
 */
public class CustomAuthenticationProvider implements AuthenticationProvider{
    @Autowired
    private AccountService accountService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Authentication authenticate(Authentication a) throws AuthenticationException {
        String username = a.getName().trim();
        String password = a.getCredentials().toString().trim();
        
        if (!username.isEmpty() && !password.isEmpty()) {
            AccountEntity account = accountService.findAccount(username);
            if (account != null && account.getId() > 0 && passwordEncoder.matches(password, account.getPassword())) {
                List<GrantedAuthority> roles = new ArrayList<>();
                for (RoleEntity role : account.getRoles()) {
                    roles.add(
                            new SimpleGrantedAuthority(role.getRole().toString().trim())
                    );
                }
                return new UsernamePasswordAuthenticationToken(account, account.getUsername(), roles);
            } else {
                return null;
            }
            
        } else {
            return null;
        }
    }

    @Override
    public boolean supports(Class<?> type) {
        return type.equals(UsernamePasswordAuthenticationToken.class);
    }
}
