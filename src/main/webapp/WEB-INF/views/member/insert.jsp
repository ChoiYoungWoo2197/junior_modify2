<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>memberRegister test</title>
<link href="${pageContext.request.contextPath}/resources/css/member/insert.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member/insert.js" charset="UTF-8" type="text/javascript"></script>


</head>
<body>
	<section class="width1200">
		<c:if test="${not empty loginUser}">
			<c:if test="${loginUser.manager eq 'true'}">
				<h3>회원 등록</h3>
			</c:if>
		</c:if>
		<c:if test="${empty loginUser}">
			<h3>회원 가입</h3>
		</c:if>
		
		<br>
		<form name="memberForm" method="post" onsubmit="return check()">
			<table>
				<tr>
					<td><b>사번</b><b class="red">*</b></td>
					<td><input name="memberId" type="text" size="20" /> <span
						id="valideId" class="error">사원번호를 입력하세요.</span> <span
						id="checkIdSuccess" class="success">사용가능한 사원번호 입니다.</span> <span
						id="checkIdFail" class="error">이미 존재하는 사원번호 입니다.</span></td>
					<td colspan="2"><input type="button" onclick="checkId()" value="중복체크"></td>
				</tr>
				<tr>
					<td><b>사원명</b><b class="red">*</b></td>
					<td><input name="name" type="text" size="20" /> <span
						id="valideName" class="error">이름을 입력하세요.</span></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td><b>소속부서</b><b class="red">*</b></td>
					<td><select name="departmentType" id="departmentType">
							<option value="">부서선택</option>
							<option value="1">개발부</option>
							<option value="2">기획부</option>
							<option value="3">영업부</option>
							<option value="4">인사부</option>
					</select> <span id="valideDepartmentType" class="error">부서를 선택하세요.</span></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td><b>비빌번호</b><b class="red">*</b></td>
					<td><input name="password" type="password" size="20" /> <span
						id="validePassword" class="error">비밀번호를 입력하세요.</span></td>

					<td><b>비밀번호 확인</b><b class="red">*</b></td>
					<td colspan="1"><input id="passwordCheck" name="passwordCheck"
						type="password" size="20" /> <span id="validePasswordCheck"
						class="error">비밀번호 확인을 입력하세요.</span> <span
						id="checkPasswordSuccess" class="success">비밀번호가 일치합니다.</span> <span
						id="checkPasswordFail" class="error">비밀번호가 일치하지 않습니다.</span></td>
				</tr>
				<tr>
					<td><b>이메일</b><b class="red">*</b></td>
					<td><input name="email" type="text" size="20" /> <span
						id="valideEmail" class="error">이메일을 입력하세요.</span> <span
						id="checkEmailSuccess" class="success">사용가능한 이메일 입니다.</span> <span
						id="checkEmailFail" class="error">이미 존재하는 이메일 입니다.</span></td>
					<td colspan="2"><input type="button" id="employeeEmailCheck"
						onclick="checkEmail()" value="중복체크"></td>
				</tr>
				<tr>
					<td><label>전화번호</label></td>
					<td><input name="phone" type="text" size="20" /> <span
						id="validePhone" class="error">전화번호를 입력하세요.</span></td>
					<td colspan="2"></td>
				</tr>
				<c:if test="${not empty loginUser}">
					<c:if test="${loginUser.manager eq 'true'}">
						<tr>
							<td><label>관리자권한</label></td>
							<td>
							<input type="radio" name="manager" value="yes" /> yes
							<input type="radio" name="manager" value="no" checked="checked" /> no</td>
							<td colspan="2"></td>
						</tr>
					</c:if>
				</c:if>



			</table>
			<input type="hidden" id="register" name="register" value="">
			<input type="submit" value="회원가입" />
		</form>

	</section>

</body>
</html>