<%-- 
    Document   : home
    Created on : Oct 30, 2019, 3:31:45 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/3.4.1/css/bootstrap.min.css"/>"/>
        <link href="//cdn.datatables.net/1.10.20/css/dataTables.bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="<c:url value="/resources/css/sellerTabStyle.css"/>"/>
        <title>Seller Page</title>
        <style>
            input[type="checkbox"]{
                transform: scale(1.5);
            }
            .container{
                width: 100%;
            }
            .d-flex{
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 5px 0;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../include/sellerHeader.jsp"/>

            <div class="tab-content clearfix">
                <div class="tab-pane active  table-responsive" id="1a">
                    <h3 class="text-center">
                        <strong>DANH SÁCH SẢN PHẨM</strong>
                    </h3>
                    <table id="example" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Loại</th>
                                <th>Trạng thái</th>
                                <th>Khuyến mãi</th>
                                <th>Thông tin</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>

                                    <td>
                                        ${product.name}
                                    </td>
                                    <td>
                                        <fmt:formatNumber type="number" pattern="###,###" 
                                                          value="${product.price + product.sizes.iterator().next().addition}"/>đ
                                    </td>
                                    <td>
                                        ${product.category.name}
                                    </td>
                                    <td>
                                        <c:if test="${product.status}">
                                            <span>Còn hàng</span>
                                        </c:if>
                                        <c:if test="${!product.status}">
                                            <span style="color:red">Hết hàng</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:set var="totalDiscount" value="0"/>
                                        <c:forEach var="promotion" items="${product.promotions}">
                                            <c:set var="totalDiscount" value="${totalDiscount + promotion.discount}"/>
                                        </c:forEach>
                                        <c:if test="${totalDiscount != 0}">
                                            ${Math.round(totalDiscount*100)}%
                                        </c:if>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/seller/them-vao-gio-hang" method="POST" >
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <div class="d-flex">
                                                <label for="">Size:</label>
                                                <select name="sizeId">
                                                    <c:set var="isFirstSize" value="${true}"/>
                                                    <c:forEach var="size" items="${product.sizes}">
                                                        <c:if test="${isFirstSize}">
                                                            <option value="${size.id}" selected>${size.size}</option>
                                                        </c:if>
                                                        <c:if test="${!isFirstSize}">
                                                            <option value="${size.id}">${size.size}</option>
                                                        </c:if>
                                                        <c:set var="isFirstSize" value="${false}"/>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="d-flex">
                                                <label for="">Số lượng:</label>
                                                <input type="number" name="quantity" style="width: 100px" value="1" min="1">
                                            </div>
                                            <div class="d-flex">
                                                <label for="">Topping:</label>
                                                <select name="toppingIds" id="" multiple>
                                                    <c:forEach var="topping" items="${toppings}">
                                                        <option value="${topping.id}">
                                                            ${topping.name}
                                                            (+<fmt:formatNumber type="number" pattern="###,###" value="${topping.price}"/>đ)
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="d-flex">    
                                                <c:if test="${product.status}">
                                                    <button
                                                        class="btn btn-success">Đặt</button>
                                                </c:if>
                                                <c:if test="${!product.status}">
                                                    <p  
                                                        class="btn btn-danger">Đặt</p>
                                                </c:if>
                                            </div>    
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script src="//cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
    </body>
</html>
