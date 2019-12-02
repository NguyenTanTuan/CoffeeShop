/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.entities.CustomerEntity;
import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.iviettech.coffeeshop.entities.OrderEntity;
import com.iviettech.coffeeshop.enums.OrderStatus;
import com.iviettech.coffeeshop.repositories.CustomerRepository;
import com.iviettech.coffeeshop.repositories.OrderDetailRepository;
import com.iviettech.coffeeshop.repositories.OrderRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author admin
 */
@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public OrderEntity findOrder(int id) {
        OrderEntity order = orderRepository.findOne(id);
        order.setOrderDetails(orderDetailRepository.findByOrderId(id));
        return order;
    }

    public List<OrderEntity> findOrders() {
        return (List<OrderEntity>) orderRepository.findAll();
    }

    public List<OrderEntity> getOrdersByStatus(OrderStatus status) {
        List<OrderEntity> orders = orderRepository.getByOrderStatus(status);
        for (OrderEntity order : orders) {
            order.setOrderDetails(orderDetailRepository.findByOrderId(order.getId()));
        }
        return orders;
    }

    @Transactional(rollbackFor = Exception.class)
    public OrderEntity addOrder(OrderEntity order) {
        CustomerEntity customer = order.getCustomer();
        List<OrderDetailEntity> orderDetails = order.getOrderDetails();
        CustomerEntity existedCustomer = customerRepository.findByEmailAndPhone(customer.getEmail(), customer.getPhone());
//        Add customer
        if (existedCustomer != null) {
            customer.setId(existedCustomer.getId());
            if(existedCustomer.getAccount() != null){
                customer.setAccount(existedCustomer.getAccount());
            }
        }
        customer = customerRepository.save(customer);
//        Add order
        order.setCustomer(customer);
        order = orderRepository.save(order);
//        Add orderDetail
        for (OrderDetailEntity orderDetail : orderDetails) {
            orderDetail.setOrder(order);
            orderDetail = orderDetailRepository.save(orderDetail);
        }

        order.setOrderDetails(orderDetails);
        return order;
    }

    public OrderEntity changeStatusToShipping(int orderId) {
        OrderEntity order = orderRepository.findOne(orderId);
        order.setStatus(OrderStatus.SHIPPING);
        order.setShippingDate(new Date());
        return orderRepository.save(order);
    }

    public OrderEntity changeStatusToDone(int orderId) {
        OrderEntity order = orderRepository.findOne(orderId);
        order.setStatus(OrderStatus.DONE);
        return orderRepository.save(order);
    }

    public OrderEntity changeStatusToCanceled(int orderId) {
        OrderEntity order = orderRepository.findOne(orderId);
        order.setStatus(OrderStatus.CANCELED);
        return orderRepository.save(order);
    }

    public OrderEntity changeStatusToMaking(int orderId) {
        OrderEntity order = orderRepository.findOne(orderId);
        order.setStatus(OrderStatus.MAKING);
        return orderRepository.save(order);
    }

    public List<OrderEntity> getOrderByDate(Date startDate, Date endDate) {
        return (List<OrderEntity>) orderRepository.findByOrderDateBetween(startDate, endDate);
    }

    public List<OrderEntity> searchOrder(Date startDate, Date endDate, List<OrderStatus> os) {
        List<String> orderStatus = new ArrayList<>();
        for (OrderStatus order : os) {
            orderStatus.add(order.toString());
        }
        List<OrderEntity> orders = orderRepository.findByOrderDateBetweenAndStatusIn(startDate, endDate, os);

        return orders;
    }

    public List<OrderEntity> getOrdersByAccountId(int accountId) {
        List<OrderEntity> orders = orderRepository.getByAccountId(accountId);
        for (OrderEntity order : orders) {
            order.setOrderDetails(orderDetailRepository.findByOrderId(order.getId()));
        }
        return orders;
    }

    public OrderEntity getOrderByIdAndAccountId(int orderId, int accountId) {
        return orderRepository.getByIdAndAccountId(orderId, accountId);
    }

    public OrderEntity updateOrder(OrderEntity order) {
        return orderRepository.save(order);
    }
}
