<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <title>Matrix Admin</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/uniform.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/select2.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/matrix-style.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/matrix-media.css" />
        <link href="${pageContext.request.contextPath}/resources-management/css/font-awesome.css" rel="stylesheet" />

        <link rel="stylesheet" href="<c:url value="/webjars/font-awesome/4.6.2/css/font-awesome.css"/>"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
    </head>
    <body>

        <div id="header">
            <h1><a href="dashboard.html">Matrix Admin</a></h1>
        </div>
        <!--Header-part-->
        <jsp:include page="../include/topMenuAdmin.jsp"/>


        <!--sidebar-menu-->
        <jsp:include page="../include/slidebarMenuAdmin.jsp"/>

        <div id="content">
            <div id="content-header">
                <div id="breadcrumb"> <a href = "<c:url value = "/admin/home/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href = "<c:url value = "/admin/order/order"/>" class="tip-bottom">Orders</a> <a href="#" class="current"> Order Detail</a> </div>
                <h1>Order Detail</h1>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="span9" >
                    <div><h4>Order Number: SHD0${orderDetail.id}</h4></div> <hr/>                 
                </div>                
                <div class="span5"> 
                    <div class="span6" style="font-size: 15px">Order Date: ${orderDetail.orderDate}</div><hr/>    
                    <div class="span6" style="font-size: 15px">Shipping Date:  ${orderDetail.shippingDate}</div><hr><hr/>
                    <div class="span6" style="font-size: 15px">Order Status:  ${orderDetail.status}</div><hr><hr/>
                </div>
                <div class="span4">
                    <div class="span12" style="font-size: 15px">Customer Name: ${orderDetail.customer.name}</div><hr/>            
                    <div class="span4" style="font-size: 15px">Customer Address: ${orderDetail.customer.address}</div><hr><hr/>
                    <div class="span4" style="font-size: 15px">Customer Phone: ${orderDetail.customer.phone}</div><hr><hr/>
                    <div class="span12" style="font-size: 15px">Customer Email: ${orderDetail.customer.email}</div><hr><hr/>
                </div>
                <div class="row-fluid">
                    <div class="span12">
                        <div class="widget-box">

                            <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                                <h5>Order Detail</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr> 
                                            <th>Product</th>
                                            <th>Quantity</th>
                                            <th>Topping</th>
                                            <th>Price</th>
                                            <th>Unit Price</th>                                          

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="od" items="${orderDetail.orderDetails}">
                                            <tr>
                                                <td>${od.product.name}</td>
                                                <td>${od.quantity}</td>
                                                <td>${od.topping}</td>
                                                <td>${od.price}</td>
                                                <td>${od.unitPrice}</td>                                                
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <th colspan="4" >Total Price:</th>
                                            <th>${orderDetail.totalPrice}</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Footer-part-->
        <jsp:include page="../include/footerAdmin.jsp"/>
        <!--end-Footer-part-->
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.ui.custom.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/bootstrap.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.uniform.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/select2.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.dataTables.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.tables.js"></script>
    </body>
</html>
