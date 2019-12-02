/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.ProductEntity;
import com.iviettech.coffeeshop.entities.PromotionEntity;
import com.iviettech.coffeeshop.repositories.ImageRepository;
import com.iviettech.coffeeshop.repositories.ProductRepository;
import com.iviettech.coffeeshop.repositories.PromotionRepository;
import com.iviettech.coffeeshop.repositories.SizeRepository;
import com.iviettech.coffeeshop.repositories.VoteRepository;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author PC
 */
@Service
public class PromotionService {

    @Autowired
    private PromotionRepository promotionRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private SizeRepository sizeRepository;
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private VoteRepository voteRepository;
    
    public List<PromotionEntity> findPromotion() {
        return (List<PromotionEntity>) promotionRepository.findAll();
    }

    public PromotionEntity findPromotionById(int id) {
        PromotionEntity promotion = promotionRepository.findOne(id);
        promotion.setProducts(productRepository.getProductsByPromotionId(promotion.getId()));
        return promotion;
    }
    
    public PromotionEntity getPromotionById(int id){
        PromotionEntity promotion = promotionRepository.findOne(id);
        Set<ProductEntity> products = productRepository.getProductsByPromotionId(promotion.getId());
        for (ProductEntity product : products) {
                product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
                product.setImages(imageRepository.getImagesByProductId(product.getId()));
                product.setVotes(voteRepository.getVotesByProductId(product.getId()));
                product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
            }
            
            promotion.setProducts(products);
        return promotion;
    }
    
    public PromotionEntity getPromotion(int id) {
        return (PromotionEntity) promotionRepository.findOne(id);
    }

    public void addPromotion(PromotionEntity promotion) {
        promotionRepository.save(promotion);
    }

    public Set<PromotionEntity> getPromotionsAvailable() {
        return promotionRepository.getPromotionsAvailable(new Date());
    }

    public Set<PromotionEntity> getPromotionsAvailablIncludeProducts() {
        Set<PromotionEntity> promotions = promotionRepository.getPromotionsAvailable(new Date());
        for (PromotionEntity promotion : promotions) {
            Set<ProductEntity> products = productRepository.getProductsByPromotionId(promotion.getId());
            for (ProductEntity product : products) {
                product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
                product.setImages(imageRepository.getImagesByProductId(product.getId()));
                product.setVotes(voteRepository.getVotesByProductId(product.getId()));
                product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
            }
            
            promotion.setProducts(products);
        }
        return promotions;
    }
}
