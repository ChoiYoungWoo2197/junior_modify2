<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>departMent test</title>
<style>
	table {
		width: 100%;
	}
	
	table, th, td {
		border: 1px solid #bcbcbc;
	}
	

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
</script>


</head>
<body>
	<h3>회원 관리</h1>
	<div>
		<label>회원명</label>
		<input type="text" name="searchName">
		<button id="searchEmployee">검색</button>
	</div>


	<table id="tableEmployee">
		<thead>
			<tr>
				<th>사번</th>
				<th>사원명</th>
				<th>부서</th>
				<th>이메일</th>
				<th>전화번호</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${employeeData}">
				<tr>
					<th>${data.employeeId}</th>
					<th>${data.name}</th>
					<th>${data.departmentId}</th>
					<th>${data.email}</th>
					<th>${data.phone}</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button id="insertEmployee">회원 등록</button>

</body>
</html>