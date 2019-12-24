<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>
	
	
	<!--  accept-charset="UTF-8" -->
	<form id="insertEquipmentForm" method="post" action="/management/insert">
		<label>장비명</label>
		<input type="text" name="name">
		<input type="submit" value="등록">
		<input type="reset">
	</form>
	
</body>
</html>