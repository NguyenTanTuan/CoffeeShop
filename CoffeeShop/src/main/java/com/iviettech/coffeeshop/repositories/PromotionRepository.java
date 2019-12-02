/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.PromotionEntity;
import java.util.Date;
import java.util.Set;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author admin
 */
@Repository
public interface PromotionRepository extends CrudRepository<PromotionEntity, Integer>{
    @Query(value = "SELECT pr FROM PromotionEntity pr INNER JOIN pr.products p "
            + "WHERE p.id = ?1 AND pr.endDate >= ?2 AND pr.startDate <= ?2")
    public Set<PromotionEntity> getPromotionsByProductId(int id, Date now);
    
    @Query(value = "SELECT pr FROM PromotionEntity pr WHERE pr.endDate >= ?1 AND pr.startDate <= ?1 AND pr.status = true")
    public Set<PromotionEntity> getPromotionsAvailable(Date now);
}
