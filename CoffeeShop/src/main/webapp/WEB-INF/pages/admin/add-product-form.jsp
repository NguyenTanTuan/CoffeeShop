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
                <div id="breadcrumb"> <a href = "<c:url value = "/admin/home/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href = "<c:url value = "/admin/product/product"/>" class="tip-bottom">Product</a> <a href="#" class="current"> Add Product</a> </div>
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
                                <mvc:form action="${pageContext.request.contextPath}/admin/product/add-product" method="post" class="form-horizontal" modelAttribute="product" enctype="multipart/form-data">
                                    <c:if test="${action eq 'product/edit-product'}">
                                        <input type="hidden" name="id" value="${product.id}"  />
                                    </c:if>

                                    <div class="control-group">
                                        <label class="control-label" >Product Name :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="name" placeholder="First name" value="${product.name}"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Price :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" name="price" placeholder="Price" value="${product.price}"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Category :</label>
                                        <div class="controls">
                                            <select name="category.id" class="form-control">
                                                <c:forEach var="c" items="${categories}">             
                                                    <c:if test="${c.id == product.category.id}">
                                                        <option value="${c.id}" selected>${c.name}</option>
                                                    </c:if>
                                                    <c:if test="${c.id != product.category.id}">
                                                        <option value="${c.id}">${c.name}</option>
                                                    </c:if>                     
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Status :</label>
                                        <div class="controls">
                                            <label>True
                                                <input type="radio" name="status" value="true" checked="checked"/>
                                            </label> 
                                            <label>False
                                                <input type="radio" name="status" value="false" />
                                            </label></div>
                                    </div>    
                                    <div class="control-group">
                                        <label class="control-label">Size :</label>
                                        <div class="controls">
                                            <c:forEach var="s" items="${sizes}">
                                                <c:set var="check" value="${false}"/>
                                                <c:forEach var="size" items="${product.sizes}">
                                                    <c:if test="${s.id == size.id}">
                                                        <c:set var="check" value="${true}"/>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${check}">
                                                    <label>
                                                        <input type="checkbox" name="sizeTemp" value="${s.id}" checked/>
                                                        ${s.size}
                                                    </label>
                                                </c:if>
                                                <c:if test="${!check}">
                                                    <label>
                                                        <input type="checkbox" name="sizeTemp" value="${s.id}" />
                                                        ${s.size}
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" >Description :</label>
                                        <div class="controls">
                                            <textarea class="span11" name="description" placeholder="Description" style="height: 100px">${product.description}</textarea>
                                        </div>
                                    </div>

                                    <c:if test="${action == 'product/edit-product'}">
                                        <c:if test="${product.images.size() != 0}"> 
                                            <div class="control-group">

                                                <div>
                                                    <label class="control-label">Image :</label>
                                                </div>

                                                <c:forEach var="p" items="${product.images}">
                                                    <div class="controls">
                                                        <img src="${pageContext.request.contextPath}/${p.path}" alt="${product.name}" height="100px" width="100px"/>
                                                        <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                                    </div>
                                                </c:forEach>

                                                <div class="control-group">
                                                    <div class="span5"></div>
                                                    <!--                                                    <a class="btn btn-xs" id="change-image" >Change Image</a>-->
                                                    <div>
                                                        <a class="btn-danger btn-xs" href = '<c:url value="/admin/product/delete-image/${product.id}"/>'>Delete Product</a>
                                                    </div>
                                                </div>
                                                <div class="text"></div>
                                            </c:if>
                                            <c:if test="${product.images.size() == 0}"> 
                                                <div class="control-group">
                                                    <label class="control-label">Image :</label>
                                                    <div class="controls">
                                                        <input type="file" name="file" class="form-control"/>
                                                    </div>
                                                    <label class="control-label">Image Small:</label>
                                                    <div class="controls">
                                                        <input type="file" name="file" class="form-control"/>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>

                                    </c:if>
                                    <c:if test="${action != 'product/edit-product'}">                                        
                                        <div class="control-group">
                                            <label class="control-label">Image :</label>
                                            <div class="controls">
                                                <input type="file" name="file" class="form-control"/>
                                            </div>
                                            <label class="control-label">Image Small:</label>
                                            <div class="controls">
                                                <input type="file" name="file" class="form-control"/>
                                            </div>
                                        </div>
                                    </c:if>   
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
