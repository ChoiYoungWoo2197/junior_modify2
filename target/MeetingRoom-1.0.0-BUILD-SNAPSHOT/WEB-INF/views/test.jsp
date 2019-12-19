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


	#container {
		width: 1200px;
		margin: 0 auto;
	}
	header {
		height: 100px;
		position: relative;
	}
	ul {
		width: 1200px;
		position: absolute;
		bottom: 0;
	}
	li {
		list-style: none;
		float: left;
		width: 20%;
		text-align: center;
		background-color: #BDBDBD;
		opacity: 0.5;
		padding: 20px 0;
	}
	
</style>
</head>
<body>
	<header>
		<div id="container">
			<h3 class="float_left">회의실관리</h3>
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