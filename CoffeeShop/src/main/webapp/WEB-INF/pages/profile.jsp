<%-- 
    Document   : profile
    Created on : Oct 26, 2019, 8:23:59 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/standard.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/profileStyle.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/landingPage/favicon.png">
<title>Profile</title>
</head>
<body>
	<sec:authentication var="user" property="principal" />
	<jsp:include page="include/header.jsp" />
	<main>
	<div class="container">
		<h1>THÔNG TIN CÁ NHÂN</h1>
		<mvc:form
			action="${pageContext.request.contextPath}/user/cap-nhat-thong-tin-ca-nhan"
			method="POST" modelAttribute="account">
			<table>
				<tr>
					<td class="title">Họ và tên:</td>
					<td class="input-box"><input type="text" name="name"
						value="${user.name}"></td>
				</tr>
				<tr>
					<td class="title">Email:</td>
					<td class="input-box"><input type="text" name="email"
						value="${user.email}"></td>
					<c:if test="${user.status == false}">
						<td><a
							href="<c:url value="/xac-thuc-email?email=${user.email}"/>"
							style="word-wrap: none;">Xác thực</a></td>
					</c:if>
				</tr>
				<tr>
					<td class="title">SĐT:</td>
					<td class="input-box"><input type="tel" name="phone"
						value="${user.phone}"></td>
				</tr>
				<tr>
					<td class="title">Giới tính:</td>
					<td class="input-box"><select name="gender" id="">
							<option value="MALE"
								<c:if test="${user.gender == 'MALE'}">selected</c:if>>Nam</option>
							<option value="FEMALE"
								<c:if test="${user.gender == 'FEMALE'}">selected</c:if>>Nữ</option>
					</select></td>
				</tr>
				<tr>
					<td class="title">Địa chỉ</td>
					<td class="input-box"><input type="text" name="address"
						value="${user.address}"></td>
				</tr>
				<tr>
					<td class="title">Tên đăng nhập</td>
					<td class="input-box"><input style="cursor: not-allowed"
						type="text" value="${user.username}" disabled></td>
				</tr>
				<tr>
					<td class="title">Thay đổi mật khẩu</td>
					<td class="input-box">
						<p id="change-password">Thay đổi</p>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><span style="color: red;">${messageError}</span> <span
						style="color: #5bd75b;">${messageSuccess}</span></td>
				</tr>
				<tr>
					<td></td>
					<td class="input-box"><input type="submit" value="CẬP NHẬT">
					</td>
				</tr>
			</table>
		</mvc:form>
	</div>
	</main>
	<script type="text/javascript">
		let btnChangePassword = document.getElementById('change-password');
		btnChangePassword.onclick = function() {

			tr = document.createElement('TR');
			tr.innerHTML = '<td class="input-box"><input type="password" name="reNewPassword" placeholder="Nhập lại mật khẩu mới"></td>';
			this.parentNode.parentNode.insertAdjacentElement('afterend', tr);

			tr = document.createElement('TR');
			tr.innerHTML = '<td class="input-box"><input type="password" name="newPassword" placeholder="Nhập mật khẩu mới"></td>';
			this.parentNode.parentNode.insertAdjacentElement('afterend', tr);

			tr = document.createElement('TR');
			tr.innerHTML = '<td class="input-box"><input type="password" name="oldPassword" placeholder="Nhập mật khẩu cũ"></td>';
			this.parentNode.parentNode.insertAdjacentElement('afterend', tr);

			this.parentNode.parentNode.innerHTML = '<td rowspan="4" style="vertical-align:top; padding-top:10px;" class="title">Thay đổi mật khẩu</td>'
		}
	</script>
	<jsp:include page="include/footer.jsp" />
	<jsp:include page="include/script/standardScript.jsp" />
</body>
</html>
