<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>success</title>
<style>
*, ::after, ::before {
   box-sizing: border-box;
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script>
	$(function() {
		$("#sendReMail").click(function() {
			$.ajax({
				url : "/mail/request",
				type : "post",
				data : {"mail" : $("input[name='mail']").val()},
				dataType : "text",
				success : function(res) {
					console.log(res);
					if(res == "true") {
						alert("이메일이 재발송되었습니다. 인증번호를 입력해주세요.");
					}
					else {
						alert("이메일발송이 실패했습니다.");
					}
				}
			})
		})
	})
</script>


</head>
<body>
	<main class="main-page">
		<section class="main-page-unit">
		<h3>이메일 주소 인증 성공</h3>
		<div>
			<h5> ${user.name}님 축하합니다. ${user.email}의 이메일 인증이 완료되었습니다.</h5>
			<h5> 이제 새 계정으로 로그인할 수 있습니다.</h5>
		</div>
		</section>

		<section class="main-page-unit">
			<form id="loginForm" name="loginForm" method="post"	action="${pageContext.request.contextPath}/login/check">
				<button type="submit" class="login-btn">로그인</button>
			</form>
		</section>
	</main>
</body>
</html>