/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.ToppingEntity;
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
public interface ToppingRepository extends CrudRepository<ToppingEntity, Integer>{
    @Query(value = "SELECT t FROM ToppingEntity t WHERE t.id IN ?1")
    public LinkedHashSet<ToppingEntity> getToppingsByIds(List<Integer> toppingIds);
}
