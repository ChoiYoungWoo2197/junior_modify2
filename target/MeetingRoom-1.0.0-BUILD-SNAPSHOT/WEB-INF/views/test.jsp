<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#container {
		width: 1000px;
		margin: 0 auto;
	}
	header {
		background-color: rgba(0,0,0,0.2);
		height: 100px;
	}
	li {
		list-style: none;
		float: left;
		width: 20%;
		text-align: center;
	}
	.float_right {
		float: right;
	}
	.clear_both {
		clear: both;
	}
</style>
</head>
<body>
	<header>
		<div id="container">
			<b>회의실관리</b>
			<button id="loginButton" class="float_right">로그인</button>
			<div class="clear_both"></div>
			<nav>
				<ul>
					<li>예약 현황</li>
					<li>부서 관리</li>
					<li>회원 관리</li>
					<li>회의실 관리</li>
					<li>장비 관리</li>
				</ul>
			</nav>
		</div>
	</header>
</body>
</html>