<%-- 
    Document   : check-out
    Created on : Oct 8, 2019, 11:50:50 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/standard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/checkoutStyle.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
        <title>Teaffee Shop</title>
    </head>
    <body>
    <sec:authentication var="user" property="principal"/>
    <jsp:include page="include/header.jsp"/>
    <main>
        <div class="title main__element--background">
            <h1>ĐƠN HÀNG</h1>
        </div>
        <div class="container-info">

            <div class="list-product main__element--background">
                <table>
                    <thead>
                        <tr>
                            <th colspan="7">Ngày đặt hàng:
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                            </th>
                        </tr>
                        <tr>
                            <th>Tên</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Giá</th>
                            <th>Size</th>
                            <th>Topping</th>
                        </tr>
                    </thead>
                    <tbody style="text-align: center;">
                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                            <tr>
                                <td>${orderDetail.product.name}</td>
                                <td>
                                    <fmt:formatNumber type="number" pattern="###,###" value="${orderDetail.unitPrice}"/>đ
                                </td>
                                <td>${orderDetail.quantity}</td>
                                <td>
                                    <fmt:formatNumber type="number" pattern="###,###" value="${orderDetail.price}"/>đ
                                </td>
                                <td>${orderDetail.size}</td>
                                <td class="toppings">
                                    <c:forTokens var="topping" items="${orderDetail.topping}" delims=",">
                                        <p>-<c:out value="${topping}"/>-</p>
                                    </c:forTokens>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="8">
                                <h2>Tổng: 
                                    <fmt:formatNumber type="number" pattern="###,###" value=" ${order.totalPrice}"/>đ
                                </h2>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="personal-info main__element--background" style="font-size: 1.1em;">
                <form>
                    <table>
                        <tr>
                            <td>
                                <label for="name">Họ và tên:</label>
                            </td>
                            <td>
                                ${customer.name}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="name">Email:</label>
                            </td>
                            <td>
                                ${customer.email}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="name">SĐT:</label>
                            </td>
                            <td>
                                ${customer.phone}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="name">Địa chỉ:</label>
                            </td>
                            <td>
                                ${customer.address}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="gender">Giới tính:</label>
                            </td>
                            <td>
                                ${customer.gender}
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </main>
    <jsp:include page="include/footer.jsp"/>
    <jsp:include page="include/script/standardScript.jsp"/>
</body>
</html>
