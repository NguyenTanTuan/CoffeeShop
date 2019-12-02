<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <!--breadcrumbs-->
            <div id="content-header">
                <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Hello Admin!!!!!</a></div>
            </div>
            <!--End-breadcrumbs-->

            <!--Action boxes-->
            <div class="container-fluid">
                <div class="quick-actions_homepage">
                    <ul class="quick-actions">
                        <li class="bg_lb"> <a href = "<c:url value = "/admin/order/new-order"/>"> <i class="icon-dashboard"></i> <span class="label label-important">${order.size()}</span> New Order </a> </li>
                        <li class="bg_ly"> <a href = "<c:url value = "/admin/order/making-order"/>"> <i class="icon-inbox"></i><span class="label label-success">${order1.size()}</span> Making </a> </li>                        
                        <li class="bg_ls"> <a href = "<c:url value = "/admin/order/shipping-order"/>"> <i class="icon-fullscreen"><span class="label label-success">${order2.size()}</span></i> Shipping</a> </li>
                        <li class="bg_lo"> <a href = "<c:url value = "/admin/order/cancel-order"/>"> <i class="icon-info-sign"><span class="label label-important">${order3.size()}</span></i> Cancel</a> </li>
                        <li class="bg_lg"> <a href = "<c:url value = "/admin/order/done-order"/>"> <i class="icon-signal"><span class="label label-important">${order4.size()}</span></i> Done</a> </li>
                    </ul>
                </div>

                <hr/>

            </div>
        </div>

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

        <script type="text/javascript">
            // This function is called from the pop-up menus to transfer to
            // a different page. Ignore if the value returned is a null string:
            function goPage(newURL) {

                // if url is empty, skip the menu dividers and reset the menu selection to default
                if (newURL != "") {

                    // if url is "-", it is this page -- reset the menu:
                    if (newURL == "-") {
                        resetMenu();
                    }
                    // else, send page to designated URL            
                    else {
                        document.location.href = newURL;
                    }
                }
            }

            // resets the menu selection upon entry to this page:
            function resetMenu() {
                document.gomenu.selector.selectedIndex = 2;
            }
        </script>
    </body>
</html>
