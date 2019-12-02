<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/fullcalendar.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/matrix-style.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/matrix-media.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/font-awesome.css"/>
        <link rel="stylesheet" href="<c:url value="/webjars/font-awesome/4.6.2/css/font-awesome.css"/>"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources-management/css/jquery.gritter.css" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
    </head>
    <body>

        <!--Header-part-->
        <div id="header">
            <h1><a href="dashboard.html">Matrix Admin</a></h1>
        </div>

        <!--top-Header-menu-->
        <jsp:include page="../include/topMenuAdmin.jsp"/>


        <!--sidebar-menu-->
        <jsp:include page="../include/slidebarMenuAdmin.jsp"/>

        <div id="content">
            <div id="content-header">
                <div id="breadcrumb"> <a href = "<c:url value = "/admin/home/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href = "<c:url value = "/admin/account/account"/>" class="tip-bottom">Account</a> <a href="#" class="current">Promote</a> </div>
                <h1>Products</h1>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="row-fluid "> 
                    <div class="span3"></div>
                    <div class="span6 align-self-center">
                        <div class="widget-box">
                            <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                                <h5>Personal-info</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <mvc:form action="${pageContext.request.contextPath}/admin/${action}" method="post" class="form-horizontal" modelAttribute="account">
                                    <c:if test="${action eq 'account/update-promote-account'}">
                                        <input type="hidden" name="id" value="${account.id}"  />
                                    </c:if>

                                    <div class="control-group">
                                        <label class="control-label" >Customer Name :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="name"  value="${account.name}" disabled=""/>
                                        </div>
                                            <input type="hidden" class="span11" name="name"  value="${account.name}" />
                                        
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" >Phone :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="phone"  value="${account.phone}" disabled=""/>
                                        </div>
                                            <input type="hidden" class="span11" name="phone"  value="${account.phone}"/>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" >Address :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="address"  value="${account.address}" disabled=""/>
                                        </div>
                                            <input type="hidden" class="span11" name="address"  value="${account.address}"/>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" >Email :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="email"  value="${account.email}" disabled=""/>
                                        </div>
                                            <input type="hidden" class="span11" name="email"  value="${account.email}"/>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" >User Name :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="username"  value="${account.username}" disabled=""/>
                                        </div>
                                        
                                            <input type="hidden" class="span11" name="username"  value="${account.username}"/>
                                            <input type="hidden" class="span11" name="password"  value="${account.password}"/>
                                    </div>
                                                                        
                                    <div class="control-group">
                                        <label class="control-label">Status :</label>
                                        <div class="controls">
                                            <label>True
                                                <input type="radio" name="status" value="true" checked="checked"/>
                                            </label> 
                                            <label>False
                                                <input type="radio" name="status" value="false" />
                                            </label>
                                        </div>
                                    </div>    
                                    <div class="control-group">
                                        <label class="control-label">Role :</label>
                                        <div class="controls">
                                            <c:forEach var="r" items="${roles}">
                                                <c:set var="check" value="${false}"/>
                                                <c:forEach var="ar" items="${account.roles}">
                                                    <c:if test="${r.id == ar.id }">
                                                        <c:set var="check" value="${true}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${check && r.role != 'ROLE_ADMIN'}"  >
                                                    <label>
                                                        <input type="checkbox" name="roleTemp" value="${r.id}" checked/>
                                                        ${r.role}
                                                    </label>
                                                </c:if>
                                                <c:if test="${!check && r.role != 'ROLE_ADMIN'}">
                                                    <label>
                                                        <input type="checkbox" name="roleTemp" value="${r.id}" />
                                                        ${r.role}
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label style="text-align: center;"><span>${messageError}</span></label>                                                                             
                                    </div>
                                    <div class="form-actions">                                        
                                        <button type="submit" class="btn btn-success">Save</button>
                                    </div>
                                </mvc:form>
                            </div>
                        </div>

                    </div>

                </div>

            </div></div>

        <jsp:include page="../include/footerAdmin.jsp"/>


        <!--end-Footer-part-->

        <script src="resource/admin/js/excanvas.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.ui.custom.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/bootstrap.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.flot.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.flot.resize.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.peity.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/fullcalendar.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.dashboard.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.gritter.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.interface.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.chat.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.validate.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.form_validation.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.wizard.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.uniform.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/select2.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.popover.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/jquery.dataTables.min.js"></script> 
        <script src="${pageContext.request.contextPath}/resources-management/js/matrix.tables.js"></script> 


    </body>
</html>
