<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                <div id="breadcrumb"> <a href = "<c:url value = "/admin/home/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Orders</a> </div>
                <h1>Orders</h1>
            </div>
            <div class="container-fluid">
                <hr>  
                <mvc:form action="${pageContext.request.contextPath}/admin/order/searchOrder" method="GET"  class="form-horizontal">
                    <div class="span5">
                        <div class="span6">
                            <h5>Date</h5>
                        </div>
                        <div class="span6">                        
                            <input type="date" name="startDate" id="startDate"/> 
                            <span>to</span> 
                            <input type="date" name="endDate" id="endDate"/>
                        </div>
                    </div>
                    <div class="span5">
                        <div class="span6">
                            <h5>Status</h5>
                        </div>
                        <div class="span6">
                            <c:forEach var="os" items="${os}">  
                                <div class="span2">
                                    <input type="checkbox" name="osTemp" value="${os.toString()}"/><span>${os.toString()}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div  class="span12">
                        <div class="span0"></div>    
                        <button type="submit" class="btn btn-success">Search Order Date</button>                         
                    </div>
                </mvc:form>
                <div class="span12">
                    <h5>${messageError}</h5>
                </div>
                <div class="row-fluid">
                    <div class="span12">
                        <div class="widget-box">

                            <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                                <h5> Order</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <table class="table table-bordered data-table">
                                    <thead>
                                        <tr>    
                                            <th>Customer name</th>
                                            <th>Order Date</th>
                                            <th>Shipping Date</th>
                                            <th>Total Price</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="check" value="0"/>                                       
                                        <c:forEach var="o" items="${order}">
                                            <tr class="gradeU">
                                                <td>${o.customer.name}</td>
                                                <td>${o.orderDate}</td>
                                                <td>${o.shippingDate}</td>
                                                <td><fmt:formatNumber type = "number" 
                                                                  maxFractionDigits = "3" value = "${o.totalPrice}"/> VNĐ</td>
                                                <td>${o.status}</td>
                                                <td>
                                                    <button type="button" class="btn btn-primary btn-sm"
                                                            onclick="location.href = '<c:url value="/admin/order/orderDetail/${o.id}"/>'">Order Detail</button>
                                                    <c:if test="${o.status != 'DONE' && o.status != 'CANCELED' }">
                                                        <button type="button" class="btn btn-primary btn-sm"
                                                                onclick="location.href = '<c:url value="/admin/order/change-order/${o.id}"/>'">Change</button>
                                                        <button type="button" class="btn btn-danger btn-sm"
                                                                onclick="location.href = '<c:url value="/admin/order/cancel-order/${o.id}"/>'">Cancel</button>

                                                    </c:if>
                                                </td>                                           
                                                <c:if test="${o.status == 'DONE'}">
                                                    <c:set var="check" value="1"/>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <c:if test="${check == 1}">
                            <div class="span9" >
                                <div><h4>Doanh Thu: ${total}</h4></div> <hr/>                 
                            </div>  
                        </c:if>
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
