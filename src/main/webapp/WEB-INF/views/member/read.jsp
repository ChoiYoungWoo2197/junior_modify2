</html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>

<style>
.color_red {
	color: red;
	font-size: 14px;
}

.display_none {
	display: none;
}
</style>
<script>
	$(function() {
		$("#list").click(function() {
			location.href = "list";
		})
		
		$("#update").click(function() {
			var memberId = Number($("input[name=memberId]").val());
			location.href = "modify?memberId="+memberId;
		})
		
		$("#delete").click(function() {
			var result = confirm($("#name").text()+"님을 삭제하시겠습니까?");
			
			if(result == true) {
				var memberId = Number($("input[name=memberId]").val());
				location.href = "delete?memberId="+memberId;
			}
		})
	})
</script>

<section class="width1200">
	<table>
		<tr>
			<th>No.</th>
			<th>이름</th>
			<th>사원번호</th>
			<th>부서</th>
			<th>승인여부</th>
			<th>관리자권한</th>
			<th>이메일</th>
			<th>전화번호</th>
		</tr>
			<tr>
				<td>${employeeDetail.employeeId}</td>
				<td id="name">${employeeDetail.name}</td>
				<td>${employeeDetail.memberId}</td>
				<td>${employeeDetail.departmentId}</td>
				<td>${employeeDetail.state}</td>
				<td>${employeeDetail.state}</td>
				<td>${employeeDetail.email}</td>
				<td>${employeeDetail.phone}</td>
			</tr>

	</table>
	<input type="hidden" name="memberId" value="${employeeDetail.memberId}">
	<button id="list">목록</button>
	<button id="update">수정</button>
	<button id="delete">삭제</button>
</section>
</body>
</html>