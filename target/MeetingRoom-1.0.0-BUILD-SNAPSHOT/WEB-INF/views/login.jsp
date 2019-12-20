<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login test</title>
<link rel="stylesheet" href="./resources/css/login/login.css" />

</head>
<body>
	<main class="main-page">
		<header>
			<div>
				<form id="departMentForm" name="departMentForm" method="post" action="departMentPage.do">
					<button type="submit" class="login-btn">부서관리</button>
				</form>

			</div>

		</header>

		<section class="main-page-unit">
			<form id="loginForm" name="loginForm" method="post"
				action="loginCheck.do">
				<div class="login-frame">
					<div class="login-unit">
						<img class="login-img" src="./resources/images/loginID.jpg">
						<input class="login-input" id="loginId" name="loginId" type="text"
							placeholder="ID">
					</div>
					<div class="login-unit">
						<img class="login-img" src="./resources/images/loginPw.png">
						<input class="login-input" id="loginPw" name="loginPw"
							type="password" placeholder="Password">
					</div>
				</div>
				<button type="submit" class="login-btn">로그인</button>
			</form>
		</section>
	</main>
</body>
</html>