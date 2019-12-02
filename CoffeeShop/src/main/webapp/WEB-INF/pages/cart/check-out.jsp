<%-- 
    Document   : check-out
    Created on : Oct 8, 2019, 11:50:50 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="resources/css/standard.css">
        <link rel="stylesheet" href="resources/css/checkoutStyle.css">
        <link rel="shortcut icon" href="images/landingPage/favicon.png">
        <title>Teaffee Shop</title>
    </head>
    <body>
        <c:set var="orderDetails" value="${sessionScope.orderDetails}"/>
        <sec:authentication var="user" property="principal"/>
        <jsp:include page="../include/header.jsp"/>
        <main>
            <c:if test="${!empty sessionScope.orderDetails}">
                <div class="title main__element--background">
                    <h1>ĐƠN HÀNG</h1>
                </div>
                <div class="container-info">

                    <div class="list-product main__element--background">
                        <table>
                            <thead>
                                <tr>
                                    <jsp:useBean id="now" class="java.util.Date"/>
                                    <th colspan="7">Ngày đặt hàng:
                                        <fmt:formatDate value="${now}" pattern="dd/MM/yyyy"/>
                                    </th>
                                </tr>
                                <tr>
                                    <th></th>
                                    <th>Tên</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th>Giá</th>
                                    <th>Size</th>
                                    <th>Topping</th>
                                </tr>
                            </thead>
                            <tbody style="text-align: center;">
                                <c:set var="totalPrice" value="0"/>
                                <c:forEach var="orderDetail" items="${orderDetails}">
                                    <tr>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/${orderDetail.product.images[1].path}" alt="${orderDetail.product.name}">
                                        </td>
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
                                    <c:set var="totalPrice" value="${totalPrice + orderDetail.price}"/>
                                </c:forEach>
                                <tr>
                                    <td colspan="8">
                                        <h2>Tổng: 
                                            <fmt:formatNumber type="number" pattern="###,###" value=" ${totalPrice}"/>đ
                                        </h2>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="personal-info">
                        <mvc:form action="${pageContext.request.contextPath}/dat-hang" method="POST" modelAttribute="customer"
                                  class="main__element--background">
                            <table>
                                <tr>
                                    <td>
                                        <label for="name">Họ và tên:</label>
                                    </td>
                                    <td>
                                        <input type="text" name="name" id="name" 
                                               <sec:authorize access="isAuthenticated()">
                                                   value="${user.name}"
                                               </sec:authorize>
                                               <sec:authorize access="!isAuthenticated()">
                                                   value="${customer.name}"
                                               </sec:authorize>
                                               />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="name">Email:</label>
                                    </td>
                                    <td>
                                        <input type="email" name="email" id="email"  
                                               <sec:authorize access="isAuthenticated()">
                                                   value="${user.email}"
                                               </sec:authorize>
                                               <sec:authorize access="!isAuthenticated()">
                                                   value="${customer.email}"
                                               </sec:authorize>
                                               />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="name">SĐT:</label>
                                    </td>
                                    <td>
                                        <input type="tel" name="phone" id="phone"  
                                               <sec:authorize access="isAuthenticated()">
                                                   value="${user.phone}"
                                               </sec:authorize>
                                               <sec:authorize access="!isAuthenticated()">
                                                   value="${customer.phone}"
                                               </sec:authorize>
                                               />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="name">Địa chỉ:</label>
                                    </td>
                                    <td>
                                        <input type="text" name="address" id="address"  
                                               <sec:authorize access="isAuthenticated()">
                                                   value="${user.address}"
                                               </sec:authorize>
                                               <sec:authorize access="!isAuthenticated()">
                                                   value="${customer.address}"
                                               </sec:authorize>
                                               />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="gender">Giới tính:</label>
                                    </td>
                                    <td>
                                        <select name="gender" id="gender">
                                            <option value="MALE"
                                                    <sec:authorize access="isAuthenticated()">
                                                        <c:if test="${user.gender == 'MALE'}">selected</c:if>
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                        <c:if test="${customer.gender == 'MALE'}">selected</c:if>
                                                    </sec:authorize>
                                                    >Nam</option>
                                            <option value="FEMALE"
                                                    <sec:authorize access="isAuthenticated()">
                                                        <c:if test="${user.gender == 'FEMALE'}">selected</c:if>
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                        <c:if test="${customer.gender == 'FEMALE'}">selected</c:if>
                                                    </sec:authorize>
                                                    >Nữ</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                <input type="hidden" name="totalPrice" value="${totalPrice}">
                                <td colspan="2" style="color: red; text-align: center;">${messageError}</td>
                                </tr>
                                <input type="submit" hidden="true" id="submit">
                            </table>
                        </mvc:form>
                        <div class="action">
                            <div class="action__button main__element--background">
                                <a href="<c:url value="/gio-hang"/>">Trở về</a>
                            </div>
                            <div class="action__button main__element--background">
                                <label for="submit">Xác nhận</label>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.orderDetails}">
                <div class="title main__element--background">
                    <h1>GIỎ HÀNG TRỐNG <br> VUI LÒNG CHỌN SẢN PHẨM</h1>
                </div>
            </c:if>
        </main>
        <jsp:include page="../include/footer.jsp"/>
        <jsp:include page="../include/script/standardScript.jsp"/>
    </body>
</html>
