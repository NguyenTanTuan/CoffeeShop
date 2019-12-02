/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.controller;

import com.iviettech.coffeeshop.entities.AccountEntity;
import com.iviettech.coffeeshop.entities.FavoriteEntity;
import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.iviettech.coffeeshop.entities.OrderEntity;
import com.iviettech.coffeeshop.entities.VoteEntity;
import com.iviettech.coffeeshop.enums.OrderStatus;
import com.iviettech.coffeeshop.services.AccountService;
import com.iviettech.coffeeshop.services.FavoriteService;
import com.iviettech.coffeeshop.services.OrderDetailService;
import com.iviettech.coffeeshop.services.OrderService;
import com.iviettech.coffeeshop.services.ProductService;
import com.iviettech.coffeeshop.services.VoteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author admin
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    ProductService productService;
    @Autowired
    FavoriteService favoriteService;
    @Autowired
    VoteService voteService;
    @Autowired
    AccountService accountService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderDetailService orderDetailService;
    @Autowired
    PasswordEncoder passwordEncoder;

    @RequestMapping(value = "/thong-tin-ca-nhan")
    public String viewProfile(Model model) {
        return "profile";
    }

    @RequestMapping(value = "/cap-nhat-thong-tin-ca-nhan", method = RequestMethod.POST)
    public String updateAccount(Model model,
            Authentication a,
            @ModelAttribute(name = "account") AccountEntity account,
            @RequestParam(name = "oldPassword", required = false) String oldPassword,
            @RequestParam(name = "newPassword", required = false) String newPassword,
            @RequestParam(name = "reNewPassword", required = false) String reNewPassword) {
        AccountEntity currentAccount = (AccountEntity) a.getPrincipal();
        boolean isValidated = true;
        
        String messageError = "";
        if (account.getName().isEmpty() || account.getEmail().isEmpty() || account.getPhone().isEmpty()) {
            messageError = "Vui lòng không bỏ trống";
            isValidated = false;
        } else if (!account.getEmail().contains("@") || !account.getEmail().contains(".")) {
            messageError = "Email không chính xác";
            isValidated = false;
        } else if (!currentAccount.getEmail().equals(account.getEmail())
                && accountService.isExistedEmail(account.getEmail())) {
            messageError = "Email đã tồn tại";
            isValidated = false;
        } else if (!currentAccount.getPhone().equals(account.getPhone())
                && accountService.isExistedPhone(account.getPhone())) {
            messageError = "Số điện thoại đã được sử dụng";
            isValidated = false;
        } else if (!account.getPhone().matches("\\d{10}") && !account.getPhone().matches("\\d{11}")) {
            messageError = "Số điện thoại không chính xác";
            isValidated = false;
        } else {
            currentAccount.setName(account.getName());
            if (!currentAccount.getEmail().equals(account.getEmail())) {
                currentAccount.setEmail(account.getEmail());
                currentAccount.setStatus(false);
            }
            currentAccount.setPhone(account.getPhone());
            currentAccount.setAddress(account.getAddress());
        }
        if (oldPassword != null && newPassword != null && reNewPassword != null) {
            if (oldPassword.isEmpty() || newPassword.isEmpty() || reNewPassword.isEmpty()) {
                messageError = "Vui lòng không bỏ trống";
                isValidated = false;
            } else if (!passwordEncoder.matches(oldPassword, currentAccount.getPassword())) {
                messageError = "Mật khẩu cũ không đúng";
                isValidated = false;
            } else if (newPassword.length() <= 6) {
                messageError = "Mật khẩu phải có chiều dài lớn hơn 6";
                isValidated = false;
            } else if (!newPassword.equals(reNewPassword)) {
                messageError = "Nhập lại mật khẩu mới không khớp";
                isValidated = false;
            } else {
                currentAccount.setPassword(passwordEncoder.encode(newPassword));
            }
        }
        if (isValidated) {
//          Add existed account mean update
            accountService.updateAccount(currentAccount);
            model.addAttribute("messageSuccess", "Cập nhật thành công");
        } else {
            model.addAttribute("messageError", messageError);
        }
        return "profile";
    }

    @RequestMapping("/don-hang-cua-ban")
    public String viewUserOrder(Model model,
            Authentication a) {
        AccountEntity account = (AccountEntity) a.getPrincipal();
        List<OrderEntity> orders = orderService.getOrdersByAccountId(account.getId());
        model.addAttribute("orders", orders);
        return "userOrder";
    }

    @RequestMapping("/chi-tiet-don-hang/{orderId}")
    public String viewUserOrderDetail(Model model,
            @PathVariable("orderId") int orderId,
            Authentication a) {
        AccountEntity account = (AccountEntity) a.getPrincipal();
        OrderEntity order = orderService.getOrderByIdAndAccountId(orderId, account.getId());
        List<OrderDetailEntity> orderDetails = orderDetailService.findByOrderId(order.getId());
        order.setOrderDetails(orderDetails);

        model.addAttribute("order", order);
        model.addAttribute("customer", order.getCustomer());
        return "orderDetail";
    }

    @RequestMapping("/huy-don-hang/{orderId}")
    public String cancelOrder(@PathVariable("orderId") int orderId,
            Authentication a) {
        AccountEntity account = (AccountEntity) a.getPrincipal();
        OrderEntity order = orderService.getOrderByIdAndAccountId(orderId, account.getId());
        if (order.getStatus().toString().equalsIgnoreCase(OrderStatus.NEW.toString())) {
            order.setStatus(OrderStatus.CANCELED);
            orderService.updateOrder(order);
        }

        return "redirect:/user/don-hang-cua-ban";
    }
//    AJAX

    @RequestMapping(value = "/list-san-pham-yeu-thich")
    public String getFavoriteProducts(Model model, Authentication a) {
        int accountId = ((AccountEntity) a.getPrincipal()).getId();
        model.addAttribute("products", productService.getFavoriteProducts(accountId));
        model.addAttribute("favorite", true);
        return "ajax/listProducts";
    }

    @RequestMapping(value = "/them-danh-gia/{productId}/{numberStar}")
    public @ResponseBody
    String addVote(@PathVariable("productId") int productId,
            @PathVariable("numberStar") int numberStar,
            Authentication a) {
        AccountEntity account = (AccountEntity) a.getPrincipal();
        VoteEntity vote = new VoteEntity();
        vote.setAccount(account);
        vote.setProduct(productService.findProduct(productId));
        vote.setStar(numberStar);
        voteService.addVote(vote);
        return String.valueOf(voteService.getAverageStar(productId));
    }

    @RequestMapping(value = "/xoa-san-pham-yeu-thich/{productId}")
    public @ResponseBody
    String deleteFavoriteProduct(Model model, Authentication a,
            @PathVariable("productId") int productId) {
        AccountEntity account = (AccountEntity) a.getPrincipal();
        FavoriteEntity favorite = new FavoriteEntity();
        favorite.setAccount(account);
        favorite.setProduct(productService.findProduct(productId));
        favorite.setStatus(false);
        // just update favorite status to false so i reused addFavorite()
        favoriteService.addFavorite(favorite);
        return "ok";
    }

    @RequestMapping(value = "/them-vao-yeu-thich/{productId}")
    public @ResponseBody
    String addToFavorite(@PathVariable("productId") int productId,
            Authentication a) {
        AccountEntity account = (AccountEntity) a.getPrincipal();
        FavoriteEntity favorite = new FavoriteEntity();
        favorite.setAccount(account);
        favorite.setProduct(productService.findProduct(productId));
        favorite.setStatus(true);
        favoriteService.addFavorite(favorite);
        return "ok";
    }
}
