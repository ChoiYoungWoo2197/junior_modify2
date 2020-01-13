<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>success</title>
<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/mail/authenticate.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mail/success.js"></script>

</head>
<body>
	<main class="main-page">
		<section class="main-page-unit">
		<h3>이메일 주소 인증 성공</h3>
		<div>
			<h5> ${user.name}님 축하합니다. ${user.email}의 이메일 인증이 완료되었습니다.</h5>
			<h5> 이제 새 계정으로 로그인할 수 있습니다.</h5>
		</div>
		</section>

		<section class="main-page-unit">
			<form id="loginForm" name="loginForm" method="post"	action="${pageContext.request.contextPath}/login/check">
				<input type="submit" class="login-btn" value="로그인" />
				<!-- <button type="submit" >로그인</button> -->
			</form>
		</section>
	</main>
</body>
</html>