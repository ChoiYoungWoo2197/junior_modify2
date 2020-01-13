<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/insert.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/management/modify.js"></script>
	
<section class="width1200">
	<c:if test="${management eq 'equipment'}">
		<c:set var="title" value="장비"/>
	</c:if>
	<c:if test="${management eq 'department'}">
		<c:set var="title" value="부서"/>
	</c:if>
	
	<h1>${title} 수정</h1>
	<div class="color_red float_right">* 필수입력</div>
	<div class="clear_both"></div>
	<form id="updateManagementForm" method="post" action="/management/modify">
		<input type="hidden" name="management" value="${management}">
		<table>
			<c:if test="${management eq 'equipment'}">
				<tr>
					<th><label>장비명 <span class="color_red display_inline">*</span></label></th>
					<td>
						<input type="text" name="name" value="${equipment.name}">
						<span class="color_red display_none">장비명을 입력하세요.</span>
					</td>
				</tr>
				<input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
			</c:if>
			<c:if test="${management eq 'department'}">
				<tr>
					<th><label>부서명 <span class="color_red display_inline">*</span></label></th>
					<td>
						<input type="text" name="name" value="${department.name}">
						<span class="color_red display_none">부서명 입력하세요.</span>
					</td>
				</tr>
				<input type="hidden" name="departmentId" value="${department.departmentId}">
			</c:if>
		</table>
		<div class="float_right">
			<input type="submit" value="수정">
			<input type="button" value="취소" id="listManagement">
		</div>
	</form>
	<!-- <button id="listManagement">목록</button> -->
</section>
</body>
</html>