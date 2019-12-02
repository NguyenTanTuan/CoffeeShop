package com.iviettech.coffeeshop.repositories;

import com.iviettech.coffeeshop.entities.OrderEntity;
import com.iviettech.coffeeshop.enums.OrderStatus;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author PC
 */
@Repository
public interface OrderRepository extends CrudRepository<OrderEntity, Integer>{
    
    @Query(value = "SELECT * FROM Orders WHERE status like ?1", nativeQuery = true)
    public List<OrderEntity> getNewOrder(String status);   

    public List<OrderEntity> findByOrderDateBetweenAndStatusIn(Date startDate, Date endDate,List<OrderStatus> os);
    
@Query(value = "SELECT DISTINCT o FROM OrderEntity o "
            + "WHERE o.status = ?1 ")
    public List<OrderEntity> getByOrderStatus(OrderStatus status);
    
    public List<OrderEntity> findByOrderDateBetween(Date startDate, Date endDate);
    
@Query(value = "SELECT DISTINCT o FROM OrderEntity o WHERE o.customer.account.id = ?1 ")
    public List<OrderEntity> getByAccountId(int accountId);
    
@Query(value = "SELECT DISTINCT o FROM OrderEntity o WHERE  o.id = ?1 AND o.customer.account.id = ?2")
    public OrderEntity getByIdAndAccountId(int orderId, int accountId);
}
