<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/management/insert.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/management/modify.js"></script>
	
<section class="width1200">
	<c:if test="${management eq 'equipment'}">
		<c:set var="title" value="장비"/>
	</c:if>
	<c:if test="${management eq 'department'}">
		<c:set var="title" value="부서"/>
	</c:if>
	
	<h1>${title} 수정</h1>
	<form id="updateManagementForm" method="post" action="/management/modify">
		<input type="hidden" name="management" value="${management}">
		<c:if test="${management eq 'equipment'}">
			<label>장비명</label>
			<input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
			<input type="text" name="name" value="${equipment.name}">
		</c:if>
		<c:if test="${management eq 'department'}">
			<label>부서명</label>
			<input type="hidden" name="departmentId" value="${department.departmentId}">
			<input type="text" name="name" value="${department.name}">
		</c:if>
		<input type="submit" value="수정">
		<input type="button" value="취소" id="listManagement">
	</form>
	<!-- <button id="listManagement">목록</button> -->
</section>
</body>
</html>