<%-- 
    Document   : profile
    Created on : Oct 26, 2019, 8:23:59 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/standard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profileStyle.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
        <title>Profile</title>
    </head>
    <body>
        <sec:authentication var="user" property="principal"/>
        <jsp:include page="include/header.jsp"/>
        <main style="text-align: center">
            <h1>BẠN ĐÃ ĐẶT HÀNG THÀNH CÔNG</h1>
            <h2>Kiểm tra hóa đơn trong email của bạn</h2>
        </main>
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/script/standardScript.jsp"/>
    </body>
</html>
