<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>authenticate</title>
<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/mail/authenticate.css" rel="stylesheet" type="text/css" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mail/authenticate.js"></script>


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
					<td class= "td_input"><input name="mail" type="text" size="50" value="${mail}" readonly="readonly"/>
				</tr>

				<tr>
					<td><b>인증번호</b></td>
					<td colspan="2" class= "td_input">
					<input name="authKey" type="text" size="30" value="" />
					<input class="float_right" type="button" id="sendReMail" onClick="this.disabled=true;" value="인증메일 재발송">
					<div class="clear_both"></div>
					</td>
				</tr>
			</table>
			<div class="float_right">
				<input type="button" id="cancel" value="취소" />
				<input type="submit" value="확인" />
			</div>
			<div class="clear_both"></div>
		</form>
	</section>
</body>
</html>