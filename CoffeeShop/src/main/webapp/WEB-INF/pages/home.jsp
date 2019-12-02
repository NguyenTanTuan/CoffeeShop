<%-- 
    Document   : home
    Created on : Sep 29, 2019, 7:55:06 PM
    Author     : admin
--%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/standard.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
        <title>Teaffee Shop</title>
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        <div class="show-image">
            <div class="animation-shop">
                <a href="#main">SHOP NOW</a>
                <img src="resources\images\landingPage\angle-arrow-down-icon.svg" alt="down-arrow">
            </div>
        </div>
        <main id="main">
            <c:if test="${!empty promotions}">
                <div class="sale">
                    <h4 class="animation-tranform-color">KHUYẾN MÃI:</h4>
                    <c:forEach var="promotion" items="${promotions}">
                        <div class="sale__info">
                            <a href="<c:url value="/khuyen-mai?id=${promotion.id}"/>">${promotion.description}(Giảm ${promotion.discount*100}%) 
                                <span>Đến hết <fmt:formatDate pattern="dd-MM-yyyy" value="${promotion.endDate}"/></span></a>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <div class="filter">
                <p class="spacing">Bộ Lọc:</p>
                <div class="filter__selection">
                    <a href="#main" class="spacing" onclick="lowToHighPrice()">Giá từ thấp đến cao</a>
                    <a href="#main" class="spacing" onclick="highToLowPrice()">Giá từ cao xuống thấp</a>
                    <a href="#main" class="spacing" onclick="highToLowVote()">Sản phẩm được đánh giá cao</a>
                </div>
            </div>
            <nav>
                <ul class="category">
                    <li class="category__item-header">
                        <h2>Danh mục:</h2>
                    </li>
                    <li class="category__item <c:if test="${isSearching != true}">category__item--border category__item--active</c:if>">
                        <p>Best choose</p>
                    </li>
                    <c:forEach var="category" items="${categories}">
                        <c:if test="${category.status == true}">
                            <li class="category__item">
                                <p>${category.name}</p>
                            </li>
                        </c:if>
                    </c:forEach>
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication var="user" property="principal"/>
                        <sec:authorize access="${user.status}">
                            <li class="category__item" style="color: #F66">
                                <p>Yêu thích</p>
                            </li>
                        </sec:authorize>
                    </sec:authorize>
                </ul>
            </nav>
            <div class="product">
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
                            <p class="product__item--price">
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
                                        <c:if test="${product.favorites.size() == 0}">
                                            <p class="favorite" id="btn-favorite-${product.id}" onclick="addToFavoriteProduct(${product.id})">Thêm vào yêu thích</p>
                                        </c:if>
                                        <c:if test="${product.favorites.size() > 0}">
                                            <p class="favorite" id="btn-favorite-${product.id}" onclick="deleteFavoriteProductFromHome(${product.id})">Xóa khỏi yêu thích</p>
                                        </c:if>
                                    </sec:authorize>
                                </sec:authorize>
                            </div>
                        </c:if>
                        <p class="tempPrice" style="display: none;">${totalDiscount}</p>
                    </div>
                </c:forEach>
            </div>
        </main>
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/script/standardScript.jsp"/>

        <script src="${pageContext.request.contextPath}/resources/js/landingPage.js">
        </script>
        <script>
            let product = document.getElementsByClassName('product')[0];
            let searchBox = document.getElementById('search__box');
            let searchBtn = document.getElementById('search__icon');
            let xhttp;
            categoryItems = document.getElementsByClassName('category__item');

            for (let categoryItem of categoryItems) {
                categoryItem.addEventListener('click', function () {
                    getAllProductByCategoryName(categoryItem.children[0].innerHTML)
                });
            }

            searchBtn.onclick = () => {
                console.log(searchBox.value);
                xhttp = new XMLHttpRequest();
                xhttp.open('GET', '${pageContext.request.contextPath}/tim-kiem-san-pham?name=' + searchBox.value, true)
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        product.innerHTML = xhttp.responseText;
                    }
                }
                for (let i = 0; i < categoryItems.length; i++) {
                    categoryItems[i].classList.remove('category__item--active');
                    categoryItems[i].classList.remove('category__item--border');
                }
                if (!window.location.href.includes("#main"))
                    window.location += '#main';
                else
                    window.location += '';
            }

            function getAllProductByCategoryName(name) {
                xhttp = new XMLHttpRequest();
                name = name.toLowerCase();
                if (name == 'yêu thích')
                    xhttp.open('GET', '${pageContext.request.contextPath}/user/list-san-pham-yeu-thich', true);
                else
                    xhttp.open('GET', '${pageContext.request.contextPath}/list-san-pham?name=' + name, true);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        product.innerHTML = xhttp.responseText;
                    }
                }
            }

            function addToFavoriteProduct(productId) {
                xhttp = new XMLHttpRequest();
                xhttp.open('GET', '<c:url value="/user/them-vao-yeu-thich/"/>' + productId, true);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        document.getElementById('btn-favorite-' + productId)
                                .innerHTML = 'Xóa khỏi yêu thích';
                        
                        document.getElementById('btn-favorite-' + productId)
                                .setAttribute("onclick", 'deleteFavoriteProductFromHome(' + productId + ')');
                    }
                }
            }

            function deleteFavoriteProduct(productId) {
                xhttp = new XMLHttpRequest();
                xhttp.open('GET', '${pageContext.request.contextPath}/user/xoa-san-pham-yeu-thich/' + productId, true);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        document.getElementById('product' + productId).remove();
                        if (document.getElementsByClassName('product')[0].innerText == "") {
                            document.getElementsByClassName('product')[0].innerHTML = "<h2>Không có sản phẩm nào</h2>"
                        }
                    }
                }
            }
            function deleteFavoriteProductFromHome(productId) {
                xhttp = new XMLHttpRequest();
                xhttp.open('GET', '${pageContext.request.contextPath}/user/xoa-san-pham-yeu-thich/' + productId, true);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        document.getElementById('btn-favorite-' + productId)
                                .innerHTML = 'Thêm vào yêu thích';
                        
                        document.getElementById('btn-favorite-' + productId)
                                .setAttribute("onclick", 'addToFavoriteProduct(' + productId + ')');
                    }
                }
            }
        </script>
    </body>
</html>
