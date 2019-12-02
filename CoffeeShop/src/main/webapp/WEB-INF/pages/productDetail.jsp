<%-- 
    Document   : cart
    Created on : Oct 7, 2019, 11:56:33 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/standard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/productDetailStyle.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
        <title>Teaffee Shop</title>
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>

        <main>
            <div class="container-product-info">
                <img src="${pageContext.request.contextPath}/${product.images[0].path}" alt="">
                <div class="product-info">
                    <div class="product-info__name">
                        <h1>
                            ${product.name}
                            <c:if test="${product.status == false}">
                                <span style="color: #999; font-size: 0.5em;">-Đã hết-</span>
                            </c:if>
                        </h1>
                    </div>
                    <p class="product-info__decription">
                        ${product.description}
                    </p>
                    <c:if test="${product.promotions.size() > 0}">
                        <c:set var="totalDiscount" value="${product.price + product.sizes.iterator().next().addition}"/>
                        <c:forEach var="promotion" items="${product.promotions}">
                            <c:set var="totalDiscount" value="${totalDiscount*(1 - promotion.discount)}"/>
                        </c:forEach>

                        <p class="product-info__price--promotion">
                            <fmt:formatNumber type="number" pattern="###,###" value="${product.price + product.sizes.iterator().next().addition}"/>đ
                        </p>
                        <p class="product-info__price">
                            <fmt:formatNumber type="number" pattern="###,###" value="${Math.round(totalDiscount)}"/>đ
                        </p>
                    </c:if>
                    <c:if test="${product.promotions.size() == 0}">
                        <p class="product-info__price">
                            <fmt:formatNumber type="number" pattern="###,###" value="${product.price}"/>đ
                        </p>
                    </c:if>

                    <c:if test="${product.status == true}">
                        <div class="product-info__sizes">
                            <p>Cỡ:</p>
                            <c:forEach var="size" items="${product.sizes}">
                                <div class="product-info__sizes__button"><p>${size.size}</p></div>
                                    </c:forEach>
                        </div>
                        <div class="product-info__buy-action">
                            <!--                            <div class="product-info__buy-button">
                                                            <p>Thêm vào giỏ</p>
                                                        </div>-->

                            <div class="product-info__buy-button">
                                <p>Thêm vào giỏ</p>
                            </div>
                        </div>
                    </c:if>
                    <c:set var="countStar" value="0"/>
                    <c:set var="totalStar" value="0"/>
                    <c:forEach var="star" items="${product.votes}">
                        <c:set var="countStar" value="${countStar + 1}"/>
                        <c:set var="totalStar" value="${totalStar + star.star}"/>
                    </c:forEach>
                    <div id="vote">
                        <div class="star"></div>
                        <div class="star"></div>
                        <div class="star"></div>
                        <div class="star"></div>
                        <div class="star"></div>
                    </div>

                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication var="user" property="principal"/>
                        <c:if test="${user.status}">
                            <div>
                                <c:if test="${product.favorites.size() == 0}">
                                    <p class="favorite" id="btn-favorite-${product.id}" onclick="addToFavoriteProduct(${product.id})">Thêm vào yêu thích</p>
                                </c:if>
                                <c:if test="${product.favorites.size() > 0}">
                                    <p class="favorite" id="btn-favorite-${product.id}" onclick="deleteFavoriteProductFromHome(${product.id})">Xóa khỏi yêu thích</p>
                                </c:if>
                            </div>
                        </c:if>
                    </sec:authorize>
                </div>
            </div>
        </main>    
        <div id="popup-message">
            <div class="container">
                <h2></h2>
            </div>
        </div>
        <script type="text/javascript">
            let sizes = document.getElementsByClassName('product-info__sizes__button');
            let buyFast = document.getElementsByClassName('product-info__buy-button')[1];
            let addToCart = document.getElementsByClassName('product-info__buy-button')[0];
            let sizeId = ${product.sizes.iterator().next().id};
            let stars = document.getElementsByClassName('star');
            let totalStar = ${totalStar/countStar};
            let vote = document.getElementById('vote');
            for (let size of sizes) {
                size.onclick = () => {
                    for (let size of sizes)
                        size.classList.remove('product-info__sizes__button--active');
                    size.classList.add('product-info__sizes__button--active');
                    if (size.children[0].innerHTML == "S")
                        sizeId = 1;
                    else if (size.children[0].innerHTML == "M")
                        sizeId = 2;
                    else if (size.children[0].innerHTML == "L")
                        sizeId = 3;
                }
            }
//          Star
            addSelectedToStars(totalStar);
            <sec:authorize access="isAuthenticated()">
                <sec:authentication var="user" property="principal"/>
                <sec:authorize access="${user.status}">
            vote.onmouseover = () => {
                for (let star of stars) {
                    star.classList.remove('selected');
                }
            }
            vote.onmouseout = () => addSelectedToStars(totalStar);
//          set onclick per star
            for (let i = 0; i < 5; i++) {
                stars[i].onclick = () => {
                    let xhttp = new XMLHttpRequest();
                    xhttp.open('GET', '${pageContext.request.contextPath}/user/them-danh-gia/${product.id}/' + (5 - i), true);
                    xhttp.send();
                    xhttp.onreadystatechange = () => {
                        if (xhttp.readyState == 4 && xhttp.status == 200) {
                            totalStar = parseInt(xhttp.responseText);
                            // Show popup in 1s then hide
                            document.getElementById('popup-message').children[0].children[0].innerHTML = "Bạn đã đánh giá " + (5 - i) + " sao";
                            document.getElementById('popup-message').style.display = 'flex';
                            setTimeout(() => {
                                document.getElementById('popup-message').style.display = 'none';
                            }, 1000);
                        }
                    }
                }
            }
//
                </sec:authorize>
            </sec:authorize>
//            buyFast.onclick = () => {
//                window.location = '<c:url value="/mua-nhanh/${product.id}/"/>' + sizeId;
//            }

            let showedTotalQuantity = false;
            addToCart.onclick = () => {
                let xhttp = new XMLHttpRequest();
                let linkToProcess = '<c:url value="/them-vao-gio-hang/${product.id}/"/>' + sizeId;
                xhttp.open('GET', linkToProcess, true);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        let cartIcon = document.getElementsByClassName('cart-icon')[0];
                        let currentQuantity = parseInt(cartIcon.getAttribute('data'));
                        console.log(currentQuantity);
                        cartIcon.setAttribute('data', currentQuantity + 1);
                        if (!showedTotalQuantity) {
                            cartIcon.innerHTML += '<style>.cart-icon::after{display:block;}</style>';
                            showedTotalQuantity = true;
                        }
                        // Show popup in 1s then hide
                        document.getElementById('popup-message').children[0].children[0].innerHTML = "Đã thêm vào giỏ hàng";
                        document.getElementById('popup-message').style.display = 'flex';
                        setTimeout(() => {
                            document.getElementById('popup-message').style.display = 'none';
                        }, 1000);
                    }
                }
            }
            function addSelectedToStars(numberStar) {
                numberStar = Math.round(numberStar);
                for (let star of stars) {
                    star.classList.remove('selected');
                }
                for (let i = 4; i >= 5 - numberStar; i--) {
                    stars[i].classList.add('selected');
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
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/script/standardScript.jsp"/>
    </body>
</html>
