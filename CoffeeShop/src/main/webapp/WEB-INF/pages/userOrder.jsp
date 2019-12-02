<%-- 
    Document   : userOrder
    Created on : Nov 6, 2019, 7:10:47 PM
    Author     : admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đơn đặt hàng của bạn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/standard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cartStyle.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
        <style>
            .row--active:hover{
                cursor: pointer;
                color: #1ebb47;
                font-weight: 600;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    </head>
    <body>
        <sec:authentication var="user" property="principal"/>
        <jsp:include page="include/header.jsp"/>

        <main>
            <div class="title main__element--background">
                <h1>ĐƠN HÀNG</h1>
            </div>
            <div class="list-product main__element--background">
                <table>
                    <thead>
                        <tr>
                            <th colspan="6"><h2>ĐƠN HÀNG ĐANG XỬ LÝ</h2></th>
                        </tr>
                        <tr>
                            <th>MÃ ĐƠN</th>
                            <th>NGÀY ĐẶT</th>
                            <th>SỐ LƯỢNG</th>
                            <th>TỔNG GIÁ TIỀN</th>
                            <th>TRẠNG THÁI</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody style="text-align: center">
                        <c:forEach var="order" items="${orders}">
                            <c:if test="${order.status != 'DONE' and order.status != 'CANCELED'}">
                                <tr class="row--active"
                                    onclick="window.location = '<c:url value="/user/chi-tiet-don-hang/${order.id}"/>'">
                                    <td>${order.id}</td>
                                    <td><fmt:formatDate pattern="dd-MM-yyyy" value="${order.orderDate}"/></td>
                                    <c:set var="totalQuantity" value="0"/>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <c:set var="totalQuantity" value="${totalQuantity + orderDetail.quantity}"/>
                                    </c:forEach>
                                    <td>${totalQuantity}</td>
                                    <td><fmt:formatNumber type="number" pattern="###,###" value="${order.totalPrice}"/>đ</td>
                                    <td>${order.status}</td>
                                    <td>
                                        <c:if test="${order.status == 'NEW'}">
                                            <a href="<c:url value="/user/huy-don-hang/${order.id}"/>" 
                                               class="delete-product action-order-detail">HỦY</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>

                        </c:forEach>
                    </tbody>
                </table>

                <hr style="width: 100%; height: 10px; background-color: grey;">

                <table>
                    <thead>
                        <tr>
                            <th colspan="6"><h2>LỊCH SỬ ĐẶT HÀNG</h2></th>
                        </tr>
                        <tr>
                            <th>MÃ ĐƠN</th>
                            <th>NGÀY ĐẶT</th>
                            <th>THỜI ĐIỂM SHIP</th>
                            <th>SỐ LƯỢNG</th>
                            <th>TỔNG GIÁ TIỀN</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody style="text-align: center">
                        <c:forEach var="order" items="${orders}">
                            <c:if test="${order.status == 'DONE'}">
                                <tr>
                                    <td>${order.id}</td>
                                    <td><fmt:formatDate pattern="dd-MM-yyyy" value="${order.orderDate}"/></td>
                                    <td><fmt:formatDate pattern="dd-MM-yyyy HH:mm" value="${order.shippingDate}"/></td>
                                    <c:set var="totalQuantity" value="0"/>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <c:set var="totalQuantity" value="${totalQuantity + orderDetail.quantity}"/>
                                    </c:forEach>
                                    <td>${totalQuantity}</td>
                                    <td><fmt:formatNumber type="number" pattern="###,###" value="${order.totalPrice}"/>đ</td>
                                    <td>${order.status}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
        <script>
            let tbodys = document.getElementsByTagName('tbody');
            for(let tbody of tbodys){
                if(tbody.innerText.toString().trim() === '')
                    tbody.innerHTML = '<tr><td colspan="5"><h1>Không có đơn hàng nào</h1></td></tr>'
            }
        </script>
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/script/standardScript.jsp"/>
    </body>
</html>
