<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	* {
		margin: 0;
		padding: 0;
	}
	.float_left {
		float: left;
	}
	.float_right {
		float: right;
	}
	.clear_both {
		clear: both;
	}


	.width1200 {
		width: 1200px;
		margin: 0 auto;
	}
	header {
		padding: 20px 0;
	}
	nav {
		background-color: rgba(189,189,189,0.5);
		height: 60px;
	}
	li {
		list-style: none;
		float: left;
		width: 20%;
		text-align: center;
		padding: 20px 0;
	}
	
</style>
</head>
<body>
	<div class="width1200">
		<header>
			<button id="loginButton" class="float_right" type="button" onclick="location.href='login.jsp'">로그인</button>
			<div class="clear_both"></div>
		</header>
	</div>
	<nav>
		<div class="width1200">
			<ul>
				<li>예약 현황</li>
				<li>부서 관리</li>
				<li>회원 관리</li>
				<li>회의실 관리</li>
				<li>장비 관리</li>
			</ul>
		</div>
	</nav>
</body>
</html>