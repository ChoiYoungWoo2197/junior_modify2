<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/management/modify.js"></script>

<!-- <script>
	$(function() {
		$("#listManagement").click(function() {
			location.href = "list?management="+$("input[name='management']").val();
		})
		
		/* $("#cancelUpdate").click(function() {
			var managementId = Number($("input[name='departmentId']").val());
			location.href = "read?management="+$("input[name='management']").val()+"&managementId="+managementId;
		}) */
		
		$("#updateEquipmentForm").submit(function() {
			var result = confirm("수정하시겠습니까?");
			
			if(result == false) {
				return false;
			}
		})
	})
</script> -->
	
	<section class="width1200">
		<form id="updateEquipmentForm" method="post" action="/management/modify">
			<input type="hidden" name="management" value="${management}">
			<c:if test="${management eq 'equipment'}">
				<label>장비명</label>
				<input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
				<input type="text" name="name" value="${equipment.name}">
				<input type="submit" value="수정">
			</c:if>
			<c:if test="${management eq 'department'}">
				<label>부서명</label>
				<input type="hidden" name="departmentId" value="${department.departmentId}">
				<input type="text" name="name" value="${department.name}">
				<input type="submit" value="수정">
				<!-- <input type="button" value="취소" id="cancelUpdate"> -->
			</c:if>
		</form>
		<button id="listManagement">목록</button>
	</section>
</body>
</html>