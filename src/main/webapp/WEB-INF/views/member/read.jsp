</html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>

<script src="${pageContext.request.contextPath}/resources/js/member/read.js" charset="UTF-8" type="text/javascript"></script>

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
				<td>${managerType}</td>
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