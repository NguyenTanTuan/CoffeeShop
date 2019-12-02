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
            <mvc:form action="${pageContext.request.contextPath}/${action}" method="POST" modelAttribute="account" 
                      id="container">
                <h1>XÁC THỰC EMAIL</h1>
                <div class="group">
                    <p>Mã xác nhận đã được gửi tới email: ${email}</p>
                </div>
                <div class="group">
                    <input type="hidden" name="email" value="${email}">
                    <input type="number" name="code" required id="code">
                    <label for="code">Nhập mã xác nhận</label>
                </div>
                <div class="group">
                    <a id="sendCodeAgain" onclick="sendCode()">Gửi lại mã</a>
                </div>
                <div class="group">
                    <p class= "messageError">${messageError}</p>
                </div>
                <div class="button">
                    <input type="submit" name="submit" value="XÁC NHẬN">
                </div>
                <div class="register">
                    <h4 style="text-align: center">Trở về <a href="<c:url value="/home"/>">trang chủ</a></h4>
                </div>
            </mvc:form>
        </div>
        <script>
            function sendCode() {
                let xhttp = new XMLHttpRequest();
                xhttp.open('GET', '${pageContext.request.contextPath}/gui-code?email=${email}', true);
                xhttp.send();
                xhttp.onreadystatechange = () => {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                    document.getElementById('sendCodeAgain').innerHTML = "Gửi lại mã (đã gửi)";
                   }
                }
            }
        </script>
    </body>
</html>
