<%-- 
    Document   : register
    Created on : Oct 7, 2019, 11:54:17 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign in</title>
        <link rel="shortcut icon" href="images/favicon.ico">
        <link rel="stylesheet" type="text/css" href="resources/css/loginStyle.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="utf-8">
    </head>
    <body>
        <style>
            .group input{
                margin : 5% 0;
            }
            .group input:focus ~ label, .group input:valid ~ label{
                top: -10%;
            }
            #sendCodeAgain{
                display: block;
                text-align: center;
                margin-bottom: 10px;
                text-decoration: underline;
            }
        </style>
        <div id="form">
            <mvc:form action="${pageContext.request.contextPath}/reset-mat-khau" method="POST" 
                      id="container">
                <h1>KHÔI PHỤC TÀI KHOẢN</h1>
                <div class="group">
                    <p>Reset lại mật khẩu</p>
                </div>
                <div>
                    <div class="group">
                        <p>Tên đăng nhập: ${username}</p>
                    </div>
                </div>
                <input type="hidden" name="username" name="username" value="${username}">
                <input type="hidden" name="code" value="${code}">
                <div class="group">
                    <input type="password" name="password" required id="password">
                    <label for="password">Mật khẩu</label>
                </div>
                <div class="group">
                    <input type="password" name="rePassword" required id="rePassword">
                    <label for="rePassword">Nhập lại mật khẩu</label>
                </div>
                <div class="group">
                    <p class= "messageError">${messageError}</p>
                </div>
                <div class="button">
                    <input type="submit" name="submit" value="XÁC NHẬN">
                </div>
            </mvc:form>
        </div>
    </body>
</html>
