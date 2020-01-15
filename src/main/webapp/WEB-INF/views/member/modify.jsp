<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberRegister test</title>
<%-- <link href="${pageContext.request.contextPath}/resources/css/standard.css" rel="stylesheet" type="text/css" /> --%>
<link href="${pageContext.request.contextPath}/resources/css/common/insert.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/member/modify.js"></script>

</head>
<body>
	<section class="width1200">
		<h1>회원 수정</h1>
		<form name="memberForm"  method="post"	onsubmit="return check()">
			<div class="color_red float_right">* 필수입력</div>
			<div class="clear_both"></div>
			<table>
				<tr>
					<th  class="width150px"><b>사번</b><b class="color_red">*</b></th>
					<td class="td_input td_border_hide">
						<input name="modifyMemberId" type="text" size="20" value="${employeeModify.memberId}" placeholder=" 사원번호는 영문,숫자 조합입니다."  readonly="readonly"/> 
						<div>
						<span id="valideId"	class="error">사원번호를 입력하세요.</span>
						<span id="checkIdSuccess" class="success">사용가능한 사원번호 입니다.</span>
						</div>
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<th  class="width150px"><b>사원명</b><b class="color_red">*</b></th>
					<td class="td_input td_border_hide">
						<input name="name" type="text" size="20" value="${employeeModify.name}" placeholder=" 이름은 한글만 입력해주세요. [2자리이상 5자리이하]"/>
						<div>
						<span id="valideName" class="error">이름을 입력하세요.</span>
						</div>
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<th  class="width150px"><b>소속부서</b><b class="color_red">*</b></th>
					<td class="td_input td_border_hide">
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
					<td colspan="2"></td>
				</tr>
				<tr>
					<th  class="width150px"><b>비빌번호</b><b class="color_red">*</b></th>
					<td class="td_input td_border_hide">
						<input name="password" type="password" size="20"  placeholder=" 비밀번호는 영문,숫자 조합입니다.[3자리이상 12자리이하]"/>
						<div>
							<span id="validePassword" class="error">비밀번호를 입력하세요.</span>
						</div>
						
					</td>

					<th  class="width150px"><b>비밀번호 확인</b><b class="color_red">*</b></th>
					<td colspan="1" class="td_input">
						<input id="passwordCheck" name="passwordCheck" type="password" size="20"  />
						<div>
							<span id="validePasswordCheck"	class="error">비밀번호 확인을 입력하세요.</span>
							<span id="checkPasswordSuccess" class="success">비밀번호가 일치합니다.</span>
							<span id="checkPasswordFail" class="error">비밀번호가 일치하지 않습니다.</span>
						</div>
						</td>
					
				</tr>
				<tr>
					<th  class="width150px"><b>이메일</b><b class="color_red">*</b></th>
					<td class="td_input td_border_hide">
						<input class="width100_Important"  name="email" type="text" size="20" value="${employeeModify.email}" placeholder=" 예)abc@naver.com"/>
						<div>
							<span id="valideEmail"	class="error">이메일을 입력하세요.</span>
							<span id="checkEmailSuccess" class="success">사용가능한 이메일 입니다.</span>
							<span id="checkEmailFail" class="error">이미 존재하는 이메일 입니다.</span>
							
						</div>
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<th  class="width150px"><label>전화번호</label></th>
					<td class="td_input td_border_hide">
						<input name="phone" type="text" size="20" value="${employeeModify.phone}" placeholder=" 예)010.0000.0000"/>
						<div>
						<span id="validePhone" class="error">전화번호를 입력하세요.</span>	
						</div>
					</td>
					
					<td colspan="2"></td>
				</tr>
				<tr>
					<th  class="width150px"><label>관리자권한</label></th>
					<td class="td_input td_border_hide">
						<input type="radio" name="manager" value="yes"> yes
						<input type="radio" name="manager" value="no" checked="checked"> no</td>
					<td colspan="2"></td>
				</tr>


			</table>
			<input type="hidden" id="modifyPassword" name="modifyPassword" value="">
			<input type="hidden" id="departmentId" name="departmentId" value="${employeeModify.departmentId}"> 
			<input type="hidden" id="managerType" name="managerType" value="${managerType}"> 
			<input type="hidden" id="originalMemberId" name="originalMemberId" value="${employeeModify.memberId}"> 
			<div class="float_right">
				<input type="submit" value="수정" />
				<input type="button" value="취소" onclick="memberList()">
			</div>
			<div class="clear_both"></div>
			
		</form>

	</section>




</body>
</html>