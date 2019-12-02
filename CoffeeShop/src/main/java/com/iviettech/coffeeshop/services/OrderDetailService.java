/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.iviettech.coffeeshop.repositories.OrderDetailRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author PC
 */
@Service
public class OrderDetailService {
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    public List<OrderDetailEntity> findByOrderId(int id){
        return (List<OrderDetailEntity>) orderDetailRepository.findByOrderId(id);
    }
}
