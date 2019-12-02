<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources-management/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources-management/css/bootstrap-responsive.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources-management/css/uniform.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources-management/css/select2.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources-management/css/matrix-style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources-management/css/matrix-media.css" />
<link
	href="${pageContext.request.contextPath}/resources-management/css/font-awesome.css"
	rel="stylesheet" />

<link rel="stylesheet"
	href="<c:url value="/webjars/font-awesome/4.6.2/css/font-awesome.css"/>" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>
</head>
<body>

	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>
	<!--Header-part-->
	<jsp:include page="../include/topMenuAdmin.jsp" />


	<!--sidebar-menu-->
	<jsp:include page="../include/slidebarMenuAdmin.jsp" />

	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<c:url value = "/admin/home/home"/>" title="Go to Home"
					class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#"
					class="current">Promotion</a>
			</div>
			<h1>Promotion</h1>
		</div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div>
						<button class="btn btn-primary"
							onclick="location.href = '<c:url value="/admin/promotion/add-promotion"/>'">Add
							Promotion</button>
					</div>
					<div class="widget-box">

						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Category table</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Description</th>
										<th>Discount</th>
										<th>Image</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="pr" items="${promotion}">
										<tr class="gradeU">
											<td>${pr.description}</td>
											<td>${pr.discount}</td>
											<td>
												<div class="col-sm-3 image">
													<img src="${pageContext.request.contextPath}/${pr.image}"
														height="50px" width="50px" />
												</div>
											</td>
											<td>${pr.startDate}</td>
											<td>${pr.endDate}</td>
											<td>${pr.status}</td>
											<td>
												<div>
													<sec:authorize access="!hasRole('ROLE_SELLER')">
														<button type="button" class="btn btn-primary btn-sm"
															onclick="location.href = '<c:url value="/admin/promotion/edit-promotion/${pr.id}"/>'">Edit</button>
														<c:if test="${pr.status == false}">
															<button type="button" class="btn btn-success btn-sm"
																onclick="location.href = '<c:url value="/admin/promotion/enable-promotion/${pr.id}"/>'">Enable</button>
														</c:if>
														<c:if test="${pr.status == true}">
															<button type="button" class="btn btn-danger btn-sm"
																onclick="location.href = '<c:url value="/admin/promotion/disable-promotion/${pr.id}"/>'">Disable</button>
														</c:if>
														<button type="button" class="btn btn-success btn-sm"
															onclick="location.href = '<c:url value="/admin/promotion/promotionForProduct/${pr.id}"/>'">Add
															Product</button>
													</sec:authorize>
													<button type="button" class="btn btn-primary btn-sm"
														onclick="location.href = '<c:url value="/admin/promotion/detail-promotion/${pr.id}"/>'">List
														Product</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--Footer-part-->
	<jsp:include page="../include/footerAdmin.jsp" />
	<!--end-Footer-part-->
	<script
		src="${pageContext.request.contextPath}/resources-management/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/jquery.ui.custom.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/jquery.uniform.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/select2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/matrix.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources-management/js/matrix.tables.js"></script>
</body>
</html>
