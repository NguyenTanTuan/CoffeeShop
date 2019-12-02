/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.ImageEntity;
import com.iviettech.coffeeshop.entities.ProductEntity;
import com.iviettech.coffeeshop.entities.SizeEntity;
import com.iviettech.coffeeshop.repositories.ImageRepository;
import com.iviettech.coffeeshop.repositories.ProductRepository;
import com.iviettech.coffeeshop.repositories.PromotionRepository;
import com.iviettech.coffeeshop.repositories.SizeRepository;
import com.iviettech.coffeeshop.repositories.VoteRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
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
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private VoteRepository voteRepository;
    @Autowired
    private FavoriteService favoriteService;
    @Autowired
    private PromotionRepository promotionRepository;
    @Autowired
    private SizeRepository sizeRepository;

    public ProductEntity findProduct(int id) {
        return productRepository.findOne(id);
    }

    public ProductEntity getProductByIdAndSizeId(int id, int sizeId) {
        ProductEntity product = productRepository.findOne(id);
        Set<SizeEntity> sizes = new HashSet<>();
        sizes.add(sizeRepository.findOne(sizeId));
        product.setSizes(sizes);
        product.setImages(imageRepository.getImagesByProductId(product.getId()));
        product.setVotes(voteRepository.getVotesByProductId(product.getId()));
        product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        return product;
    }

    public ProductEntity getProductById(int id) {
        ProductEntity product = productRepository.findOne(id);
        product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
        product.setImages(imageRepository.getImagesByProductId(product.getId()));
        product.setVotes(voteRepository.getVotesByProductId(product.getId()));
        product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        return product;
    }

    public List<ProductEntity> getProducts() {

        List<ProductEntity> products = (List<ProductEntity>) productRepository.findAll();

        for (ProductEntity product : products) {
            product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
            product.setImages(imageRepository.getImagesByProductId(product.getId()));
            product.setVotes(voteRepository.getVotesByProductId(product.getId()));
            product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        }
        return products;
    }

    public List<ProductEntity> getProductsByCategoryName(String name) {
        List<ProductEntity> products = productRepository.getProductsByCategoryName(name);
        for (ProductEntity product : products) {
            product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
            product.setImages(imageRepository.getImagesByProductId(product.getId()));
            product.setVotes(voteRepository.getVotesByProductId(product.getId()));
            product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        }
        return products;
    }

    public List<ProductEntity> getFavoriteProducts(int accountId) {
        List<ProductEntity> products = productRepository.getFavoriteProducts(accountId);
        for (ProductEntity product : products) {
            product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
            product.setImages(imageRepository.getImagesByProductId(product.getId()));
            product.setVotes(voteRepository.getVotesByProductId(product.getId()));
            product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        }
        return products;
    }

    public List<ProductEntity> searchProducts(String name) {
        name = '%' + name + '%';
        List<ProductEntity> products = productRepository.getProductsByName(name);
        for (ProductEntity product : products) {
            product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
            product.setImages(imageRepository.getImagesByProductId(product.getId()));
            product.setVotes(voteRepository.getVotesByProductId(product.getId()));
            product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        }
        return products;
    }

    public List<ProductEntity> getBestProducts() {
        List<Integer> productIds = productRepository.getBestProducts();
        List<ProductEntity> products = new ArrayList<ProductEntity>();

        for (Integer productId : productIds) {
            ProductEntity product = new ProductEntity();
            product = productRepository.findOne(productId);
            products.add(product);
        }

        for (ProductEntity product : products) {
            product.setSizes(sizeRepository.getSizesByProductId(product.getId()));
            product.setImages(imageRepository.getImagesByProductId(product.getId()));
            product.setVotes(voteRepository.getVotesByProductId(product.getId()));
            product.setPromotions(promotionRepository.getPromotionsByProductId(product.getId(), new Date()));
        }
        return products;
    }

    public ProductEntity addProduct(ProductEntity product) {
        List<ImageEntity> listImages = product.getImages();
        product.setImages(null);
        ProductEntity newProduct = productRepository.save(product);
        for (ImageEntity image : listImages) {
            image.setProduct(newProduct);
            imageRepository.save(image);
        }
        newProduct.setImages(listImages);
        return newProduct;
    }

    public List<ProductEntity> findProducts() {
        return (List<ProductEntity>) productRepository.findAll();
    }

    public LinkedHashSet<ProductEntity> getProductByPromotionId(int id) {

        return (LinkedHashSet<ProductEntity>) productRepository.getProductsByPromotionId(id);
    }

    public void saveProduct(ProductEntity product) {
        productRepository.save(product);
    }

}
