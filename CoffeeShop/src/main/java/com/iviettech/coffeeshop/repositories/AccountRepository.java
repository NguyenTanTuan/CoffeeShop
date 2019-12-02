/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.AccountEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author admin
 */
@Repository
public interface AccountRepository extends CrudRepository<AccountEntity, Integer>{
    public AccountEntity findByUsernameAndPassword(String username, String password);
    public AccountEntity findByUsername(String username);
    public AccountEntity findByEmail(String email);
    public AccountEntity findByPhone(String phone);
}
