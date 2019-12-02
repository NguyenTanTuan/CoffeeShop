<%-- 
    Document   : login
    Created on : Oct 7, 2019, 11:42:27 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="images/favicon.ico">
        <link rel="stylesheet" type="text/css" href="resources/css/loginStyle.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>
        <meta charset="utf-8">
    </head>
</head>
<body>
    <div id="form">
        <form action="<c:url value="j_spring_security_check"/>" method="post" id="container">
            <h1>Sign in</h1>
            <div class="group">
                <input type="text" name="username" required id="username">
                <label for="username">Tên đăng nhập</label>
            </div>
            <div class="group">
                <input type="password" name="password" required id="password">
                <label for="password">Mật khẩu</label>				
            </div>
            <c:if test="${messageError != null || !empty messageError}">
                <div class="group">
                    <p class="messageError">${messageError}</p>
                </div>
                <div class="group" style="margin-bottom: 5px;">
                    <a href="<c:url value="/xac-thuc-email-da-dang-ky"/>" style="text-decoration: underline; margin-left: 5px;">Quên mật khẩu(tên đăng nhập)</a>
                </div>
            </c:if>

            <div class="button">
                <input type="submit" name="submit" value="Đăng nhập">
            </div>
            <div class="more-info">
                <h4>Nếu chưa có tài khoản vui lòng <a href='<c:url value="/dang-ky"/>'>Đăng ký</a>.
                    Trở về <a href="<c:url value="/home"/>">trang chủ</a></h4>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </div>
</body>
</body>
</html>
