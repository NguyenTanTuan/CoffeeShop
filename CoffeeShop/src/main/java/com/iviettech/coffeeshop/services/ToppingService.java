/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.ToppingEntity;
import com.iviettech.coffeeshop.repositories.ToppingRepository;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class ToppingService {
    @Autowired
    private ToppingRepository toppingRepository;
    
    public Set<ToppingEntity> findToppings(){
        Set<ToppingEntity> toppings = new LinkedHashSet<>((List<ToppingEntity>)toppingRepository.findAll());
        return toppings;
    }
    
    public Set<ToppingEntity> getToppingsByIds(List<Integer> toppingIds){
        return toppingRepository.getToppingsByIds(toppingIds);
    }
}
