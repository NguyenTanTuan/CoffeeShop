/*
x * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iviettech.coffeeshop.entities.AccountEntity;
import com.iviettech.coffeeshop.entities.CustomerEntity;
import com.iviettech.coffeeshop.entities.FavoriteEntity;
import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.iviettech.coffeeshop.entities.OrderEntity;
import com.iviettech.coffeeshop.entities.ProductEntity;
import com.iviettech.coffeeshop.entities.PromotionEntity;
import com.iviettech.coffeeshop.entities.RoleEntity;
import com.iviettech.coffeeshop.entities.ToppingEntity;
import com.iviettech.coffeeshop.enums.OrderStatus;
import com.iviettech.coffeeshop.enums.Role;
import com.iviettech.coffeeshop.services.AccountService;
import com.iviettech.coffeeshop.services.CategoryService;
import com.iviettech.coffeeshop.services.EmailSenderSerivce;
import com.iviettech.coffeeshop.services.FavoriteService;
import com.iviettech.coffeeshop.services.OrderService;
import com.iviettech.coffeeshop.services.ProductService;
import com.iviettech.coffeeshop.services.PromotionService;
import com.iviettech.coffeeshop.services.RoleService;
import com.iviettech.coffeeshop.services.ToppingService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

/**
 *
 * @author admin
 */
@Controller
public class ShopController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ToppingService toppingService;
    @Autowired
    private PromotionService promotionService;
    @Autowired
    private AccountService accountService;
    @Autowired
    FavoriteService favoriteService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private EmailSenderSerivce emailSenderSerivce;

    @RequestMapping(value = {"/*", "/home"})
    public String viewHome(Model model, Authentication a) {
        List<ProductEntity> products = productService.getBestProducts();
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("promotions", promotionService.getPromotionsAvailable());
        if (a != null) {
            AccountEntity account = (AccountEntity) a.getPrincipal();
            for (ProductEntity product : products) {
                product.setFavorites(new ArrayList<>());
                FavoriteEntity favorite = favoriteService.getFavoritesByAccountIdAndProductId(account.getId(), product.getId());
                if (favorite != null && favorite.isStatus()) {
                    product.getFavorites().add(favorite);
                }
            }
        }

        model.addAttribute("products", products);
        model.addAttribute("hadSearchFunction", true);
        return "home";
    }

    @RequestMapping(value = "/khuyen-mai")
    public String viewPromotions(Model model,
            @RequestParam(name = "id", required = false) Integer promotionId) {
        try {
            List<PromotionEntity> promotions = new ArrayList<>();
            promotions.add(promotionService.getPromotionById(promotionId));

            List<ProductEntity> products = new ArrayList<>(promotions.get(0).getProducts());
            model.addAttribute("promotions", promotions);
            model.addAttribute("products", products);

        } catch (Exception ex) {
            List<PromotionEntity> promotions = new ArrayList<>(promotionService.getPromotionsAvailablIncludeProducts());
            List<ProductEntity> products = new ArrayList<>();
            for (PromotionEntity promotion : promotions) {
                products.addAll(promotion.getProducts());
            }

            model.addAttribute("promotions", promotions);
            model.addAttribute("products", products);
        }
        model.addAttribute("hadSearchFunction", true);
        return "discountedProducts";
    }
    
    @RequestMapping(value = "/tim-kiem")
    public String searchProductsNotAtHome(Model model,
            @RequestParam(name = "name") String productName,
            Authentication a){
        List<ProductEntity> products = productService.searchProducts(productName);

        if (a != null) {
            AccountEntity account = (AccountEntity) a.getPrincipal();
            for (ProductEntity product : products) {
                product.setFavorites(new ArrayList<>());
                FavoriteEntity favorite = favoriteService.getFavoritesByAccountIdAndProductId(account.getId(), product.getId());
                if (favorite != null && favorite.isStatus()) {
                    product.getFavorites().add(favorite);
                }
            }
        }
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("promotions", promotionService.getPromotionsAvailable());
        model.addAttribute("products", products);
        model.addAttribute("favorite", false);
        model.addAttribute("hadSearchFunction", true);
        model.addAttribute("isSearching", true);
        return "home";
    }

    @RequestMapping(value = {"/dang-nhap"})
    public String viewLogin(Model model,
            @RequestParam(name = "isError", required = false) boolean isError) {
        if (isError) {
            model.addAttribute("messageError", "Sai tên đăng nhập hoặc mật khẩu");
        }
        return "login";
    }

    @RequestMapping(value = {"/dang-ky"})
    public String viewRegister(Model model) {
        return "register";
    }

    @RequestMapping(value = {"/gio-hang"})
    public String viewCart(Model model) {
        model.addAttribute("toppings", toppingService.findToppings());
        return "cart/cart";
    }

    @RequestMapping(value = "/chi-tiet-san-pham/{productId}")
    public String viewProductDetail(Model model,
            @PathVariable("productId") int id,
            Authentication a) {
        ProductEntity product = productService.getProductById(id);
        if (a != null) {
            AccountEntity account = (AccountEntity) a.getPrincipal();
            
            product.setFavorites(new ArrayList<>());
            
            FavoriteEntity favorite = favoriteService.getFavoritesByAccountIdAndProductId(account.getId(), product.getId());
            if (favorite != null && favorite.isStatus()) {
                product.getFavorites().add(favorite);
            }
        }
        model.addAttribute("product", product);

        return "productDetail";
    }

    @RequestMapping(value = "/mua-nhanh/{productId}/{sizeId}")
    public String buyFast(Model model,
            @PathVariable("productId") int productId,
            @PathVariable("sizeId") int sizeId,
            HttpSession session) {
        List<OrderDetailEntity> orderDetails = new ArrayList<>();

        if (session.getAttribute("orderDetails") == null) {
            session.setAttribute("orderDetails", orderDetails);
        } else {
            orderDetails = (List<OrderDetailEntity>) session.getAttribute("orderDetails");
        }
        ProductEntity product = productService.getProductByIdAndSizeId(productId, sizeId);
        OrderDetailEntity orderDetail = new OrderDetailEntity();

        //Check the product is exist in session
        boolean isExistProduct = false;
        for (OrderDetailEntity orderDetailTemp : orderDetails) {
            if (product.getId() == orderDetailTemp.getProduct().getId()
                    && product.getSizes().iterator().next().getSize().equals(orderDetailTemp.getSize())
                    && orderDetailTemp.getToppings() == null) {
                isExistProduct = true;
                orderDetailTemp.setQuantity(orderDetailTemp.getQuantity() + 1);
                orderDetailTemp.setPrice(orderDetailTemp.getUnitPrice() * orderDetailTemp.getQuantity());
                break;
            }
        }
        if (isExistProduct == false) {
            orderDetail.setProduct(product);
            orderDetail.setQuantity(1);
            orderDetail.setSize(product.getSizes().iterator().next().getSize());
            double unitPriceTemp = product.getPrice() + product.getSizes().iterator().next().getAddition();

            if (!product.getPromotions().isEmpty()) {
                for (PromotionEntity promotion : product.getPromotions()) {
                    unitPriceTemp *= (1 - promotion.getDiscount());
                }

                unitPriceTemp = Math.round(unitPriceTemp / 100) * 100;
            }
            orderDetail.setUnitPrice(unitPriceTemp);

            orderDetail.setPrice(unitPriceTemp * orderDetail.getQuantity());
            orderDetails.add(orderDetail);
        }
        session.setAttribute("orderDetails", orderDetails);
        session.removeAttribute("mailCode");
        return "redirect:/gio-hang";
    }

    @RequestMapping(value = "/thay-doi-so-luong/{pos}/{quantity}")
    public String updateQuantity(@PathVariable("pos") int pos,
            @PathVariable("quantity") int quantity,
            HttpSession session) {

        List<OrderDetailEntity> orderDetails = (List<OrderDetailEntity>) session.getAttribute("orderDetails");
        orderDetails.get(pos).setQuantity(quantity);
        int totalToppingPrice = 0;
        try {
            for (ToppingEntity topping : orderDetails.get(pos).getToppings()) {
                totalToppingPrice += topping.getPrice();
            }
        } catch (Exception ex) {
            Logger.getLogger(ShopController.class.getName()).log(Level.SEVERE, null, ex);
        }

        orderDetails.get(pos).setPrice((orderDetails.get(pos).getUnitPrice() + totalToppingPrice) * orderDetails.get(pos).getQuantity());
        orderDetails.get(pos).setPrice(Math.round(orderDetails.get(pos).getPrice() * 10) / 10);
        session.setAttribute("orderDetails", orderDetails);
        session.removeAttribute("mailCode");

        return "redirect:/gio-hang";
    }

    @RequestMapping(value = "/xoa-san-pham")
    public String deleteProduct(Model model,
            @RequestParam(name = "pos") int pos,
            HttpSession session) {
        List<OrderDetailEntity> orderDetails = (List<OrderDetailEntity>) session.getAttribute("orderDetails");
        orderDetails.remove(orderDetails.get(pos));

        session.setAttribute("orderDetails", orderDetails);
        session.removeAttribute("mailCode");
        return "redirect:/gio-hang";
    }

    @RequestMapping(value = "/them-topping", method = RequestMethod.POST)
    public String addTopping(Model model,
            @RequestParam(name = "orderDetailPosition") int pos,
            @RequestParam(name = "topping", required = false) List<Integer> toppingIds,
            HttpSession session) {
        try {
            Set<ToppingEntity> toppings = toppingService.getToppingsByIds(toppingIds);
            List<OrderDetailEntity> orderDetails = (List<OrderDetailEntity>) session.getAttribute("orderDetails");
            orderDetails.get(pos).setToppings(toppings);

            int totalToppingPrice = 0;
            StringBuilder toppingStr = new StringBuilder();
            for (ToppingEntity topping : orderDetails.get(pos).getToppings()) {
                toppingStr.append(topping.getName() + ",");
                totalToppingPrice += topping.getPrice();
            }
            toppingStr.deleteCharAt(toppingStr.length() - 1);

            orderDetails.get(pos).setTopping(toppingStr.toString());
            orderDetails.get(pos).setPrice(orderDetails.get(pos).getPrice() + totalToppingPrice * orderDetails.get(pos).getQuantity());

            // filter list order detail if exist an orderDetail has size, product, topping
            int lenOrderDetails = orderDetails.size();
            for (int i = 0; i < lenOrderDetails; i++) {
                OrderDetailEntity orderDetail1 = orderDetails.get(i);
                for (int j = i + 1; j < lenOrderDetails; j++) {
                    OrderDetailEntity orderDetail2 = orderDetails.get(j);
                    if (orderDetail1.getSize().toString().equalsIgnoreCase(orderDetail2.getSize().toString())
                            && orderDetail1.getProduct().getName().equalsIgnoreCase(orderDetail2.getProduct().getName())
                            && orderDetail1.getTopping().equalsIgnoreCase(orderDetail2.getTopping())) {
                        orderDetail1.setQuantity(orderDetail1.getQuantity() + orderDetail2.getQuantity());
                        orderDetail1.setPrice(orderDetail1.getPrice() + orderDetail2.getPrice());
                        orderDetails.remove(j);
                        j--;
                        i--;
                    }
                }
            }
            session.setAttribute("orderDetails", orderDetails);
        } catch (Exception ex) {
            Logger.getLogger(ShopController.class.getName()).log(Level.SEVERE, null, ex);
        }

        session.removeAttribute("mailCode");
        return "redirect:/gio-hang";
    }

    @RequestMapping(value = "/xoa-gio-hang")
    public String clearCart(HttpSession session) {
        session.removeAttribute("orderDetails");
        session.removeAttribute("mailCode");
        return "redirect:/home";
    }

    @RequestMapping(value = "/dat-hang")
    public String viewCheckout(Model model) {
        model.addAttribute("customer", new CustomerEntity());
        return "cart/check-out";
    }

    @RequestMapping(value = "/dat-hang", method = RequestMethod.POST)
    public String addOrder(Model model,
            HttpSession session,
            @ModelAttribute(name = "customer") CustomerEntity customer,
            @RequestParam(name = "totalPrice") double totalPrice,
            @Value(value = "${fileForSend}") String fileForSend,
            @Value(value = "${pathToResources}") String pathToResources,
            Authentication a) {
        //Validate form customer
        String messageError = "";
        boolean isValidated = true;
        if (customer.getName().isEmpty() || customer.getEmail().isEmpty() || customer.getPhone().isEmpty()
                || customer.getAddress().isEmpty()) {
            messageError = "Vui lòng không bỏ trống";
            isValidated = false;
        } else if (!customer.getEmail().contains("@") && !customer.getEmail().contains(".")) {
            messageError = "Email không chính xác";
            isValidated = false;
        } else if (!customer.getPhone().matches("\\d{10}") && !customer.getPhone().matches("\\d{11}")) {
            messageError = "Số điện thoại không chính xác";
            isValidated = false;
        }
        if (!isValidated) {
            model.addAttribute("messageError", messageError);
            model.addAttribute("customer", customer);
            return "cart/check-out";
        }
        //
        if (a != null) {
            customer.setAccount((AccountEntity) a.getPrincipal());
        }
        List<OrderDetailEntity> orderDetails = (List<OrderDetailEntity>) session.getAttribute("orderDetails");
        OrderEntity order = new OrderEntity(new Date(), new Date(), totalPrice, OrderStatus.NEW, orderDetails, customer);
        order = orderService.addOrder(order);
        // Create mail content
        StringBuilder textHtml = new StringBuilder();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        textHtml.append(String.format("<h2>Người nhận: %s</h2><h2>Ngày đặt:%s</h2>", order.getCustomer().getName(), format.format(order.getShippingDate())));
        textHtml.append("<h2><table>");
        textHtml.append("<tr><td colspan='6'>Mã đơn hàng:" + order.getId() + "</td></tr>");
        textHtml.append("<tr><td>Tên</td><td>Đơn giá</td><td>Số lượng</td><td>Giá</td><td>Size</td><td>Topping</td></tr>");
        for (OrderDetailEntity orderDetail : orderDetails) {

            textHtml.append(String.format("<tr><td>%s</td><td>%,dđ</td><td>%d</td><td>%,dđ</td><td>%s</td><td>",
                    orderDetail.getProduct().getName(), Math.round(orderDetail.getUnitPrice()), orderDetail.getQuantity(),
                    Math.round(orderDetail.getPrice()), orderDetail.getSize().toString()));
            if (orderDetail.getTopping() != null) {
                textHtml.append(String.format("%s</td></tr>", orderDetail.getTopping()));
            } else {
                textHtml.append(" </td></tr>");
            }
        }
        textHtml.append("</table></h2>");
        textHtml.append(String.format("<h1>Tổng cộng: %,dđ</h1>", Math.round(order.getTotalPrice())));

        emailSenderSerivce.sendMail(customer.getEmail(), fileForSend, pathToResources, textHtml.toString());

        session.removeAttribute("orderDetails");
        return "orderSuccess";
    }

    @RequestMapping(value = "/dang-ky", method = RequestMethod.POST)
    public String addAccount(Model model,
            @ModelAttribute(name = "account") AccountEntity account,
            @RequestParam(name = "rePassword") String rePassword,
            @Value(value = "${fileForSend}") String fileForSend,
            @Value(value = "${pathToResources}") String pathToResources,
            HttpSession session) {
        Integer mailCode = (Integer) session.getAttribute("mailCode");
        // validate infomation
        if (mailCode == null) {
            mailCode = 0;
            session.setAttribute("mailCode", mailCode);
        }
        boolean isValidated = true;
        String messageError = "";
        if (!account.getPassword().equals(rePassword)) {
            messageError = "Nhập lại mật khẩu không đúng";
            isValidated = false;
        } else if (accountService.isExistedUsername(account.getUsername())) {
            messageError = "Tài khoản đã tồn tại";
            isValidated = false;
        } else if (account.getUsername().length() <= 5) {
            messageError = "Tên đăng nhập phải lớn hơn 5 ký tự";
            isValidated = false;
        } else if (accountService.isExistedEmail(account.getEmail())) {
            messageError = "Email đã được sử dụng";
            isValidated = false;
        } else if (accountService.isExistedPhone(account.getPhone())) {
            messageError = "Số điện thoại đã được sử dụng";
            isValidated = false;
        } else if (account.getPassword().length() <= 6) {
            messageError = "Mật khẩu phải nhiều hơn 6 ký tự";
            isValidated = false;
        } else if (!account.getEmail().contains("@") && !account.getEmail().contains(".")) {
            messageError = "Email không chính xác";
            isValidated = false;
        } else if (!account.getPhone().matches("\\d{10}") && !account.getPhone().matches("\\d{11}")) {
            messageError = "Số điện thoại không chính xác";
            isValidated = false;
        }

        if (isValidated == false) {
            model.addAttribute("messageError", messageError);
            model.addAttribute("account", account);
            return "register";
        }

        account.setStatus(false);
        RoleEntity role = roleService.getRole(Role.ROLE_USER);
        account.setRoles(new LinkedHashSet<RoleEntity>());
        account.getRoles().add(role);
        accountService.addAccount(account);
        model.addAttribute("email", account.getEmail());

        this.sendCodeEmail(model, account.getEmail(), fileForSend, pathToResources, session);
        model.addAttribute("action", "xac-thuc-dang-ky");
        return "validateEmail";
    }

    @RequestMapping(value = "/xac-thuc-dang-ky", method = RequestMethod.POST)
    public String completeRegister(Model model,
            @RequestParam(name = "email") String email,
            @RequestParam(name = "code") int code,
            @Value(value = "${fileForSend}") String fileForSend,
            @Value(value = "${pathToResources}") String pathToResources,
            HttpSession session) {
        int mailCode = (Integer) session.getAttribute("mailCode");
        if (code != mailCode) {
            model.addAttribute("messageError", "Mã xác thực không chính xác");
            model.addAttribute("email", email);
            model.addAttribute("action", "xac-thuc-dang-ky");
            return "validateEmail";
        }
        accountService.updateAccountStatus(email, true);

        String content = "<h2>Chúc mừng bạn xác thực email thành công</h2><h2>Cảm ơn bạn đã quan tâm đến Teaffee</h2>";
        emailSenderSerivce.sendMail(email, fileForSend, pathToResources, content);
        session.invalidate();
        return "redirect:/dang-nhap";
    }

    @RequestMapping(value = "/xac-thuc-email")
    public String viewFormValidateEmail(Model model,
            @RequestParam(name = "email") String email,
            @Value(value = "${fileForSend}") String fileForSend,
            @Value(value = "${pathToResources}") String pathToResources,
            HttpSession session) {
        Integer mailCode = (Integer) session.getAttribute("mailCode");
        if (mailCode == null) {
            mailCode = 0;
            session.setAttribute("mailCode", mailCode);
        }
        this.sendCodeEmail(model, email, fileForSend, pathToResources, session);
        model.addAttribute("email", email);
        model.addAttribute("action", "xac-thuc-dang-ky");
        return "validateEmail";
    }

    @RequestMapping("/xac-thuc-email-da-dang-ky")
    public String enterEmailRegistered(Model model) {
        return "formEmail";
    }

    @RequestMapping(value = "/xac-thuc-email-da-dang-ky", method = RequestMethod.POST)
    public String validateEmailRegistered(Model model,
            @RequestParam("email") String email,
            @Value(value = "${fileForSend}") String fileForSend,
            @Value(value = "${pathToResources}") String pathToResources,
            HttpSession session) {
        Integer mailCode = (Integer) session.getAttribute("mailCode");
        if (mailCode == null) {
            mailCode = 0;
            session.setAttribute("mailCode", mailCode);
        }

        AccountEntity account = accountService.findAccountByEmail(email);

        if (account == null) {
            model.addAttribute("messageError", "Email này chưa được sử dụng");
            return "formEmail";
        } else {
            this.sendCodeEmail(model, email, fileForSend, pathToResources, session);

            model.addAttribute("email", email);
            model.addAttribute("action", "xac-thuc-khoi-phuc-tai-khoan");
            return "validateEmail";
        }
    }

    @RequestMapping(value = "/xac-thuc-khoi-phuc-tai-khoan")
    public String startResetAccount(Model model,
            @RequestParam(name = "email") String email,
            @RequestParam(name = "code") int code,
            @SessionAttribute("mailCode") Integer mailCode) {
        if (code != mailCode) {
            model.addAttribute("messageError", "Mã xác thực không chính xác");
            model.addAttribute("email", email);
            model.addAttribute("action", "xac-thuc-khoi-phuc-tai-khoan");
            return "validateEmail";
        } else {
            AccountEntity account = accountService.findAccountByEmail(email);
            model.addAttribute("code", code);
            model.addAttribute("username", account.getUsername());
            return "formResetPassword";
        }
    }

    @RequestMapping(value = "/reset-mat-khau", method = RequestMethod.POST)
    public String resetPassword(Model model,
            @RequestParam(name = "code") int code,
            @RequestParam(name = "username") String username,
            @RequestParam(name = "password") String password,
            @RequestParam(name = "rePassword") String rePassword,
            HttpSession session) {
        Integer mailCode = (Integer) session.getAttribute("mailCode");

        if (code == mailCode) {
            if (!password.equalsIgnoreCase(rePassword)) {
                model.addAttribute("messageError", "Nhập lại mật khẩu");
                model.addAttribute("code", code);
                model.addAttribute("username", username);
                return "formResetPassword";
            } else {
                AccountEntity account = accountService.findAccount(username);
                account.setPassword(password);
                accountService.addAccount(account);
                session.removeAttribute("mailCode");
                return "redirect:/dang-nhap";
            }
        } else {
            return "redirect:/home";
        }
    }
//    AJAX 

    @RequestMapping(value = "/list-san-pham")
    public String getCategory(Model model,
            @RequestParam(name = "name") String nameCategory, Authentication a) {
        List<ProductEntity> products = null;
        if (nameCategory.equalsIgnoreCase("best choose")) {
            products = productService.getBestProducts();
        } else {
            products = productService.getProductsByCategoryName(nameCategory);
        }

        model.addAttribute("products", products);
        if (a != null) {
            AccountEntity account = (AccountEntity) a.getPrincipal();
            for (ProductEntity product : products) {
                product.setFavorites(new ArrayList<>());
                FavoriteEntity favorite = favoriteService.getFavoritesByAccountIdAndProductId(account.getId(), product.getId());
                if (favorite != null && favorite.isStatus()) {
                    product.getFavorites().add(favorite);
                }
            }
        }
        model.addAttribute("products", products);
        model.addAttribute("favorite", false);
        return "ajax/listProducts";
    }

    @RequestMapping(value = "/them-vao-gio-hang/{productId}/{sizeId}")
    public @ResponseBody
    String addToCart(Model model,
            @PathVariable("productId") int productId,
            @PathVariable("sizeId") int sizeId,
            HttpSession session) {
        this.buyFast(model, productId, sizeId, session);
        return "ok";
    }

    @RequestMapping(value = "/tim-kiem-san-pham")
    public String searchProducts(Model model,
            @RequestParam(name = "name") String productName,
            Authentication a) {
        List<ProductEntity> products = productService.searchProducts(productName);

        if (a != null) {
            AccountEntity account = (AccountEntity) a.getPrincipal();
            for (ProductEntity product : products) {
                product.setFavorites(new ArrayList<>());
                FavoriteEntity favorite = favoriteService.getFavoritesByAccountIdAndProductId(account.getId(), product.getId());
                if (favorite != null && favorite.isStatus()) {
                    product.getFavorites().add(favorite);
                }
            }
        }
        model.addAttribute("products", products);
        model.addAttribute("favorite", false);
        return "ajax/listProducts";
    }

    @RequestMapping(value = "/tim-ids-topping/{pos}")
    public @ResponseBody
    String searchTopping(@PathVariable("pos") int pos,
            HttpSession session) {
        String responseText = "";
        Set<ToppingEntity> toppings = ((List<OrderDetailEntity>) session.getAttribute("orderDetails"))
                .get(pos)
                .getToppings();
        List<Integer> ids = new ArrayList<>();
        if (toppings == null) {
            return responseText;
        } else {
            for (ToppingEntity topping : toppings) {
                ids.add(topping.getId());
            }
        }

        ObjectMapper mapper = new ObjectMapper();
        try {
            responseText = mapper.writeValueAsString(ids);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ShopController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return responseText;
    }

    @RequestMapping("/gui-code")
    public @ResponseBody
    String sendCodeEmail(Model model,
            @RequestParam(name = "email") String email,
            @Value(value = "${fileForSend}") String fileForSend,
            @Value(value = "${pathToResources}") String pathToResources,
            HttpSession session) {
        Integer mailCode = (Integer) session.getAttribute("mailCode");
        if (mailCode == null) {
            mailCode = 0;
            session.setAttribute("mailCode", mailCode);
        }
        mailCode = (int) Math.round(Math.random() * 100000);
        session.setAttribute("mailCode", mailCode);
        String content = String.format("<h2>Mã xác thực của bạn là:%d</h2><h2>Điền mã này vào ô xác thực</h2>", mailCode);
        emailSenderSerivce.sendMail(email, fileForSend, pathToResources, content);

        return "ok";
    }

//    Send mail with custom content
}
