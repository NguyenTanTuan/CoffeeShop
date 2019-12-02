<%-- 
    Document   : cart
    Created on : Oct 7, 2019, 11:56:33 PM
    Author     : admin
--%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/standard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cartStyle.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
        <title>Teaffee Shop</title>
    </head>
    <body>
        <c:set var="orderDetails" value="${sessionScope.orderDetails}"/>
        <jsp:include page="../include/header.jsp"/>
        <main>
            <c:if test="${!empty sessionScope.orderDetails}">
                <div class="title main__element--background">
                    <h1>GIỎ HÀNG</h1>
                </div>
                <div class="list-product main__element--background">
                    <table>
                        <thead>
                            <tr>
                                <th></th>
                                <th>Tên sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Size</th>
                                <th>Topping</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody style="text-align: center;">
                            <c:set var="totalPrice" value="0"/>
                            <c:set var="position" value="0"/>
                            <c:forEach var="orderDetail" items="${orderDetails}">
                                <tr>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/${orderDetail.product.images[1].path}" alt="${orderDetail.product.name}">
                                    </td>
                                    <td>${orderDetail.product.name}</td>
                                    <td>
                                        <fmt:formatNumber type="number" pattern="###,###" value="${orderDetail.unitPrice}"/>đ
                                    </td>
                                    <td>
                                        <input type="number" value="${orderDetail.quantity}" class="quantity-input" min="1">
                                        <a href="" class="update-quantity">ok</a>
                                    </td>
                                    <td>
                                        <fmt:formatNumber type="number" pattern="###,###" value="${orderDetail.price}"/>đ
                                    </td>
                                    <td>${orderDetail.size}</td>
                                    <td>
                                        <p class="add-topping action-order-detail" onclick="addTopping(${position})">THÊM</p>
                                    </td>
                                    <td>
                                        <a href="<c:url value="/xoa-san-pham?pos=${position}"/>" class="delete-product action-order-detail">XÓA</a>
                                    </td>
                                </tr>
                                <c:set var="totalPrice" value="${totalPrice + orderDetail.price}"/>
                                <c:set var="position" value="${position + 1}"/>
                            </c:forEach>
                            <tr>
                                <td colspan="8">
                                    <h2>Tổng: <fmt:formatNumber type="number" pattern="###,###" value=" ${totalPrice}"/>đ</h2>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="action">
                    <div class="action__button main__element--background">
                        <a href="<c:url value="/home#main"/>">Tiếp tục mua</a>
                    </div>
                    <div class="action__button main__element--background">
                        <a href="<c:url value="/xoa-gio-hang"/>">Xóa hết</a>
                    </div>
                    <div class="action__button main__element--background">
                        <a href="<c:url value="/dat-hang"/>">Đặt hàng</a>
                    </div>
                </div>
                <div class="container-toppings main__element--background">
                    <mvc:form action="${pageContext.request.contextPath}/them-topping" method="POST">
                        <input type="hidden" value="0" name="orderDetailPosition" id="orderDetailPositionForAddTopping"/>
                        <table>
                            <tr>
                                <th>Chọn Topping:</th>
                            </tr>
                            <c:forEach var="topping" items="${toppings}">
                                <tr>
                                    <td>
                                        <input type="checkbox" value="${topping.id}" name="topping" 
                                               id="topping${topping.id}" class="topping"/>
                                        <label for="topping${topping.id}">${topping.name}(<fmt:formatNumber type="number" pattern="###,###" value="${topping.price}"/>đ)</label>
                                    </td>
                                </tr>
                                <c:set var="countTopping" value="${countTopping + 1}"/>
                            </c:forEach>
                            <tr>
                                <th>
                                    <input type="submit" value="OK"/>
                                </th>
                            </tr>
                        </table>
                    </mvc:form>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.orderDetails}">
                <div class="title main__element--background">
                    <h1>GIỎ HÀNG TRỐNG <br> VUI LÒNG CHỌN SẢN PHẨM</h1>
                </div>
            </c:if>
        </main>
        <script type="text/javascript">
            let orderDetailToppingInput = document.getElementById('orderDetailPositionForAddTopping');
            let toppings = document.getElementsByClassName('topping');
            let containerToppings = document.getElementsByClassName('container-toppings')[0];
            let quantityInput = document.getElementsByClassName('quantity-input');
            let updateQuantity = document.getElementsByClassName('update-quantity');
            
            for(let i = 0 ; i < quantityInput.length ; i++){
                quantityInput[i].oninput = ()=>{
                    console.log('test');
                    updateQuantity[i].style.display  = 'inline-block';
                    updateQuantity[i].href = '<c:url value="/thay-doi-so-luong/"/>' + i + '/' + quantityInput[i].value;
                }
            }
            
            function addTopping(orderDetailPosition) {
                orderDetailToppingInput.value = orderDetailPosition;
                let xhttp = new XMLHttpRequest();
                xhttp.open('GET', '${pageContext.request.contextPath}/tim-ids-topping/' + orderDetailPosition);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        containerToppings.style.display = 'flex';
                        for (let topping of toppings)
                            topping.checked = false;
                        if (xhttp.responseText != "") {
                            console.log(xhttp.responseText);
                            let toppingIds = JSON.parse(xhttp.responseText);

                            for (let toppingId of toppingIds)
                                document.getElementById('topping' + toppingId).checked = true;
                        }
                    }
                }
            }

            containerToppings.onclick = function () {
                if (event.target === this)
                    containerToppings.style.display = 'none';
            };
        </script>
        <jsp:include page="../include/footer.jsp"/>
        <jsp:include page="../include/script/standardScript.jsp"/>
    </body>
</html>
