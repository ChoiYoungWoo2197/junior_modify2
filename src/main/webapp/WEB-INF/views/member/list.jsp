<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp" %>

<style>
	td, th {
		border: 1px solid black;
	}
	table {
		border-collapse: collapse;
		width: 100%;
	}
	
	/* ----------------- 페이지 ----------------- */
	#page {
		text-align: center;
		margin-top: 20px;
	}
	.pagination li {
		width: 20px;
		list-style: none;
		display: inline-block;
	}
	.color_sky {
		background-color: #6799FF !important;
	}
	.page_shape {
		background-color: rgb(189, 189, 189);
		width: 10px;
		height: 10px;
		border-radius: 5px;
		display: inline-block;
	}
</style>

<script>
	$(function() {
		$("#insertMember").click(function() {
			location.href ="${pageContext.request.contextPath}/member/insert";
		})
		

	})
</script>

	<section class="width1200">
		<h1>회원 관리</h1>
			<table>
					<tr>
						<th>No.</th>
						<th>사번</th>
						<th>사원명</th>
						<th>부서</th>
						<th>이메일</th>
						<th>전화번호</th>
					</tr>
					<c:forEach var="member" items="${employeeList}">
						<tr>
							<td>${member.employeeId}</td>
							<td>${member.memberId}</td>
							<td>${member.name}</td>
							<td>${member.departmentId}</td>
							<td>${member.email}</td>
							<td>${member.phone}</td>
						</tr>
					</c:forEach>
			</table>
			<button id="insertMember">회원등록</button>
		
	</section>
</body>
</html>