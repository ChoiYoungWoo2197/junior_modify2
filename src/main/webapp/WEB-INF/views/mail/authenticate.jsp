<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>authenticate</title>
<style>
.width1200 {
	width: 1200px;
	margin: 0 auto;
}

table {
	width: 100%;
}

table, th, td {
	border: 1px solid #bcbcbc;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script>
	$(function() {
		$("#sendReMail").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/mail/request",
				type : "post",
				data : {"mail" : $("input[name='mail']").val()},
				dataType : "text",
				success : function(res) {
					console.log(res);
					if(res == "true") {
						alert("이메일이 재발송되었습니다. 인증번호를 입력해주세요.");
					}
					else {
						alert("이메일발송이 실패했습니다.");
					}
				}
			})
		})
		
		$("#cancel").click(function() {
			if(confirm("이메일 인증을 취소하시겠습니까?") == true) {
				window.location.href = '${pageContext.request.contextPath}/';
			}
			
		})
	})
</script>


</head>
<body>
	<section class="width1200">
		<h3>회원 이메일 주소 인증</h3>
		<div>
			<h5>> 이메일로 인증번호를 전송합니다.</h5>
			<h5>> 전송받은 인증번호를 입력 후 확인 버튼을 클릭하십시오.</h5>
			<h5>> 정확한 이메일 주소를 입력하여 주십시오. 예) test@test.co.kr</h5>
			<h5>> 인증메일 발송을 하였는데도 해당 이메일로 인증번호가 안 올 경우에는 다른 이메일 주소를 입력하여
				메일발송을 해주시기 바랍니다.</h5>
		</div>
		<br>
		<form name="authenticateForm" action="${pageContext.request.contextPath}/mail/complete" method="post">
			<table>
				<tr>
					<td><b>이메일 주소</b></td>
					<td><input name="mail" type="text" size="50" value="${mail}" readonly="readonly"/>
				</tr>

				<tr>
					<td><b>인증번호</b></td>
					<td colspan="2">
					<input name="authKey" type="text" size="30" value="" />
					<input 	type="button" id="sendReMail" value="인증메일 재발송"></td>
				</tr>
			</table>
			<input type="button" id="cancel" value="취소" />
			<input type="submit" value="확인" />
		</form>
	</section>
</body>
</html>