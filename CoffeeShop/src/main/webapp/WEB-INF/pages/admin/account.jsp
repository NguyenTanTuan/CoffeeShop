<!DOCTYPE html>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                <div id="breadcrumb"> <a href = "<c:url value = "/admin/home/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Account</a> </div>
                <h1>Account</h1>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="row-fluid">
                    <div class="span12">                        
                        <div class="widget-box">
                            <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                                <h5>Account table</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <table class="table table-bordered data-table">
                                    <thead>
                                        <tr>
                                            <th>Customer Name</th>                                            
                                            <th>Phone</th>
                                            <th>Address</th>                                            
                                            <th>Email</th>
                                            <th>Gender</th>
                                            <th>User Name </th>                                            
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="a" items="${account}">
                                            <c:set var="i" value="1"/>
                                            <tr class="gradeU">
                                                <td>${a.name}</td>
                                                <td>${a.phone}</td>
                                                <td>${a.address}</td>
                                                <td>${a.email}</td>  
                                                <td>${a.gender}</td> 
                                                <td>${a.username}</td>                                                
                                                <td>
                                                    <c:forEach var="r" items="${a.roles}">
                                                        <c:if test="${i == a.roles.size()}">
                                                            <span>${r.role}</span>
                                                        </c:if>
                                                        <c:if test="${i != a.roles.size()}">
                                                            <span>${r.role},</span>
                                                        </c:if>
                                                        <c:set var="i" value="${i+1}"/>
                                                    </c:forEach>
                                                </td> 
                                                <td>${a.status}</td>
                                                <td>
                                                    <c:set var="test" value="${true}"/>
                                                    <c:set var="test1" value="${false}"/>
                                                    <c:forEach var="r" items="${a.roles}">
                                                        <c:if test="${r.role != 'ROLE_ADMIN'}">
                                                            <c:set var="test" value="${false}"/>                                                            
                                                        </c:if>
                                                        <c:if test="${r.role == 'ROLE_SELLER' or r.role == 'ROLE_MANAGER'}">
                                                            <c:set var="test1" value="${true}"/>                                                            
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${test == false}">
                                                        <button class="btn btn-primary btn-sm" onclick="location.href = '<c:url value="/admin/account/promote-account/${a.id}"/>'">Promote</button>
                                                        <c:if test="${a.status != true}">  
                                                            <button class="btn btn-success btn-sm"
                                                                    onclick="location.href = '<c:url value="/admin/account/enable-account/${a.id}"/>'">Enable</button>
                                                        </c:if>
                                                        <c:if test="${!test1}">
                                                            <c:if test="${a.status == true}"> 
                                                                <button class="btn btn-danger btn-sm"
                                                                        onclick="location.href = '<c:url value="/admin/account/disable-account/${a.id}"/>'">Disable</button>
                                                            </c:if>
                                                        </c:if>
                                                    </c:if> 
                                                </td>
                                            </tr>
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
