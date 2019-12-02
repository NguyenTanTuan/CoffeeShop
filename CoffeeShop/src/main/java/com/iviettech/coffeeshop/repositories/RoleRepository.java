/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.RoleEntity;
import com.iviettech.coffeeshop.enums.Role;
import java.util.LinkedHashSet;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author admin
 */
@Repository
public interface RoleRepository extends CrudRepository<RoleEntity, Integer>{
    public RoleEntity findByRole(Role role);
    
    @Query(value = "SELECT r FROM RoleEntity r JOIN r.accounts a WHERE a.id = ?1")
    public LinkedHashSet<RoleEntity> findByAccountId(int id);
}
