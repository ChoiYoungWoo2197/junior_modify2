<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>memberRegister test</title>
<link href="${pageContext.request.contextPath}/resources/css/common/insert.css" rel="stylesheet" type="text/css" /> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/member/insert.js"></script>


</head>
<body>
	<section class="width1200">
		<c:if test="${not empty loginUser}">
			<c:if test="${loginUser.manager eq 'true'}">
				<h1>회원 등록</h1>
			</c:if>
		</c:if>
		<c:if test="${empty loginUser}">
			<h1>회원 가입</h1>
		</c:if>

		<br>
		<form name="memberForm" method="post" onsubmit="return check()">
			<table>
				<tr>
					<td>
						<b>사번</b><b class="color_red">*</b>
					</td>
					<td class=" border_right_hide">
						<input name="memberId" type="text" placeholder=" 사원번호는 영문,숫자 조합입니다." />
						<input class="float_right"  type="button" onclick="checkId()" value="중복체크"/>	
						<div class="clear_both"></div>				
						<div>
						<span id="valideId" class="error">사원번호를 입력하세요.</span>
						<span id="checkIdSuccess" class="success">사용가능한 사원번호 입니다.</span>
						<span id="checkIdFail" class="error">이미 존재하는 사원번호 입니다.</span>
						</div>

					</td>
					<td colspan="2"  class=" border_left_hide"></td>
				</tr>
				<tr>
					<td>
						<b>사원명</b><b class="color_red">*</b>
					</td>
					<td class=" border_right_hide">
						<input name="name" type="text" placeholder=" 이름은 한글만 입력해주세요."/>
						<div>
						<span id="valideName" class="error">이름을 입력하세요.</span>
						</div>
						
					</td>
					<td colspan="2"  class=" border_left_hide"></td>
				</tr>
				<tr>
					<td>
						<b>소속부서</b><b class="color_red">*</b>
					</td>
					<td class=" border_right_hide">
						<select name="departmentType" id="departmentType" class="width100">
							<option value="">부서선택</option>
							<c:forEach var="list" items="${departmentList}" varStatus="i">
								<option value="${list.departmentId}">${list.name}</option>
							</c:forEach>
						</select>
						<div>
						<span id="valideDepartmentType" class="error">부서를 선택하세요.</span>
						</div>
						
					</td>
					<td colspan="2"  class=" border_left_hide"></td>
				</tr>
				<tr>
					<td>
						<b>비빌번호</b><b class="color_red">*</b>
					</td>
					<td class=" border_right_hide">
						<input name="password" type="password" size="20" placeholder=" 비밀번호는 영문,숫자 조합입니다.[3자리이상 12자리이하]"/>
						<div>
						<span id="validePassword" class="error">비밀번호를 입력하세요.</span>
						</div>
					</td>

					<td class="border_right_hide">
						<b>비밀번호 확인</b><b class="color_red">*</b>
					</td>
					<td colspan="1" class="">
						<input id="passwordCheck" name="passwordCheck" type="password" size="20" />
						<div>
						<span id="validePasswordCheck" class="error">비밀번호 확인을 입력하세요.</span>
						<span id="checkPasswordSuccess" class="success">비밀번호가 일치합니다.</span>
						<span id="checkPasswordFail" class="error">비밀번호가 일치하지 않습니다.</span>
						</div>
						
					</td>
				</tr>
				<tr>
					<td>
						<b>이메일</b><b class="color_red">*</b>
					</td>
					<td class=" border_right_hide ">
						<input name="email" type="text" size="20" placeholder=" 예)abc@naver.com"/>
						<input class="float_right" type="button" id="employeeEmailCheck" onclick="checkEmail()" value="중복체크">
						<div class="float_right"></div>
						<div>
						<span id="valideEmail" class="error">이메일을 입력하세요.</span>
						<span id="checkEmailSuccess" class="success">사용가능한 이메일 입니다.</span>
						<span id="checkEmailFail" class="error">이미 존재하는 이메일 입니다.</span>
						</div>
						
					</td>
					<td colspan="2"  class=" border_left_hide">
						
					</td>
				</tr>
				<tr>
					<td>
						<label>전화번호</label>
					</td>
					<td class=" border_right_hide">
 						<input name="phone" type="text" size="20" placeholder=" 예)010-0000-0000"/>
 						<div>
 						<span id="validePhone" class="error">전화번호를 입력하세요.</span>
 						</div>
					</td>
					<td colspan="2"  class=" border_left_hide"></td>
				</tr>
				<c:if test="${not empty loginUser}">
					<c:if test="${loginUser.manager eq 'true'}">
						<tr>
							<td>
								<label>관리자권한</label>
							</td>
							<td class=" border_right_hide">
								<input type="radio" name="manager" value="yes" /> yes
								<input type="radio" name="manager" value="no" checked="checked" /> no
							</td>
							<td colspan="2"  class=" border_left_hide"></td>
						</tr>
					</c:if>
				</c:if>



			</table>
			<input type="hidden" id="register" name="register" value="">
			<div>
				<div class="float_right">
					<c:if test="${empty loginUser}">
						<input type="submit" value="회원가입" />
						<input type="button" value="취소" class="listMember">
					</c:if>
					<c:if test="${not empty loginUser}">
						<c:if test="${loginUser.manager eq 'true'}">
							<input type="hidden" id="manager" name="manager" value="${loginUser.manager}"> 
							<input type="submit" value="등록" />
							<input type="button" value="취소" class="listMember">
						</c:if>
					</c:if>
				</div>
				<div class="clear_both"></div>
			</div>
			

		</form>

	</section>




</body>
</html>