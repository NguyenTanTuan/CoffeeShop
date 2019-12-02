/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.controller.UserController;
import com.iviettech.coffeeshop.entities.FavoriteEntity;
import com.iviettech.coffeeshop.repositories.FavoriteRepository;
import java.util.List;
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
public class FavoriteService {

    @Autowired
    private FavoriteRepository favoriteRepository;
    
    public FavoriteEntity getFavoritesByAccountIdAndProductId(int accountId, int productId){
        return favoriteRepository.getFavoritesByAccountIdAndProductId(accountId, productId);
    }
    
    public FavoriteEntity addFavorite(FavoriteEntity favorite) {
        try {
            int id = favoriteRepository.getFavoriteIdByAccountAndProductId(favorite.getAccount().getId(), favorite.getProduct().getId());
            favorite.setId(id);
        } catch (AopInvocationException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return favoriteRepository.save(favorite);
    }

}
