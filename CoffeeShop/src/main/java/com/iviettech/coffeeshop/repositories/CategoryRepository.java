/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.CategoryEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
<<<<<<< HEAD
 * @author PC
 */
@Repository
public interface CategoryRepository extends
        CrudRepository<CategoryEntity, Integer>{
    @Query(value = "SELECT c FROM CategoryEntity c where c.status = true")
    public List<CategoryEntity> getCategoryByStatus();
}