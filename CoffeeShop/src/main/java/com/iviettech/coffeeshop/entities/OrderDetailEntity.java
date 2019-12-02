/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.entities;

import com.iviettech.coffeeshop.enums.Size;
import java.io.Serializable;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author PC
 */
@Entity
@Table(name = "orderDetail")
public class OrderDetailEntity implements Serializable{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private double unitPrice;
    private double price;
    private int quantity;
    
    @Enumerated(EnumType.STRING)
    @Column(length = 2)
    private Size size;
    private String topping;

    @ManyToOne
    @JoinColumn(name = "productId")
    private ProductEntity product;

    @ManyToOne
    @JoinColumn(name = "orderId")
    private OrderEntity order;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "topping_orderDetail",
            joinColumns = @JoinColumn(name = "orderDetail_id"),
            inverseJoinColumns = @JoinColumn(name = "topping_id")
    )
    private Set<ToppingEntity> toppings;

    public OrderDetailEntity() {
    }

    public OrderDetailEntity(int id, double unitPrice, double price, int quantity, Size size, String topping, ProductEntity product, OrderEntity order, Set<ToppingEntity> toppings) {
        this.id = id;
        this.unitPrice = unitPrice;
        this.price = price;
        this.quantity = quantity;
        this.size = size;
        this.topping = topping;
        this.product = product;
        this.order = order;
        this.toppings = toppings;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public String getTopping() {
        return topping;
    }

    public void setTopping(String topping) {
        this.topping = topping;
    }

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public OrderEntity getOrder() {
        return order;
    }

    public void setOrder(OrderEntity order) {
        this.order = order;
    }

    public Set<ToppingEntity> getToppings() {
        return toppings;
    }

    public void setToppings(Set<ToppingEntity> toppings) {
        this.toppings = toppings;
    }

    
}
