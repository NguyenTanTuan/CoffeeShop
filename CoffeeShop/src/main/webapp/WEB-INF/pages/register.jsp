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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/loginStyle.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="utf-8">
    </head>
    <body>
        <style>
            .group input{
                margin : 5%  0;
            }
            .group input:focus ~ label, .group input:valid ~ label{
                top: -10%;
            }
            .group-select{
                height: 40px;
                display: flex;
                flex-direction: row;
                justify-content: space-around;
                align-items: center;
            }
            .group-select__item{
                color: #6495ED;
            }
            .group-select__item > input{
                transform: scale(1.5);
            }
            .group-select__item > input:focus ~  label{
                color: #28b65f;
            }
        </style>
        <div id="form">
            <mvc:form action="${pageContext.request.contextPath}/dang-ky" method="POST" modelAttribute="account" 
                      id="container">
                <h1>ĐĂNG KÝ</h1>
                <div class="group">
                    <input type="text" name="name" value="${account.name}" required id="name">
                    <label for="name">Họ và tên</label>
                </div>
                <div class="group">
                    <input type="text" name="email" value="${account.email}" required id="email">
                    <label for="email">Email</label>
                </div>
                <div class="group">
                    <input type="number" name="phone" value="${account.phone}" required id="phoneNumber" min="0">
                    <label for="phoneNumber">Số điện thoại</label>
                </div>
                <div class="group-select">
                    <div class="group-select__item">
                        <input type="radio" name="gender" value="MALE" id="MALE"
                               <c:if test="${account.gender == 'MALE'}">checked</c:if>
                               >
                        <label for="MALE">Nam</label>
                    </div>
                    <div class="group-select__item">
                        <input type="radio" name="gender" value="FEMALE" id="FEMALE"
                               <c:if test="${account.gender == 'FEMALE'}">checked</c:if>
                               >
                        <label for="FEMALE">Nữ</label>
                    </div>
                </div>
                <div class="group">
                    <input type="text" name="address" value="${account.address}" required id="address">
                    <label for="address">Địa chỉ:</label>
                </div>
                <div class="group">
                    <input type="text" name="username" value="${account.username}" required id="username">
                    <label for="username">Tên đăng nhập</label>
                </div>
                <div class="group">
                    <input type="password" name="password" required id="password">
                    <label for="password">Mật khẩu</label>
                </div>
                <div class="group">
                    <input type="password" name="rePassword" required id="re-password">
                    <label for="re-password">Nhập lại mật khẩu</label>
                </div>
                <div class="group">
                    <p class= "messageError">${messageError}</p>
                </div>
                <div class="button">
                    <input type="submit" name="submit" value="Đăng ký">
                </div>
                <div class="more-info">
                    <h4>Nếu đã có tài khoản vui lòng <a href="<c:url value="/dang-nhap"/>">Đăng nhập</a>.
                        Trở về <a href="<c:url value="/home"/>">trang chủ</a></h4>
                </div>
            </mvc:form>
        </div>
    </body>
</html>
