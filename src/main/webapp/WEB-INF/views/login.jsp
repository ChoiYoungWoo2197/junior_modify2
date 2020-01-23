<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login test</title>
<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet" type="text/css" /> 
<link href="${pageContext.request.contextPath}/resources/css/login/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="main_page">
		<section class="main_page_unit">
			<form id="loginForm" name="loginForm" method="post" action="${pageContext.request.contextPath}/login/check">
				<div class="login_unit">
					<img src="${pageContext.request.contextPath}/resources/images/loginId.png">
					<input id="loginId" name="loginId" type="text" placeholder="사원번호">
				</div>
				<div class="login_unit">
					<img src="${pageContext.request.contextPath}/resources/images/loginPw.png">
					<input id="loginPw" name="loginPw" type="password" placeholder="비밀번호">
				</div>
				<button type="submit"  class="login_btn">로그인</button>
			</form>
		</section>

		<section class="main_page_unit text_center">
			<!-- <span>계정이 없으신가요?</span> --><a href="${pageContext.request.contextPath}/member/insert">회원가입</a>
		</section>
	</div>
</body>
</html>