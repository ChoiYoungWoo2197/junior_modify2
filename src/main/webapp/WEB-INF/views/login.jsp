<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login test</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css" />

<style>

/* 공통 CSS  */
.border {
 	border: 1px solid #ddd; 
}


/* 개별 CSS */
.main-page {
	position: absolute;
	left: 50%;
	top: 50%;
	margin: -200px 0 0 -160px;
}

.main-page-unit {
	position: relative;
	width: 320px;
}

.login-frame {
	margin: 35px 0 0;
	
}

.login-unit {
	position: relative;
	width: 100%;
	padding: 10px;

	overflow: hidden;
}

.login-unit input[type="text"],
.login-unit input[type="password"] {
	width: 85%; /* 원하는 너비 설정 */
	height: auto; /* 높이값 초기화 */
	line-height: normal; /* line-height 초기화 */
	padding: .8em .5em; /* 원하는 여백 설정, 상하단 여백으로 높이를 조절 */
	font-family: inherit; /* 폰트 상속 */
	border: 1px solid #999;
	border-radius: 0; /* iSO 둥근모서리 제거 */
	outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */
	-webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */
}

.login-text input, img {
	float: left;
}

.login-img {
	width: 40px;
	height: 30px;
}

.login-btn {
	margin: 20px 0 0;
	width: 100%;
	height: 48px;
	font-family: sans-serif;
	font-size: 16px;
	color: #404040;
	background-color: #e0e0e0;
	border-radius: 12px; /* 버튼 테두리를 둥글게 */
	border: 2px;
	border-color: #e0e0e0;
}
</style>

</head>
<body>
	<main class="main-page">
		<section class="main-page-unit">
			<form id="loginForm" name="loginForm" method="post" action="${pageContext.request.contextPath}/login/check">
				<div class="login-frame">
					<div class="login-unit">
						<img class="login-img" src="../resources/images/loginID.jpg">
						<input id="loginId" name="loginId" type="text" placeholder="ID">
					</div>
					<div class="login-unit">
						<img class="login-img" src="../resources/images/loginPw.png">
						<input id="loginPw" name="loginPw" type="password" placeholder="Password">
					</div>
				</div>
				<button type="submit" class="login-btn">로그인</button>
			</form>
		</section>

		<section class="main-page-unit">
			<form id="insertForm" name="insertForm" method="get" action="${pageContext.request.contextPath}/member/insert">
				<div class="login-frame">
					<div class="login-unit border text_center">
						<span>아직 회원이 아니십니까?</span>
						<button type="submit" class="login-btn">회원가입</button>
					</div>
				</div>

			</form>
		</section>
	</main>
</body>
</html>