/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.ProductEntity;
import java.util.LinkedHashSet;
import java.util.List;
import org.springframework.data.jpa.repository.Query;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends CrudRepository<ProductEntity, Integer>{
    
    @Query(value = "SELECT * FROM product p JOIN category c ON p.category_id = c.id WHERE c.name = ?1", nativeQuery = true)
    public List<ProductEntity> getProductsByCategoryName(String name);
    
    @Query(value = "SELECT p.id FROM product p "
            + "JOIN vote v "
            + "ON p.id = v.product_id "
            + "GROUP BY p.id "
            + "ORDER BY AVG(v.star) DESC "
            + "LIMIT 9 ", nativeQuery = true)
    public List<Integer> getBestProducts();
    
    @Query(value = "SELECT DISTINCT p FROM ProductEntity p WHERE p.name LIKE ?1")
    public List<ProductEntity> getProductsByName(String name);
    
    @Query(value = "SELECT DISTINCT p FROM ProductEntity p JOIN p.sizes s "
            + "WHERE p.id = ?1 AND s.id = ?2")
    public ProductEntity getProductByIdAndSizeId(int id, int sizeId);
    
    @Query(value = "SELECT DISTINCT p FROM ProductEntity p JOIN p.favorites f "
            + "WHERE f.account.id = ?1 AND f.status = true")
    public List<ProductEntity> getFavoriteProducts(int accountId);
    
    @Query(value = "SELECT p FROM ProductEntity p JOIN p.promotions pr WHERE pr.id = ?1")
    public LinkedHashSet<ProductEntity> getProductsByPromotionId(int id);
    
    @Query(value = "SELECT p FROM ProductEntity p JOIN p.category c WHERE c.id = ?1")
    public List<ProductEntity> getProductByCategoryId(int id);
    
}
