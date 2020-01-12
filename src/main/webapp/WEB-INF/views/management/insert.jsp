<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/management/insert.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/management/insert.js"></script>
	
<section class="width1200">
	<c:if test="${management eq 'equipment'}">
		<c:set var="title" value="장비"/>
	</c:if>
	<c:if test="${management eq 'department'}">
		<c:set var="title" value="부서"/>
	</c:if>
	
	<h1>${title} 등록</h1>
	<form id="insertManagementForm" method="post" action="/management/insert">
		<c:if test="${management eq 'equipment'}">
			<label>장비명</label>
			<input type="hidden" name="management" value="${management}">
		</c:if>
		<c:if test="${management eq 'department'}">
			<label>부서명</label>
			<input type="hidden" name="management" value="${management}">
		</c:if>
		<input type="text" name="name">
		<input type="submit" value="등록">
		<input type="button" value="취소" id="listManagement">
	</form>
	<!-- <button id="listManagement">목록</button> -->
</section>
</body>
</html>