<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
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
                <div id="breadcrumb"> <a href = "<c:url value = "/admin/home/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href = "<c:url value = "/admin/promotion/promotion"/>" class="tip-bottom">Promotion</a> <a href="#" class="current">List Product</a> </div>
                <h1>Promotion</h1>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="row-fluid">
                    <div class="span12">                   
                            <div class="widget-box">

                                <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                                    <h5>Promotion: ${promotion.description}(-${promotion.discount*100}%)</h5>
                                </div>

                                <table class="table table-bordered data-table table-striped with-check">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Name</th>
                                            <th>Category</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="stt" value="1"/>
                                        <c:forEach var="p" items="${products}">
                                            <tr class="gradeU">    
                                                <td>${stt}</td>
                                                <td>${p.name}</td>
                                                <td>${p.category.name}</td>
                                                <td>${p.price} VNĐ</td>
                                            </tr>
                                            <c:set var="stt" value="${stt+1}" />
                                        </c:forEach>
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
