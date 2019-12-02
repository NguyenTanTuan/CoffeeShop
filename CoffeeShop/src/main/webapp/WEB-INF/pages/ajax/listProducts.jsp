<%-- 
    Document   : listProduct
    Created on : Oct 17, 2019, 4:30:22 PM
    Author     : admin
--%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<c:if test="${products.size() > 0}">
    <c:forEach var="product" items="${products}">
        <div class="product__item" id="product${product.id}">
            <c:choose>
                <c:when test="${!empty product.images[0].path or product.images[0].path != null}">
                    <img src="${product.images[0].path}" alt="product">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/images/landingPage/products/no_image.png" alt="product">
                </c:otherwise>
            </c:choose>
            <a href="<c:url value="/chi-tiet-san-pham/${product.id}"/>" class="product__item--name">
                ${product.name}
                <c:if test="${product.status == false}">
                    <span style="color: #999; font-size: 0.8em;">(Đã hết)</span>
                </c:if>
            </a>
            <c:set var="totalDiscount" value="${product.price + product.sizes.toArray()[0].addition}"/>
            <c:if test="${product.promotions.size() > 0}">
                <c:forEach var="promotion" items="${product.promotions}">
                    <c:set var="totalDiscount" value="${totalDiscount*(1 - promotion.discount)}"/>
                </c:forEach>
                <p class="product__item--price">
                    <span style="text-decoration: line-through; color: grey;"><fmt:formatNumber type="number" pattern="###,###" value="${product.price + product.sizes.toArray()[0].addition}"/>đ</span>
                    <br>
                    <span style="font-weight: 600;">
                        <fmt:formatNumber type="number" 
                                          pattern="###,###,###" 
                                          value="${totalDiscount}"/>đ</span>
                </p>
            </c:if>
            <c:if test="${product.promotions.size() == 0}">
                <p class="product__item--price" style="font-weight: 600;">
                    <fmt:formatNumber type="number" pattern="###,###" value="${totalDiscount}"/>đ
                </p>
            </c:if>
            <p class="product__item--vote">
                <c:set var="countStar" value="0"/>
                <c:set var="totalStar" value="0"/>
                <c:forEach var="star" items="${product.votes}">
                    <c:set var="countStar" value="${countStar + 1}"/>
                    <c:set var="totalStar" value="${totalStar + star.star}"/>
                </c:forEach>
                ${totalStar/countStar}
                <span style="vertical-align: text-bottom">&#11088;</span>
            </p>

            <c:if test="${product.status == true}">
                <div class="product__info">
                    <img src="resources\images\landingPage\products\add-to-cart-icon.svg" alt="add-to-cart">
                    <p>Thêm vào giỏ</p>
                    <c:forEach var="size" items="${product.sizes}">
                        <a href="<c:url value="/mua-nhanh/${product.id}/${size.id}"/>" 
                           class="size">Size ${size.size}</a>
                    </c:forEach>
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication var="user" property="principal"/>
                        <sec:authorize access="${user.status}">
                            <c:if test="${!favorite}">
                                <c:if test="${product.favorites.size() == 0}">
                                    <p class="favorite" id="btn-favorite-${product.id}" onclick="addToFavoriteProduct(${product.id})">Thêm vào yêu thích</p>
                                </c:if>
                                <c:if test="${product.favorites.size() > 0}">
                                    <p class="favorite" id="btn-favorite-${product.id}" onclick="deleteFavoriteProductFromHome(${product.id})">Xóa khỏi yêu thích</p>
                                </c:if>
                            </c:if>
                            <c:if test="${favorite}">
                                <p class="favorite" 
                                   onclick="deleteFavoriteProduct(${product.id})">Xóa khỏi yêu thích</p>
                            </c:if>
                        </sec:authorize>
                    </sec:authorize>
                </div>
            </c:if>
            <p class="tempPrice" style="display: none;">${totalDiscount}</p>
        </div>
    </c:forEach>
</c:if>

<c:if test="${products.size() == 0 || products == null}">
    <h2>Không có sản phẩm nào</h2>
</c:if>