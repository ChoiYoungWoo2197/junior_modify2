<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/managerHeader.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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
				<li><a href="${pageContext.request.contextPath}/management/list?mgt=department">부서 관리</a></li>
				<li><a href="member/register">회원 관리</a></li>
				<li>회의실 관리</li>
				<li><a href="${pageContext.request.contextPath}/management/list?mgt=equipment">장비 관리</a></li>
			</ul>
		</div>
	</nav>
