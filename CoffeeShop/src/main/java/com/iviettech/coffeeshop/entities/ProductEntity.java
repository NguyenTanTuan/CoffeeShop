/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.entities;

import java.io.Serializable;
import java.util.List;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author admin
 */
@Entity
@Table(name = "product")
public class ProductEntity implements Serializable{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(length = 100)
    private String name;
    
    private double price;
    private boolean status;
    private String description;
    
    @ManyToOne
    @JoinColumn(name = "category_id")
    private CategoryEntity category;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<ImageEntity> images;

    @ManyToMany(mappedBy = "products",fetch = FetchType.LAZY)
    private Set<PromotionEntity> promotions;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "size_product",
            joinColumns = {
                @JoinColumn(name = "product_id")},
            inverseJoinColumns = {
                @JoinColumn(name = "size_id")}
    )
    private Set<SizeEntity> sizes;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<VoteEntity> votes;
    
    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<FavoriteEntity> favorites;
    
    public ProductEntity() {
    }

    public ProductEntity(String name, double price, boolean status, String description, CategoryEntity category, List<ImageEntity> images, Set<PromotionEntity> promotions, Set<SizeEntity> sizes, List<VoteEntity> votes, List<FavoriteEntity> favorites) {
        this.name = name;
        this.price = price;
        this.status = status;
        this.description = description;
        this.category = category;
        this.images = images;
        this.promotions = promotions;
        this.sizes = sizes;
        this.votes = votes;
        this.favorites = favorites;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public CategoryEntity getCategory() {
        return category;
    }

    public void setCategory(CategoryEntity category) {
        this.category = category;
    }

    public List<ImageEntity> getImages() {
        return images;
    }

    public void setImages(List<ImageEntity> images) {
        this.images = images;
    }

    public Set<PromotionEntity> getPromotions() {
        return promotions;
    }

    public void setPromotions(Set<PromotionEntity> promotions) {
        this.promotions = promotions;
    }

    public Set<SizeEntity> getSizes() {
        return sizes;
    }

    public void setSizes(Set<SizeEntity> sizes) {
        this.sizes = sizes;
    }

    public List<VoteEntity> getVotes() {
        return votes;
    }

    public void setVotes(List<VoteEntity> votes) {
        this.votes = votes;
    }

    public List<FavoriteEntity> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<FavoriteEntity> favorites) {
        this.favorites = favorites;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    
}
