/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.security;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 *
 * @author admin
 */
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication a) throws IOException, ServletException {
        response.setStatus(HttpServletResponse.SC_OK);
        
        boolean admin = false;
        boolean seller = false;
        
        for (GrantedAuthority auth : a.getAuthorities()) {
            if (auth.getAuthority().contains("ROLE_ADMIN") || auth.getAuthority().contains("ROLE_MANAGER")) {
                admin = true;
                break;
            }
            if (auth.getAuthority().contains("ROLE_SELLER")) {
                seller = true;
            }
        }        
        
        if (admin) {
            response.sendRedirect(request.getContextPath() + "/admin/");
        } else if (seller) {
            response.sendRedirect(request.getContextPath() + "/seller/");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
}
