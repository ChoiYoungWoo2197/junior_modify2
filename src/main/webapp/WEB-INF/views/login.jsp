<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login test</title>
<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/login/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="main-page">
		<section class="main-page-unit">
			<form id="loginForm" name="loginForm" method="post" action="${pageContext.request.contextPath}/login/check">
				<div class="login-frame">
					<div class="login-unit">
						<img class="login-img" src="${pageContext.request.contextPath}/resources/images/loginId.png">
						<input id="loginId" name="loginId" type="text" placeholder="ID">
					</div>
					<div class="login-unit">
						<img class="login-img" src="${pageContext.request.contextPath}/resources/images/loginPw.png">
						<input id="loginPw" name="loginPw" type="password" placeholder="Password">
					</div>
				</div>
				<button type="submit" class="login-btn">로그인</button>
			</form>
		</section>

		<section class="main-page-unit text_center">
			<br>
			<!-- <span>계정이 없으신가요?</span> --><a href="${pageContext.request.contextPath}/member/insert">회원가입</a>
		</section>
	</div>
</body>
</html>