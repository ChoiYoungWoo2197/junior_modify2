</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/read.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/member/read.js"></script>


<section class="width1200">
	<h1>회원 상세내역</h1>
	<img src="${pageContext.request.contextPath}/resources/images/list2.png" id="list" class="float_right icon_img">
	<table>
		<tr>
			<th>번호</th>
			<td colspan="2"><span>${employeeDetail.employeeId}</span></td>
		</tr>
		<tr>
			<th id="name">이름</th>
			<td colspan="2"><span>${employeeDetail.name}</span></td>
		</tr>
		<tr>
			<th>사원번호</th>
			<td colspan="2"><span>${employeeDetail.memberId}</span></td>
		</tr>
		<tr>
			<th>부서</th>
			<td colspan="2"><span>${employeeDetail.departmentId}</span></td>
		</tr>
		<tr>
			<th>승인여부</th>
			<td colspan="2"><span>${employeeDetail.state}</span></td>
		</tr>
		<tr>
			<th>관리자권한</th>	<td colspan="2"><span>${managerType}</span></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td colspan="2"><span>${employeeDetail.email}</span></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td colspan="2"><span>${employeeDetail.phone}</span></td>
		</tr>
	</table>


	<input type="hidden" name="name" value="${employeeDetail.name}">
	<input type="hidden" name="memberId" value="${employeeDetail.memberId}">
	<div class="float_right">
		<button id="update">수정</button>
		<button id="delete">삭제</button>
		<div class="clear_both"></div>
	</div>

</section>
</body>
</html>