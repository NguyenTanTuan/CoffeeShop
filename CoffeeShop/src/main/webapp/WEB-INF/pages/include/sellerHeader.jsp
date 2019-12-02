<%-- 
    Document   : sellerHeader
    Created on : Nov 11, 2019, 2:51:05 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:set var="sellerOrderDetails" value="${sessionScope.sellerOrderDetails}"/>
<c:set var="totalQuantity" value="0"/>
<c:forEach var="orderDetail" items="${sellerOrderDetails}">
    <c:set var="totalQuantity" value="${totalQuantity + orderDetail.quantity}"/>
</c:forEach>
<div class="container">
    <h1>TRANG BÁN HÀNG</h1>
</div>
<div id="exTab1" class="container" style="width: 100%">	
    <ul  class="nav nav-pills">
        <li>
            <a  href="<c:url value="/seller/home"/>" >Sản phẩm</a>
        </li>
        <li><a href="<c:url value="/seller/gio-hang"/>">Giỏ hàng
                <span class="badge">${totalQuantity}</span></a>
        </li>
        <li><a href="<c:url value="/seller/don-hang-online"/>" >Đơn hàng online</a>
        </li>
        <li ><a href="<c:url value="/seller/don-hang-dang-ship"/>">Đơn hàng đang ship</a>
        </li>
        <li>
            <a  href="<c:url value="/admin/"/>" style="color: blue" >Quản lý</a>
        </li>
        <li><a href="<c:url value="/dang-xuat"/>" style="color: blue">Đăng xuất</a></li>
    </ul>
