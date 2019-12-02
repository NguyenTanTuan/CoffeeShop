/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.controller.UserController;
import com.iviettech.coffeeshop.entities.VoteEntity;
import com.iviettech.coffeeshop.repositories.VoteRepository;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.aop.AopInvocationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class VoteService {
    @Autowired
    private VoteRepository voteRepository;
    
    public VoteEntity addVote(VoteEntity vote){
        try{
            int voteId = voteRepository.getVoteIdByAccountAndProductId(vote.getAccount().getId(), vote.getProduct().getId());
            vote.setId(voteId);
        }catch (Exception ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return voteRepository.save(vote);
    }
    
    public double getAverageStar(int productId){
        return voteRepository.getAverageStarByProductId(productId);
    }
}
