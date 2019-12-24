<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>
	
	
	<section class="width1200">
		<form id="updateEquipmentForm" method="post" action="/management/modify">
			<label>장비명</label>
			<input type="hidden" name="equipmentId" value="${equipment.equipmentId}">
			<input type="text" name="name" value="${equipment.name}">
			<input type="submit" value="수정">
			<input type="reset">
		</form>
	</section>
	
</body>
</html>