<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<th>${data.registerDate}</th>
			</tr>
		</c:forEach>
		</tbody>

	</table>
</body>
</html>