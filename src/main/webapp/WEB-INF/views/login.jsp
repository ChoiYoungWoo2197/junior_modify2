<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login test</title>
<!-- <link rel="stylesheet" href="./resources/css/login/login.css" /> -->
<style>
*, ::after, ::before {
   box-sizing: border-box;
}

html, body {
   margin: 0;
   font-size: 13px;
   line-height: 1.5;
}

.main-page {
   position: absolute;
   left: 50%;
   top: 50%;
   margin: -145px 0 0 -160px;
}

.main-page-unit {
   position: relative;
   width: 320px;
   
}

.login-frame {
   margin: 35px 0 0;
   border: 1px solid #ddd;
}

.login-unit {
   position: relative;
   width: 100%;
   padding: 18px 19px 19px;
   border-top: 1px solid #ddd;
   overflow: hidden;
}

.login-text input, img{
	float: left;
}


.login-img {
 width:  40px;
 height: 30px;
 
}

.login-input {
	width: 80%;
	position : relative;
	top: 7px;
}

.login-btn {
   margin: 20px 0 0;
   width: 100%;
   height: 48px;
   font-family : sans-serif;
   font-size: 16px;
   color: #404040;
   background-color: #e0e0e0;
   border-radius: 12px;/* 버튼 테두리를 둥글게 */
   border : 2px;
   border-color:  #e0e0e0;
}
</style>


</head>
<body>
	<main class="main-page">
		<section class="main-page-unit">
			<form id="loginForm" name="loginForm" method="post"	action="${pageContext.request.contextPath}/login/check">
				<div class="login-frame">
					<div class="login-unit">
						<img class="login-img" src="../resources/images/loginID.jpg">
						<input class="login-input" id="loginId" name="loginId" type="text"	placeholder="ID">
					</div>
					<div class="login-unit">
						<img class="login-img" src="../resources/images/loginPw.png">
						<input class="login-input" id="loginPw" name="loginPw"	type="password" placeholder="Password">
					</div>
				</div>
				<button type="submit" class="login-btn">로그인</button>
			</form>
		</section>

		<section class="main-page-unit">
			<form id="insertForm" name="insertForm" method="get" action="${pageContext.request.contextPath}/member/insert">
				<div class="login-frame">
					<div class="login-unit">
						<button type="submit" class="login-btn">회원가입</button>
					</div>
				</div>

			</form>
		</section>
	</main>
</body>
</html>