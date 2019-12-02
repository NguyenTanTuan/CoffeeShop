/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.ImageEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author admin
 */
@Repository
public interface ImageRepository extends CrudRepository<ImageEntity, Integer>{
    @Query(value = "SELECT DISTINCT i FROM ImageEntity i WHERE i.product.id = ?1")
    public List<ImageEntity> getImagesByProductId(int productId);
}
