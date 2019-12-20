<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp" %>
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

function rowDel (obj) {
	var tr = obj.parentNode.parentNode;
	tr.parentNode.removeChild(tr);
}
</style>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>No.</th>
				<th>부서명</th>
				<th>소속인원</th>
				<th>등록일시</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${departMentData}">
				<tr>
					<th>${data.departmentId}</th>
					<th>${data.name}</th>
					<th>${data.account}</th>
					<td><fmt:formatDate value="${data.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
					<td><input type="button" id="1" value="삭제" onclick='javascript:rowDel(this);'></td>
				</tr>
			</c:forEach>
		</tbody>

	</table>


</body>
</html>