/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.controller;

import com.iviettech.coffeeshop.entities.AccountEntity;
import com.iviettech.coffeeshop.entities.CustomerEntity;
import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.iviettech.coffeeshop.entities.OrderEntity;
import com.iviettech.coffeeshop.entities.ProductEntity;
import com.iviettech.coffeeshop.entities.PromotionEntity;
import com.iviettech.coffeeshop.entities.ToppingEntity;
import com.iviettech.coffeeshop.enums.OrderStatus;
import com.iviettech.coffeeshop.services.OrderService;
import com.iviettech.coffeeshop.services.ProductService;
import com.iviettech.coffeeshop.services.ToppingService;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author admin
 */
@Controller
@RequestMapping("/seller")
public class SellerController {

    @Autowired
    OrderService orderService;
    @Autowired
    ProductService productService;
    @Autowired
    ToppingService toppingService;

    @RequestMapping(value = {"/*", "/home"})
    public String viewHome(Model model) {
        List<ProductEntity> products = productService.getProducts();
        model.addAttribute("products", products);
        model.addAttribute("toppings", toppingService.findToppings());
        return "seller/home";
    }

    @RequestMapping(value = "/gio-hang")
    public String viewCartSeller(Model model) {
        return "seller/cartSeller";
    }

    @RequestMapping(value = "/them-vao-gio-hang", method = RequestMethod.POST)
    public String addToCart(Model model,
            @RequestParam(name = "productId") int productId,
            @RequestParam(name = "sizeId") int sizeId,
            @RequestParam(name = "toppingIds", required = false) List<Integer> toppingIds,
            @RequestParam(name = "quantity") int quantity,
            HttpSession session
    ) {
        List<OrderDetailEntity> orderDetails;
        if (session.getAttribute("sellerOrderDetails") == null) {
            orderDetails = new ArrayList<>();
        } else {
            orderDetails = (List<OrderDetailEntity>) session.getAttribute("sellerOrderDetails");
        }

        ProductEntity product = productService.getProductByIdAndSizeId(productId, sizeId);
        OrderDetailEntity orderDetail = new OrderDetailEntity();

        //Check the product is exist in session
        boolean isExistProduct = false;
        for (OrderDetailEntity orderDetailTemp : orderDetails) {
            if (product.getId() == orderDetailTemp.getProduct().getId()
                    && product.getSizes().iterator().next().getSize().equals(orderDetailTemp.getSize())) {
                try {
                    int lenToppingIds = toppingIds.size();
                    if (orderDetailTemp.getToppings() != null) {
                        StringBuilder toppingStr = new StringBuilder();
                        if (lenToppingIds == orderDetailTemp.getToppings().size()) {
                            Set<ToppingEntity> toppings = toppingService.getToppingsByIds(toppingIds);
                            for (ToppingEntity topping : toppings) {
                                toppingStr.append(topping.getName() + ",");
                            }
                            toppingStr.deleteCharAt(toppingStr.length() - 1);
                            if (toppingStr.toString().equalsIgnoreCase(orderDetailTemp.getTopping())) {
                                isExistProduct = true;
                            }
                        }
                    }
                } catch (Exception ex) {
                    if (orderDetailTemp.getTopping().isEmpty()) {
                        isExistProduct = true;
                    }
                }

                if (isExistProduct) {
                    double totalToppingPrice = 0;
                    if (!orderDetailTemp.getTopping().isEmpty()) {
                        for (ToppingEntity topping : orderDetailTemp.getToppings()) {
                            totalToppingPrice += topping.getPrice();
                        }
                    }
                    orderDetailTemp.setQuantity(orderDetailTemp.getQuantity() + quantity);
                    orderDetailTemp.setPrice(orderDetailTemp.getPrice() + (orderDetailTemp.getUnitPrice() + totalToppingPrice) * quantity);

                    session.setAttribute("sellerOrderDetails", orderDetails);
                    return "redirect:/seller/home";
                }
            }
        }

        if (isExistProduct == false) {
            orderDetail.setProduct(product);
            orderDetail.setQuantity(quantity);
            orderDetail.setSize(product.getSizes().iterator().next().getSize());
            orderDetail.setTopping("");
            double unitPriceTemp = product.getPrice() + product.getSizes().iterator().next().getAddition();

            if (!product.getPromotions().isEmpty()) {
                for (PromotionEntity promotion : product.getPromotions()) {
                    unitPriceTemp *= (1 - promotion.getDiscount());
                }

                unitPriceTemp = Math.round(unitPriceTemp / 100) * 100;
            }
            orderDetail.setUnitPrice(unitPriceTemp);

            orderDetail.setPrice(unitPriceTemp * orderDetail.getQuantity());
        }
        try {
            Set<ToppingEntity> toppings = toppingService.getToppingsByIds(toppingIds);
            orderDetail.setToppings(toppings);
            double totalToppingPrice = 0;
            StringBuilder toppingStr = new StringBuilder();
            if (orderDetail.getToppings() != null) {
                for (ToppingEntity topping : orderDetail.getToppings()) {
                    toppingStr.append(topping.getName() + ",");
                    totalToppingPrice += topping.getPrice();
                }
                toppingStr.deleteCharAt(toppingStr.length() - 1);
            }
            orderDetail.setTopping(toppingStr.toString());
            orderDetail.setPrice(totalToppingPrice + orderDetail.getPrice());
        } catch (Exception ex) {
            Logger.getLogger(ShopController.class.getName()).log(Level.SEVERE, null, ex);
        }
        orderDetails.add(orderDetail);
        session.setAttribute("sellerOrderDetails", orderDetails);

        return "redirect:/seller/home";
    }

    @RequestMapping("/xoa-don-hang/{pos}")
    public String deleteOrderDetail(@PathVariable("pos") int pos,
            HttpSession session) {
        List<OrderDetailEntity> orderDetails = (List<OrderDetailEntity>) session.getAttribute("sellerOrderDetails");
        orderDetails.remove(orderDetails.get(pos));
        session.setAttribute("sellerOrderDdetails", orderDetails);
        return "redirect:/seller/gio-hang";
    }

    @RequestMapping("/dat-hang")
    public String addOrder(HttpSession session,
            Authentication a) {
        List<OrderDetailEntity> orderDetails = (List<OrderDetailEntity>) session.getAttribute("sellerOrderDetails");
        AccountEntity account = (AccountEntity) a.getPrincipal();
        CustomerEntity customer = new CustomerEntity();
        customer.setName(account.getName());
        customer.setEmail(account.getEmail());
        customer.setAddress(account.getAddress());
        customer.setGender(account.getGender());
        customer.setPhone(account.getPhone());
        customer.setAccount(account);

        double totalPrice = 0;
        for (OrderDetailEntity orderDetail : orderDetails) {
            totalPrice += orderDetail.getPrice();
        }
        OrderEntity order = new OrderEntity(new Date(), new Date(), totalPrice, OrderStatus.DONE, orderDetails, customer);
        orderService.addOrder(order);
        session.removeAttribute("sellerOrderDetails");
        return "redirect:/seller/home";
    }

    @RequestMapping("/don-hang-online")
    public String viewOnlineOrder(Model model) {
        List<OrderEntity> orders = orderService.getOrdersByStatus(OrderStatus.NEW);
        orders.addAll(0, orderService.getOrdersByStatus(OrderStatus.MAKING));
        model.addAttribute("orders", orders);
        return "seller/onlineOrder";
    }

    @RequestMapping("/don-hang-dang-ship")
    public String viewShippingOrder(Model model) {
        List<OrderEntity> orders = orderService.getOrdersByStatus(OrderStatus.SHIPPING);
        model.addAttribute("orders", orders);
        return "seller/shippingOrder";
    }
    
    @RequestMapping("/lam-don-hang-online/{orderId}")
    public String changeToMakingStatus(@PathVariable("orderId") int orderId){
        orderService.changeStatusToMaking(orderId);
        return "redirect:/seller/don-hang-online";
    }
    
    @RequestMapping("/xac-nhan-don-hang-online/{orderId}")
    public String changeToShippingStatus(@PathVariable("orderId") int orderId) {
        orderService.changeStatusToShipping(orderId);
        return "redirect:/seller/don-hang-online";
    }

    @RequestMapping("/xac-nhan-don-hang-da-ship/{orderId}")
    public String changeToDoneStatus(@PathVariable("orderId") int orderId) {
        orderService.changeStatusToDone(orderId);
        return "redirect:/seller/don-hang-dang-ship";
    }

    @RequestMapping("/huy-don-hang/{orderId}")
    public String changeToDeleteStatus(@PathVariable("orderId") int orderId) {
        orderService.changeStatusToCanceled(orderId);
        return "redirect:/seller/don-hang-online";
    }

    @RequestMapping("/xuat-hoa-don")
    public ModelAndView showBill(HttpSession session) {
        ArrayList<OrderDetailEntity> orderDetails = (ArrayList<OrderDetailEntity>) session.getAttribute("sellerOrderDetails");
        return new ModelAndView("pdfPage", "orderDetails", orderDetails);
    }

}
