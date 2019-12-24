<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/managerHeader.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="width1200">
		<header>
			<button id="loginButton" class="float_right" type="button" onclick="location.href='/login'">로그인</button>
			<div class="clear_both"></div>
		</header>
	</div>
	<nav>
		<div class="width1200">
			<ul>
				<li>예약 현황</li>
				<li><a href="${pageContext.request.contextPath}/management/list?mgn=department">부서 관리</a></li>
				<li><a href="member/register">회원 관리</a></li>
				<li>회의실 관리</li>
				<li><a href="${pageContext.request.contextPath}/management/list?mgn=equipment">장비 관리</a></li>
			</ul>
		</div>
	</nav>
