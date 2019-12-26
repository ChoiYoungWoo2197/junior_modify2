<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<script>
	$(function() {
		$("#listManagement").click(function() {
			location.href = "list?mgt="+$("input[name='mgt']").val();
		})
		
		$("#insertManagementForm").submit(function() {
			if($("input[name='name']").val()=="") {
				alert("등록할 이름을 적어주세요.");
				return false;
			}
		})
	})
</script>	
	
	<section class="width1200">
		<form id="insertManagementForm" method="post" action="/management/insert">
			<c:if test="${mgt eq 'equipment'}">
				<label>장비명</label>
				<input type="hidden" name="mgt" value="${mgt}">
			</c:if>
			<c:if test="${mgt eq 'department'}">
				<label>부서명</label>
				<input type="hidden" name="mgt" value="${mgt}">
			</c:if>
			<input type="text" name="name">
			<input type="submit" value="등록">
			<input type="reset">
		</form>
		<button id="listManagement">목록</button>
	</section>
</body>
</html>