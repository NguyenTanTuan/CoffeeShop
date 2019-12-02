<%-- 
    Document   : DiscountedProducts
    Created on : Nov 7, 2019, 10:00:02 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/standard.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
<style>
#slide-show {
	height: 300px;
	overflow: hidden;
}

#slide-show img {
	display: block;
	height: 100%;
	margin: auto;
}
</style>
<title>Khuyến mãi</title>
</head>
<body>
	<jsp:include page="include/header.jsp" />
	<div id="slide-show">
		<c:forEach var="promotion" items="${promotions}">
			<img src="${pageContext.request.contextPath}/${promotion.image}"
				alt="khuyen-mai">
		</c:forEach>
	</div>
	<main> <c:if test="${!empty promotions}">
		<div class="sale">
			<h4 class="animation-tranform-color">KHUYẾN MÃI:</h4>
			<c:forEach var="promotion" items="${promotions}">
				<div class="sale__info">
					<a href="<c:url value="/khuyen-mai?id=${promotion.id}"/>">${promotion.description}(Giảm
						${promotion.discount*100}%) <span>Đến hết <fmt:formatDate
								pattern="dd-MM-yyyy" value="${promotion.endDate}" /></span>
					</a>
				</div>
			</c:forEach>
		</div>
	</c:if>
	<div class="filter">
		<p class="spacing">Bộ Lọc:</p>
		<div class="filter__selection">
			<a href="#main" class="spacing" onclick="lowToHighPrice()">Giá từ
				thấp đến cao</a> <a href="#main" class="spacing"
				onclick="highToLowPrice()">Giá từ cao xuống thấp</a> <a href="#main"
				class="spacing" onclick="highToLowVote()">Sản phẩm được đánh giá
				cao</a>
		</div>
	</div>
	<div class="product">
		<c:if test="${!empty products}">
			<c:forEach var="product" items="${products}">
				<div class="product__item" id="product${product.id}">
					<img src="${product.images[0].path}" alt="product"> <a
						href="<c:url value="/chi-tiet-san-pham/${product.id}"/>"
						class="product__item--name"> ${product.name} <c:if
							test="${product.status == false}">
							<span style="color: #999; font-size: 0.8em;">(Đã hết)</span>
						</c:if>
					</a>
					<c:set var="totalDiscount"
						value="${product.price + product.sizes.iterator().next().addition}" />
					<c:if test="${product.promotions.size() > 0}">
						<c:forEach var="promotion" items="${product.promotions}">
							<c:set var="totalDiscount"
								value="${totalDiscount*(1 - promotion.discount)}" />
						</c:forEach>
						<p class="product__item--price">
							<fmt:formatNumber type="number" pattern="###,###"
								value="${product.price + product.sizes.iterator().next().addition}" />
							đ <span style="color: red"> (-<fmt:formatNumber
									type="number" pattern="###,###"
									value="${Math.round(product.price + product.sizes.iterator().next().addition-totalDiscount)}" />đ)
							</span>
						</p>
					</c:if>
					<c:if test="${product.promotions.size() == 0}">
						<p class="product__item--price">
							<fmt:formatNumber type="number" pattern="###,###"
								value="${product.price}" />
							đ
						</p>
					</c:if>
					<p class="product__item--vote">
						<c:set var="countStar" value="0" />
						<c:set var="totalStar" value="0" />
						<c:forEach var="star" items="${product.votes}">
							<c:set var="countStar" value="${countStar + 1}" />
							<c:set var="totalStar" value="${totalStar + star.star}" />
						</c:forEach>
						${totalStar/countStar} <span style="vertical-align: text-bottom">&#11088;</span>
					</p>
					<c:if test="${product.status == true}">
						<div class="product__info">
							<img
								src="resources\images\landingPage\products\add-to-cart-icon.svg"
								alt="add-to-cart">
							<p>Thêm vào giỏ</p>
							<c:forEach var="size" items="${product.sizes}">
								<a
									href="<c:url value="/them-vao-gio-hang/${product.id}/${size.id}"/>"
									class="size">Size ${size.size}</a>
							</c:forEach>
							<sec:authorize access="isAuthenticated()">
								<sec:authentication var="user" property="principal" />
								<sec:authorize access="${user.status}">
									<p class="favorite" id="btn-favorite-${product.id}"
										onclick="addToFavoriteProduct(${product.id})">Thêm vào yêu
										thích</p>
								</sec:authorize>
							</sec:authorize>
						</div>
					</c:if>
					<p class="tempPrice" style="display: none;">${totalDiscount}</p>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty products}">
			<h2>Không có sản phẩm nào</h2>
		</c:if>
	</div>
	</main>
	<jsp:include page="include/footer.jsp" />
	<jsp:include page="include/script/standardScript.jsp" />

	<script
		src="${pageContext.request.contextPath}/resources/js/landingPage.js">
        </script>
	<script>
            let slideShow = document.getElementById('slide-show');
            if (slideShow.children.length > 1) {
                let changeImage = setInterval(function () {
                    let lastImage = slideShow.children[slideShow.children.length - 1].cloneNode(true);
                    slideShow.removeChild(slideShow.children[slideShow.children.length - 1]);
                    slideShow.insertBefore(lastImage, slideShow.firstChild);
                }, 2000);
            }
//            Search
            let searchIcon = document.getElementById('search__icon');
            let searchBox = document.getElementById('search__box');

            let productItemsData = [];

            for (let productItem of document.getElementsByClassName('product__item')) {
                productItemsData.push(productItem);
            }

            searchBox.oninput = function () {
                let searchValue = searchBox.value.toString().toUpperCase();
                let productItems = document.getElementsByClassName('product__item');
                let productContainer = document.getElementsByClassName('product')[0];

                productContainer.innerHTML = '';
                for (let productItem of productItemsData) {
                    let nameProduct = productItem.children[1].innerText;
                    if (nameProduct.toUpperCase().includes(searchValue)) {
                        productContainer.appendChild(productItem);
                    }
                }
            }
            document.getElementById('search__icon').onclick = () => {
                window.location = '#main'
            }
        </script>
</body>
</html>
