/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.RoleEntity;
import com.iviettech.coffeeshop.enums.Role;
import com.iviettech.coffeeshop.repositories.RoleRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class RoleService {
    @Autowired
    RoleRepository roleRepository;
    
    public RoleEntity findRole(int id){
        return roleRepository.findOne(id);
    }
    
    public RoleEntity getRole(Role role){
        return roleRepository.findByRole(role);
    }
    
    public List<RoleEntity> findByAccountId(int id){        
        return (List<RoleEntity>) roleRepository.findByAccountId(id);
    }
    public List<RoleEntity> findAllRoles(){        
        return (List<RoleEntity>) roleRepository.findAll();
    }
}
