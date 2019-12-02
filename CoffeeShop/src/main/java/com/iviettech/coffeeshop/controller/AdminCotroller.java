/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.controller;

import com.iviettech.coffeeshop.entities.AccountEntity;
import com.iviettech.coffeeshop.entities.CategoryEntity;
import com.iviettech.coffeeshop.entities.ImageEntity;
import com.iviettech.coffeeshop.entities.OrderEntity;
import com.iviettech.coffeeshop.entities.ProductEntity;
import com.iviettech.coffeeshop.entities.PromotionEntity;
import com.iviettech.coffeeshop.entities.RoleEntity;
import com.iviettech.coffeeshop.entities.SizeEntity;
import com.iviettech.coffeeshop.enums.OrderStatus;
import com.iviettech.coffeeshop.services.AccountService;
import com.iviettech.coffeeshop.services.ProductService;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ResourceLoader;
import com.iviettech.coffeeshop.services.CategoryService;
import com.iviettech.coffeeshop.services.ImageService;
import com.iviettech.coffeeshop.services.OrderDetailService;
import com.iviettech.coffeeshop.services.OrderService;
import com.iviettech.coffeeshop.services.PromotionService;
import com.iviettech.coffeeshop.services.RoleService;
import com.iviettech.coffeeshop.services.SizeService;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.ws.rs.POST;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author admin
 */
@Controller
@RequestMapping("/admin")
public class AdminCotroller implements ResourceLoaderAware {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    @Autowired
    private SizeService sizeService;
    @Autowired
    private PromotionService promotionService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private RoleService roleService;

    @Autowired
    private ServletContext context;

    private ResourceLoader resourceLoader;

//-----Home----------------------------------------
    @RequestMapping(value = {"/*", "/home/home"})
    public String viewAdmin(Model model) {
        model.addAttribute("order", orderService.getOrdersByStatus(OrderStatus.NEW));
        model.addAttribute("order1", orderService.getOrdersByStatus(OrderStatus.MAKING));
        model.addAttribute("order2", orderService.getOrdersByStatus(OrderStatus.SHIPPING));
        model.addAttribute("order3", orderService.getOrdersByStatus(OrderStatus.CANCELED));
        model.addAttribute("order4", orderService.getOrdersByStatus(OrderStatus.DONE));
        return "admin/home";
    }
//-----Product--------------------------------------------

    @RequestMapping(value = {"/product/product"}, method = RequestMethod.GET)
    public String product(Model model) {
        List<ProductEntity> product = productService.getProducts();
        model.addAttribute("products", productService.getProducts());
        return "admin/product";
    }

    @RequestMapping(value = {"/product/add-product"})
    public String viewForm(Model model) {
        model.addAttribute("product", new ProductEntity());
        model.addAttribute("sizes", sizeService.findSizes());
        model.addAttribute("categories", categoryService.getCategoryByStatus());
        model.addAttribute("action", "/product/add-product");
        return "admin/add-product-form";
    }

    @RequestMapping(value = "/product/add-product", method = RequestMethod.POST)
    public String addProduct(Model model,
            @ModelAttribute("product") ProductEntity product,
            @RequestParam(name = "file", required = false) MultipartFile[] images,
            @RequestParam(name = "sizeTemp", required = false) List<Integer> sizeIds,
            @Value(value = "${pathSaveImage}") String pathSaveImages) {
        Set<SizeEntity> sizes = new HashSet<>();

        List<ImageEntity> listImage = new ArrayList<>();
        String savedPath;
        String messageError = "";
        boolean isValidated = true;
        if (product.getName().isEmpty()) {
            messageError = "Vui lòng không bỏ trống!!!";
            isValidated = false;
        } else {
            if (sizeIds == null) {
                messageError = "Vui lòng không bỏ trống size!!!";
                isValidated = false;
            } else {
                for (int sizeId : sizeIds) {
                    SizeEntity size = sizeService.findSize(sizeId);
                    sizes.add(size);
                }
                product.setSizes(sizes);
                if (images.length != 0) {
                    if (images[0].getOriginalFilename().isEmpty() || images[1].getOriginalFilename().isEmpty()) {
                        messageError = "Vui lòng không bỏ trống ảnh!!!";
                        isValidated = false;
                    } else {
                        for (int i = 0; i < images.length; i++) {
                            MultipartFile image = images[i];
                            try {
                                byte[] bytes = image.getBytes();

                                //Get path to resources
                                String pathUrl = context.getRealPath("/images");
                                int index = pathUrl.indexOf("target");
                                String pathFolder = pathUrl.substring(0, index) + pathSaveImages;
                                savedPath = "resources/images/landingPage/products/" + image.getOriginalFilename();
                                //create temporary ImageEntityz
                                ImageEntity imageTemp = new ImageEntity();
                                imageTemp.setPath(savedPath);
                                listImage.add(imageTemp);
                                //Save file
                                File storedFile = new File(pathFolder + File.separator + image.getOriginalFilename());
                                BufferedOutputStream buffer = new BufferedOutputStream(new FileOutputStream(storedFile));

                                buffer.write(bytes);
                                buffer.close();

                            } catch (IOException ex) {
                                model.addAttribute("errorMessage", "Error can't add product");
                                return "error";
                            }
                        }
                    }
                }
            }
        }
        if (isValidated) {
            product.setImages(listImage);
            model.addAttribute("product", product);
            productService.addProduct(product);
            return "redirect:/admin/product/product";
        } else {
            if (product.getId() == 0) {
                model.addAttribute("messageError", messageError);
                model.addAttribute("sizes", sizeService.findSizes());
                model.addAttribute("categories", categoryService.getCategories());
            } else {
                model.addAttribute("messageError", messageError);
                model.addAttribute("product", productService.getProductById(product.getId()));
                model.addAttribute("sizes", sizeService.findSizes());
                model.addAttribute("categories", categoryService.getCategories());
                model.addAttribute("action", "product/edit-product");
            }
            return "admin/add-product-form";
        }

    }

    @Override
    public void setResourceLoader(ResourceLoader resourceLoader
    ) {
        this.resourceLoader = resourceLoader;
    }

    @RequestMapping(value = {"/product/edit-product/{id}"})
    public String editProduct(Model model,
            @PathVariable("id") int Id
    ) {
        model.addAttribute("product", productService.getProductById(Id));
        model.addAttribute("sizes", sizeService.findSizes());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("action", "product/edit-product");
        return "admin/add-product-form";
    }

    @RequestMapping(value = "/product/edit-product/{id}", method = RequestMethod.POST)
    public String saveProduct(Model model,
            @PathVariable("id") int Id) {
        ProductEntity product = productService.getProductById(Id);
        productService.saveProduct(product);
        return "redirect:admin/product/product";
    }

    @RequestMapping(value = {"/product/delete-image/{id}"})
    public String deleteImage(Model model,
            @PathVariable("id") int Id
    ) {
        imageService.deleteImageByProductId(Id);
        return "redirect:/admin/product/edit-product/" + Id;
    }

    @RequestMapping(value = {"/product/disable-product/{id}"})
    public String delteteProduct(Model model,
            @PathVariable("id") int Id) {
        ProductEntity product = productService.getProductById(Id);
        product.setStatus(false);
        productService.saveProduct(product);
        return "redirect:/admin/product/product";
    }

    @RequestMapping(value = {"/product/enable-product/{id}"})
    public String enableProduct(Model model,
            @PathVariable("id") int Id) {
        ProductEntity product = productService.getProductById(Id);
        product.setStatus(true);
        productService.saveProduct(product);
        return "redirect:/admin/product/product";
    }
//-----Category---------------------------------

    @RequestMapping(value = {"/category/category"}, method = RequestMethod.GET)
    public String viewCategory(Model model
    ) {
        model.addAttribute("category", categoryService.getCategories());
        return "admin/category";
    }

    @RequestMapping(value = {"/category/add-category"})
    public String addCategory(Model model
    ) {
        model.addAttribute("category", new CategoryEntity());
        model.addAttribute("action", "/category/save-category");
        return "admin/add-category-form";
    }

    @RequestMapping(value = "/category/save-category", method = RequestMethod.POST)
    public String saveCategory(Model model,
            @ModelAttribute("category") CategoryEntity category
    ) {
        boolean isValidated = true;
        String messageError = "";
        if (category.getName().isEmpty()) {
            messageError = "Vui lòng không bỏ trống category name!!!";
            isValidated = false;
        }
        if (isValidated) {
            model.addAttribute("category", category);
            categoryService.addCategory(category);
            return "redirect:/admin/category/category";
        } else {
            if (category.getId() == 0) {
                model.addAttribute("messageError", messageError);
            } else {
                model.addAttribute("category", categoryService.findCategory(category.getId()));
                model.addAttribute("messageError", messageError);
            }
            return "admin/add-category-form";
        }

    }
    
    @RequestMapping(value = {"/category/edit-category/{id}"})
    public String editCategory(Model model,
            @PathVariable("id") int id
    ) {
        model.addAttribute("category", categoryService.findCategory(id));
        model.addAttribute("action", "category/edit-category");
        return "admin/add-category-form";
    }
    
    @RequestMapping(value = {"/category/disable-category/{id}"})
    public String disableCategory(Model model,
            @PathVariable("id") int Id) {
        CategoryEntity category = categoryService.changeStatus(Id, false);
        return "redirect:/admin/category/category";
    }

    
    @RequestMapping(value = {"/category/enable-category/{id}"})
    public String enableCategory(Model model,
            @PathVariable("id") int Id) {
        CategoryEntity category = categoryService.changeStatus(Id, true);
        return "redirect:/admin/category/category";
    }

//-----Promotion---------------------------------
    @RequestMapping(value = {"/promotion/promotion"}, method = RequestMethod.GET)
    public String viewPromotion(Model model
    ) {
        model.addAttribute("promotion", promotionService.findPromotion());
        return "admin/promotion";
    }

    @RequestMapping(value = {"/promotion/detail-promotion/{id}"})
    public String promotionDetail(Model model,
            @PathVariable("id") int id) {
        model.addAttribute("promotion", promotionService.findPromotionById(id));
        model.addAttribute("products", productService.getProductByPromotionId(id));
        return "admin/promotion-detail";
    }

    @RequestMapping(value = {"/promotion/add-promotion"})
    public String addPromotion(Model model) {
        model.addAttribute("promotion", new PromotionEntity());
        model.addAttribute("action", "promotion/add-promotion");
        return "admin/promotion-form";
    }

    @RequestMapping(value = "/promotion/add-promotion", method = RequestMethod.POST)
    public String savePromotion(Model model,
            @ModelAttribute("promotion") PromotionEntity promotion,
            @RequestParam(name = "file", required = false) MultipartFile image,
            @Value(value = "${pathSaveImage}") String pathSaveImages
    ) {
        String errorMessage = "";
        String savedPath;
        boolean isValidated = true;
        if (promotion.getDescription().isEmpty() || promotion.getDiscount() == 0) {
            errorMessage = "Không thể bỏ trống!!!";
            model.addAttribute("errorMessage", errorMessage);
            isValidated = false;
        } else if (promotion.getDiscount() < 0 || promotion.getDiscount() > 1) {
            errorMessage = "Không thể lớn < 0 hoặc >1 !!!";
            model.addAttribute("errorMessage", errorMessage);
            isValidated = false;
        } else if (promotion.getStartDate() == null || promotion.getEndDate() == null) {
            errorMessage = "Không thể bỏ trống ngày!!!";
            model.addAttribute("errorMessage", errorMessage);
            isValidated = false;
        } else if (promotion.getStartDate().after(promotion.getEndDate())) {
            errorMessage = "Nhập sai ngày!!!";
            model.addAttribute("errorMessage", errorMessage);
            isValidated = false;
        } else if (image.getOriginalFilename().isEmpty()) {
            promotion.setImage(promotion.getImage());
            isValidated = true;
        } else {
            try {
                byte[] bytes = image.getBytes();

                //Get path to resources
                String pathUrl = context.getRealPath("/images");
                int index = pathUrl.indexOf("target");
                String pathFolder = pathUrl.substring(0, index) + pathSaveImages;
                savedPath = "resources/images/landingPage/products/" + image.getOriginalFilename();
                promotion.setImage(savedPath);
                //Save file
                File storedFile = new File(pathFolder + File.separator + image.getOriginalFilename());
                BufferedOutputStream buffer = new BufferedOutputStream(new FileOutputStream(storedFile));

                buffer.write(bytes);
                buffer.close();
                isValidated = true;
            } catch (IOException ex) {
                model.addAttribute("errorMessage", "Error can't add promotion");
                return "error";
            }

        }
        if (isValidated) {            
            model.addAttribute("promotion", promotion);
            promotion.setProducts(productService.getProductByPromotionId(promotion.getId()));
            promotionService.addPromotion(promotion);
            return "redirect:/admin/promotion/promotion";
        } else {
            if (promotion.getId() == 0) {
                model.addAttribute("errorMessage", errorMessage);
            } else {
                model.addAttribute("messageError", errorMessage);
                model.addAttribute("promotion", promotionService.findPromotionById(promotion.getId()));
                model.addAttribute("action", "promotion/edit-promotion");
            }
            return "admin/promotion-form";
        }
    }

    @RequestMapping(value = {"/promotion/edit-promotion/{id}"})
    public String editPromotion(Model model,
            @PathVariable("id") int id
    ) {
        model.addAttribute("promotion", promotionService.getPromotion(id));
        model.addAttribute("action", "promotion/edit-promotion");
        return "admin/promotion-form";
    }

    @RequestMapping(value = {"/promotion/disable-promotion/{id}"})
    public String disablePromotion(Model model,
            @PathVariable("id") int Id
    ) {
        PromotionEntity promotion = promotionService.getPromotion(Id);
        promotion.setStatus(false);
        promotionService.addPromotion(promotion);
        return "redirect:/admin/promotion/promotion";
    }

    @RequestMapping(value = {"/promotion/enable-promotion/{id}"})
    public String enablePromotion(Model model,
            @PathVariable("id") int Id
    ) {
        PromotionEntity promotion = promotionService.getPromotion(Id);
        promotion.setStatus(true);
        promotionService.addPromotion(promotion);
        return "redirect:/admin/promotion/promotion";
    }

    @RequestMapping(value = {"/promotion/promotionForProduct/{id}"}, method = RequestMethod.GET)
    public String promotionForProduct(Model model,
            @PathVariable("id") int Id
    ) {
        model.addAttribute("promotion", promotionService.findPromotionById(Id));
        model.addAttribute("product", productService.findProducts());
        model.addAttribute("action", "promotion/promotionForProduct");
        return "admin/promotionForProduct";
    }

    @RequestMapping(value = {"/promotion/promotionForProduct"}, method = RequestMethod.POST)
    public String savePromotionForProduct(Model model,
            @RequestParam("id") int id,
            @RequestParam(name = "productTemp", required = false) List<Integer> prodpuctIds
    ) {
        PromotionEntity promotion = promotionService.findPromotionById(id);
        Set<ProductEntity> products = new HashSet<>();
        try {
            prodpuctIds.size();
        } catch (Exception ex) {
            promotion.setProducts(products);
            promotionService.addPromotion(promotion);
            return "redirect:/admin/promotion/promotion";
        }
        for (int productId : prodpuctIds) {
            ProductEntity product = productService.getProductById(productId);
            products.add(product);
        }
        promotion.setProducts(products);
        promotionService.addPromotion(promotion);
        return "redirect:/admin/promotion/promotion";
    }

//----Orders----------------------------------------------------------------------
    @RequestMapping("/order/order")
    public String getOrder(Model model
    ) {
        double total = 0;
        for (OrderEntity findOrder : orderService.findOrders()) {
            if (findOrder.getStatus().equals(OrderStatus.DONE)) {
                total += findOrder.getTotalPrice();
            }
        }
        model.addAttribute("os", OrderStatus.values());
        model.addAttribute("total", total);
        model.addAttribute("order", orderService.findOrders());
        return "admin/order";
    }

    @RequestMapping("/order/new-order")
    public String getNewOrder(Model model
    ) {
        model.addAttribute("os", OrderStatus.values());
        model.addAttribute("order", orderService.getOrdersByStatus(OrderStatus.NEW));
        return "admin/order";
    }

    @RequestMapping("/order/making-order")
    public String getMakingOrder(Model model
    ) {
        model.addAttribute("os", OrderStatus.values());
        model.addAttribute("order", orderService.getOrdersByStatus(OrderStatus.MAKING));
        return "admin/order";
    }

    @RequestMapping("/order/shipping-order")
    public String getShipingOrder(Model model
    ) {
        model.addAttribute("os", OrderStatus.values());
        model.addAttribute("order", orderService.getOrdersByStatus(OrderStatus.SHIPPING));
        return "admin/order";
    }

    @RequestMapping("/order/cancel-order")
    public String getCancelOrder(Model model
    ) {
        model.addAttribute("os", OrderStatus.values());
        model.addAttribute("order", orderService.getOrdersByStatus(OrderStatus.CANCELED));
        return "admin/order";
    }

    @RequestMapping("/order/done-order")
    public String getDoneOrder(Model model
    ) {
        double total = 0;
        model.addAttribute("os", OrderStatus.values());
        for (OrderEntity findOrder : orderService.findOrders()) {
            if (findOrder.getStatus().equals(OrderStatus.DONE)) {
                total += findOrder.getTotalPrice();
            }
        }
        model.addAttribute("total", total);
        model.addAttribute("order", orderService.getOrdersByStatus(OrderStatus.DONE));
        return "admin/order";
    }

    @RequestMapping("/order/orderDetail/{id}")
    public String getOrderDetails(Model model,
            @PathVariable("id") int Id
    ) {
        OrderEntity order = orderService.findOrder(Id);
        order.setOrderDetails(orderDetailService.findByOrderId(Id));
        model.addAttribute("orderDetail", order);
        return "admin/orderDetail";
    }

    @RequestMapping(value = {"/order/searchOrder"})
    public String searchOrder(Model model,
            @RequestParam(name = "startDate") String startDate,
            @RequestParam(name = "endDate") String endDate,
            @RequestParam(name = "osTemp", required = false) List<OrderStatus> orderStatuses,
            HttpSession session) throws ParseException {

        String messageError = "";
        model.addAttribute("os", OrderStatus.values());
        if (startDate.isEmpty() || endDate.isEmpty()) {
            messageError = "Vui lòng không bỏ trống ngày!!!";
            model.addAttribute("messageError", messageError);
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date s = sdf.parse(startDate);
            Date e = sdf.parse(endDate);
            if (orderService.getOrderByDate(s, e).isEmpty()) {
                messageError = "Không có dữ liệu!!!";
                model.addAttribute("messageError", messageError);
            } else {
                if (orderStatuses == null) {
                    double total = 0;
                    for (OrderEntity findOrder : orderService.getOrderByDate(s, e)) {
                        if (findOrder.getStatus().equals(OrderStatus.DONE)) {
                            total += findOrder.getTotalPrice();
                        }
                    }
                    model.addAttribute("e", e);
                    model.addAttribute("s", s);
                    model.addAttribute("total", total);
                    List<OrderEntity> order = orderService.getOrderByDate(s, e);
                    model.addAttribute("order", order);
                    session.setAttribute("order", order);
                    return "admin/searchOrder";
                } else if (orderService.searchOrder(s, e, orderStatuses).isEmpty()) {
                    messageError = "Không có dữ liệu!!!";
                    model.addAttribute("messageError", messageError);
                } else {
                    double total = 0;
                    for (OrderEntity findOrder : orderService.searchOrder(s, e, orderStatuses)) {
                        if (findOrder.getStatus().equals(OrderStatus.DONE)) {
                            total += findOrder.getTotalPrice();
                        }
                    }
                    model.addAttribute("e", e);
                    model.addAttribute("s", s);
                    model.addAttribute("total", total);
                    List<OrderEntity> order = orderService.searchOrder(s, e, orderStatuses);
                    model.addAttribute("order", order);
                    session.setAttribute("order", order);
                    return "admin/searchOrder";
                }

            }
        }
        model.addAttribute("messageError", messageError);
        return this.getOrder(model);
    }

    @RequestMapping(value = {"/order/change-order/{id}"})
    public String changeOrder(Model model,
            @PathVariable("id") int Id
    ) {
        OrderEntity order = orderService.findOrder(Id);
        if (order.getStatus() == OrderStatus.NEW) {
            order.setStatus(OrderStatus.MAKING);
            orderService.addOrder(order);
            return "redirect:/admin/order/making-order";
        } else {
            if (order.getStatus() == OrderStatus.MAKING) {
                order.setStatus(OrderStatus.SHIPPING);
                order.setShippingDate(new Date());
                orderService.addOrder(order);
                return "redirect:/admin/order/shipping-order";
            } else {
                order.setStatus(OrderStatus.DONE);
                orderService.addOrder(order);
                return "redirect:/admin/order/done-order";
            }
        }
    }

    @RequestMapping(value = {"/order/cancel-order/{id}"})
    public String cancelOrder(Model model,
            @PathVariable("id") int Id
    ) {
        OrderEntity order = orderService.findOrder(Id);
        order.setStatus(OrderStatus.CANCELED);
        orderService.addOrder(order);
        return "redirect:/admin/order/order";
    }

    @RequestMapping(value = {"/order/export-file"})
    public ModelAndView reportExcel(HttpSession session
    ) {
        ModelAndView newView = new ModelAndView("ExcelView");
        List<OrderEntity> newList = (List<OrderEntity>) session.getAttribute("order");
        for (OrderEntity orderEntity : newList) {
            orderEntity.setOrderDetails(orderDetailService.findByOrderId(orderEntity.getId()));
        }
        newView.addObject("newOrders", newList);
        session.removeAttribute("order");
        return newView;

    }
//----Account----------------------------------------------------------------------

    @RequestMapping("/account/account")
    public String getAccount(Model model
    ) {
        model.addAttribute("account", accountService.findAllAccount());
        return "admin/account";
    }

    @RequestMapping(value = {"/account/disable-account/{id}"})
    public String disableAccount(Model model,
            @PathVariable("id") int Id
    ) {
        AccountEntity account = accountService.findAccountById(Id);
        account.setStatus(false);
        accountService.addAccount(account);
        return "redirect:/admin/account/account";
    }

    @RequestMapping(value = {"/account/enable-account/{id}"})
    public String enableAccount(Model model,
            @PathVariable("id") int Id
    ) {
        AccountEntity account = accountService.findAccountById(Id);
        account.setStatus(true);
        accountService.addAccount(account);
        return "redirect:/admin/account/account";
    }

    @RequestMapping(value = {"/account/promote-account/{id}"})
    public String promoteAccount(Model model,
            @PathVariable("id") int Id
    ) {
        model.addAttribute("roles", roleService.findAllRoles());
        model.addAttribute("account", accountService.findAccountById(Id));
        model.addAttribute("action", "account/update-promote-account");
        return "admin/promote";
    }

    @RequestMapping(value = {"/account/update-promote-account"}, method = RequestMethod.POST)
    public String promoteAccount(Model model,
            @ModelAttribute("account") AccountEntity account,
            @RequestParam(name = "roleTemp", required = false) List<Integer> roleIds
    ) {
        Set<RoleEntity> roles = new HashSet<>();
        String messageError = "";
        boolean isValidated = true;

        if (roleIds == null) {
            messageError = "Vui lòng không bỏ trống role!!!";
            isValidated = false;
        } else {
            for (int roleId : roleIds) {
                RoleEntity role = roleService.findRole(roleId);
                roles.add(role);
            }
            account.setRoles(roles);
        }
        if (isValidated) {
            accountService.addAccount(account);
            return "redirect:/admin/account/account";
        } else {
            model.addAttribute("messageError", messageError);
            model.addAttribute("account", accountService.findAccountById(account.getId()));
            model.addAttribute("roles", roleService.findAllRoles());
            model.addAttribute("action", "account/update-promote-account");
        }
        return "admin/promote";
    }

//----Test----------------
    @RequestMapping("/test")
    public String test(Model model
    ) {
        return "admin/tesst";
    }
}
