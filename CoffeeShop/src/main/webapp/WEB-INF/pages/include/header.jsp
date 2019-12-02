<%-- 
    Document   : head
    Created on : Oct 7, 2019, 9:25:00 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:set var="totalQuantity" value="0"/>
<c:forEach var="orderDetail" items="${sessionScope.orderDetails}">
    <c:set var="totalQuantity" value="${totalQuantity + orderDetail.quantity}"/>
</c:forEach>
<style>
    .cart-icon::after{
        content: attr(data);
        <c:if test="${totalQuantity == 0}">
            display: none;
        </c:if>
    }
</style>
<header>
    <div class="search">
        <img src="${pageContext.request.contextPath}/resources/images/landingPage/logo.jpg" alt="logo" class="logo"
             onclick="window.location = '<c:url value="/home"/>'" />
        <input type="text" name="" placeholder="Tìm kiếm" id="search__box"/>
        <img src="${pageContext.request.contextPath}/resources/images/landingPage/search-icon.svg" alt="search" id="search__icon" />
    </div>
    <div class="control">
        <a href="#contact">LIÊN HỆ</a>
        <a href="<c:url value="/khuyen-mai"/>">KHUYỄN MÃI</a>
        <a href="#" onclick="displayMenu('menu-show')">MENU</a>
        <div class="cart-icon" data="${totalQuantity}" display=none>
            <img src="${pageContext.request.contextPath}/resources/images/landingPage/cart_icon.svg" alt="cart" 
                 onclick="window.location = '<c:url value="/gio-hang"/>'" />
        </div>
        <div class="menu">
            <div class="line"></div>
            <div class="line"></div>
            <div class="line"></div>
            <ul class="menu__sub">
                <li class="menu-content-responsive">
                    <a href="#" onclick="displayMenu('menu-show')">MENU</a>
                </li>
                <li class="menu-content-responsive">
                    <a href="#" onclick="displayMenu('promotion-show')">KHUYỄN MÃI</a>
                </li>
                <li class="menu-content-responsive">
                    <a href="#contact">LIÊN HỆ</a>
                </li>
                <li>
                    <a>CHÍNH SÁCH</a>
                </li>
                <li style="border-bottom: 0.5px solid black">
                    <a href="#">PHẢN HỒI</a>
                </li>
                <sec:authorize access="!isAuthenticated()">
                    <li>
                        <a href='<c:url value="/dang-nhap"/>'>ĐĂNG NHẬP</a>
                    </li>
                    <li>
                        <a href='<c:url value="/dang-ky"/>'>ĐĂNG KÝ</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_SELLER','ROLE_MANAGER')">
                    <li>
                        <a href='<c:url value="/admin/home"/>'>QUẢN LÝ</a>
                    </li>
                    <li>
                        <a href='<c:url value="/dang-xuat"/>'>ĐĂNG XUẤT</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication var="user" property="principal"/>
                    <sec:authorize access="!${user.status}">    
                        <li>
                            <a href='<c:url value="/user/thong-tin-ca-nhan"/>'>HỒ SƠ</a>
                        </li>
                        <li>
                            <a href='<c:url value="/xac-thuc-email?email=${user.email}"/>'>XÁC THỰC</a>
                        </li>
                        <li>
                            <a href='<c:url value="/dang-xuat"/>'>ĐĂNG XUẤT</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_USER') && ${user.status}">
                        <li>
                            <a href="<c:url value="/user/don-hang-cua-ban"/>">ĐƠN HÀNG CỦA BẠN</a>
                        </li>
                        <li>
                            <a href='<c:url value="/user/thong-tin-ca-nhan"/>'>HỒ SƠ</a>
                        </li>
                        <li>
                            <a href='<c:url value="/dang-xuat"/>'>ĐĂNG XUẤT</a>
                        </li>
                    </sec:authorize>
                </sec:authorize>
            </ul>
        </div>
    </div>
</header>
<div id="menu-show" class="menu-show">
    <img src="${pageContext.request.contextPath}/resources/images/header/menu_teaffee.jpg" alt="Menu">
</div>

<div id="promotion-show" class="menu-show">
    <c:forEach var="promotion" items="${promotions}">
        <c:if test="${!empty promotion.image}">
            <img src="${pageContext.request.contextPath}/${promotion.image}" alt="">
            <br>
        </c:if>
    </c:forEach>
</div>