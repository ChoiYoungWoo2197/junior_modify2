<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
	td, th {
		border: 1px solid black;
	}
	table {
		border-collapse: collapse;
		width: 100%;
	}
</style>
<script>
	$(function() {
		$("#listManagement").click(function() {
			location.href = "list?management="+$("input[name='management']").val();
		})
		
		$("#updateManagement").click(function() {
			var managementId = Number($("input[name=managementId]").val());
			location.href = "modify?management="+$("input[name=management]").val()+"&managementId="+managementId;
		})
	})
</script>

	<section class="width1200">
		<table>
			<tr>
				<th>부서명</th>
				<th>사번</th>
				<th>사원명</th>
				<th>이메일</th>
				<th>전화번호</th>
			</tr>
			<c:if test="${empty employeeByDepartmentList}">
				<input type="hidden" name="managementId" value="${managementId}">
				<input type="hidden" name="management" value="${management}">
				<tr>
					<td colspan="5">소속된 사원이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty employeeByDepartmentList}">
				<c:forEach var="department" varStatus="status" items="${employeeByDepartmentList}">
					<tr>
						<c:if test="${status.first}">
							<input type="hidden" name="managementId" value="${department.departmentId}">
							<input type="hidden" name="management" value="${management}">
							<td rowspan="${fn:length(employeeByDepartmentList)}">${department.name}</td>
						</c:if>
						<td>${department.employeeId}</td>
						<td>${department.employeeName}</td>
						<td>${department.email}</td>
						<td>${department.phone}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button id="listManagement">목록</button>
		<button id="updateManagement">수정</button>
	</section>
</body>
</html>