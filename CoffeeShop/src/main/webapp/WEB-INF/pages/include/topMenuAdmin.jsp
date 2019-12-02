<%-- 
    Document   : topMenuAdmin
    Created on : Oct 11, 2019, 4:17:15 PM
    Author     : PC
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">
        <li  class="dropdown" id="profile-messages" ><a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle"><i class="icon icon-user"></i>  <span class="text">Welcome User</span><b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="<c:url value="/user/thong-tin-ca-nhan"/>"><i class="icon-user"></i> My Profile</a></li>                        
                <li><a href="<c:url value="/dang-xuat"/>"><i class="icon-key"></i> Log Out</a></li>
            </ul>
        </li>
        <li class=""><a title="" href="<c:url value="/home"/>"><i class="icon icon-home"></i> <span class="text">Home</span></a></li>
            <sec:authorize access="hasRole('ROLE_SELLER')">
            <li class=""><a title="" href="<c:url value="/seller/home"/>"><i class="icon icon-home"></i> <span class="text">Sell</span></a></li>
            </sec:authorize>
    </ul>
</div>
<!--close-top-Header-menu-->
<!--start-top-serch-->
