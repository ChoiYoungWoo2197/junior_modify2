<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<script>
	$(function() {
		$("#listManagement").click(function() {
			location.href = "list?mgt="+$("input[name='mgt']").val();
		})
	})
</script>
	
	<section class="width1200">
		<form id="updateEquipmentForm" method="post" action="/management/modify">
			<input type="hidden" name="mgt" value="${mgt}">
			<c:if test="${mgt eq 'equipment'}">
				<label>장비명</label>
				<input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
				<input type="text" name="name" value="${equipment.name}">
			</c:if>
			<c:if test="${mgt eq 'department'}">
				<label>부서명</label>
				<input type="hidden" name="departmentId" value="${department.departmentId}">
				<input type="text" name="name" value="${department.name}">
			</c:if>
			<input type="submit" value="수정">
			<input type="reset">
		</form>
		<button id="listManagement">목록</button>
	</section>
</body>
</html>