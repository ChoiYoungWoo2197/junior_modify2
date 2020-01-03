</html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/member/modify.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/member/read.js" charset="UTF-8" type="text/javascript"></script>

<section class="width1200">
	<h1>회원 상세내역</h1>
	<table>
		<tr>
			<td><b>No.</b></td>
			<td colspan="2"><span>${employeeDetail.employeeId}</span></td>
		</tr>
		<tr>
			<td id="name"><b>이름</b></td>
			<td colspan="2"><span>${employeeDetail.name}</span></td>
		</tr>
		<tr>
			<td><b>사원번호</b></td>
			<td colspan="2"><span>${employeeDetail.memberId}</span></td>
		</tr>
		<tr>
			<td><b>부서</b></td>
			<td colspan="2"><span>${employeeDetail.departmentId}</span></td>
		</tr>
		<tr>
			<td><b>승인여부</b></td>
			<td colspan="2"><span>${employeeDetail.state}</span></td>
		</tr>
		<tr>
			<td><b>관리자권한</b></td>
			<td colspan="2"><span>${managerType}</span></td>
		</tr>
		<tr>
			<td><b>이메일</b></td>
			<td colspan="2"><span>${employeeDetail.email}</span></td>
		</tr>
		<tr>
			<td><b>전화번호</b></td>
			<td colspan="2"><span>${employeeDetail.phone}</span></td>
		</tr>
	</table>



	<input type="hidden" name="memberId" value="${employeeDetail.memberId}">
	<button id="list">목록</button>
	<button id="update">수정</button>
	<button id="delete">삭제</button>
</section>
</body>
</html>