<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/calendar.js" charset="UTF-8" type="text/javascript"></script>
</head>
<body>
	<div class="width1200">
		<header>
			<c:if test="${empty loginUser}">
				<img src="${pageContext.request.contextPath}/resources/images/login.png" id="loginButton" class="float_right" onclick="location.href='${pageContext.request.contextPath}/login/login'">
				<%--<button id="loginButton" class="float_right" type="button" onclick="location.href='${pageContext.request.contextPath}/login/login'">로그인</button> --%>
		
				<div class="clear_both"></div>
			</c:if>
			<c:if test="${not empty loginUser}">
				<div class="float_right">
					<c:if test="${loginUser.manager eq 'true'}">
						<span>관리자(${loginUser.user.name}) 님</span>
					</c:if>
					<c:if test="${loginUser.manager eq 'false'}">
						<span>${loginUser.user.name} 님</span>
					</c:if>
					<img src="${pageContext.request.contextPath}/resources/images/logout.png" id="loginButton" class="float_right" onclick="location.href='${pageContext.request.contextPath}/login/out'">
					<%-- <button id="loginButton" class="float_right" type="button" onclick="location.href='${pageContext.request.contextPath}/login/out'">로그아웃</button> --%>
				</div>
				<div class="clear_both"></div>
			</c:if>
		</header>
	</div>
	<nav>
		<div class="width1200">
			<ul>
				<c:if test="${loginUser.manager eq 'true'}">
					<li><a href="${pageContext.request.contextPath}/reservation/list">예약 현황</a></li>
					<li><a href="${pageContext.request.contextPath}/management/list?management=department">부서 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/member/list">회원 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/meetingRoom/list">회의실 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/management/list?management=equipment">장비 관리</a></li>
				</c:if>
				<c:if test="${empty loginUser || loginUser.manager eq 'false'}">
					<li><a href="${pageContext.request.contextPath}/reservation/list">예약 현황</a></li>
					<li><a href="${pageContext.request.contextPath}/meetingRoom/list">회의실 현황</a></li>
				</c:if>
			</ul>
		</div>
	</nav>