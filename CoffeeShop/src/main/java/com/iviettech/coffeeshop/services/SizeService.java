/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.SizeEntity;
import com.iviettech.coffeeshop.repositories.SizeRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author PC
 */
@Service
public class SizeService {
    @Autowired
    private SizeRepository sizeRepository;
    
    public List<SizeEntity> findSizes(){
        return (List<SizeEntity>) sizeRepository.findAll();
    }
    public SizeEntity findSize(int id){
        return (SizeEntity) sizeRepository.findOne(id);
    }
}
