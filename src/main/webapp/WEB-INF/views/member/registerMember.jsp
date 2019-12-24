<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberRegister test</title>
<style>
</style>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function check() {
		if(memberForm.id.value =="") {
			alert("값을 입력해 주세요.");
			memberForm.id.focus();
			return false;
		}
		var departmentType = $("#departmentType option:selected").val();
		window.location.href =  "${pageContext.request.contextPath}//insert?departmentType=" + departmentType;
		
		return true;
	}



</script>


</head>
<body>
	<h3>
		회원 등록
		</h2>
		<form name="memberForm" action="insert" method="post" onsubmit="return check()">
			<table width="800" border="1" cellpadding="10" cellspacing="0">
				<tr>
					<td><label>사번</label></td>
					<td><input name ="employeeId" type="text" size="20" />&nbsp;
					<td><button class="idCheck">중복체크</button></td>
				</tr>
				<tr>
					<td><label>사원명</label></td>
					<td><input name ="name" type="text" size="20" />&nbsp;
					<td></td>
				</tr>
				<tr>
					<td><label>소속부서</label></td>
					<td>
					<select name="departmentType" id="departmentType">
							<option value="1" selected="selected">개발부</option>
							<option value="2">기획부</option>
							<option value="3">영업부</option>
							<option value="4">인사부</option>
					</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td><label>비빌번호</label></td>
					<td><input name ="password" type="text" size="20" />&nbsp;
					<td><label>비밀번호 확인</label></td>
					<td><input name ="passwordCheck" type="text" size="20" />&nbsp;
					<td></td>
				</tr>
				<tr>
					<td><label>이메일</label></td>
					<td><input name ="email" type="text" size="20" />&nbsp;
					<td></td>
				</tr>
				<tr>
					<td><label>전화번호</label></td>
					<td><input name ="phone" type="text" size="20" />&nbsp;
					<td></td>
				</tr>

			</table>
			<input type="submit" value="회원가입" />
		</form>
</body>
</html>