/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.FavoriteEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author admin
 */
@Repository
public interface FavoriteRepository extends CrudRepository<FavoriteEntity, Integer>{
    @Query(value = "SELECT f.id FROM FavoriteEntity f WHERE f.account.id = ?1 AND f.product.id = ?2")
    public int getFavoriteIdByAccountAndProductId(int accountId, int productId);
    
    @Query(value = "SELECT f FROM FavoriteEntity f WHERE f.account.id = ?1 AND f.product.id = ?2")
    public FavoriteEntity getFavoritesByAccountIdAndProductId(int accountId, int productId);
}
