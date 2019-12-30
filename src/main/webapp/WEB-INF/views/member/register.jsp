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
<style>
table {
	width: 100%;
}

table, th, td {
	border: 1px solid #bcbcbc;
}

.red {
	color: red;
}

.error {
	color: red;
	display: none;
}

.success {
	color: blue;
	display: none;
}

.width1200 {
	width: 1200px;
	margin: 0 auto;
}

.overflow {
	overflow: hidden;
}

.float {
	float: right;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	//변수
	var validateId = /^[A-Za-z0-9]+$/; //영어 + 숫자만 입력
	var validateName = /^[가-힣]{2,5}$/; //한글만 입력
	var validatePassword = /^[a-z][a-z0-9!@#$*%]{3,14}$/i; //비밀번호 양식 (3-14)
	var validateEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 양식
	var validatePhone = /^\d{2,3}-\d{3,4}-\d{4}$/; //전화번호 양식
	var checkInput = true;
	var checkMemberId= true;
	var checkMemberEmail = true;
	var checkMemberPassword = true;
	
	function check() {
		//alert($("input[name='memberId']").val());
		clearError();

		valideInput();

		samePassword();

		var check = checkAll();
		if (check == true) {
			var departmentType = $("#departmentType option:selected").val();
			window.location.href = "${pageContext.request.contextPath}//insert?departmentType="
					+ departmentType;
		}

		return check;
	}

	function valideInput() {
		checkInput = true;
		if ($("input[name='memberId']").val() == ""
				|| validateId.test($("input[name='memberId']").val()) == false) {
			$("#valideId").css("display", "inline");
			checkInput = false;
			alert("valideId :" + checkInput);
		}
		if ($("input[name='name']").val() == ""
				|| validateName.test($("input[name='name']").val()) == false) {
			$("#valideName").css("display", "inline");
			
			checkInput = false;
			alert("valideName :" + checkInput);
		}
		if ($("input[name='password']").val() == ""
				|| validatePassword.test($("input[name='password']").val()) == false) {
			$("#validePassword").css("display", "inline");
			checkInput = false;
			alert("validePassword :" + checkInput);
		}
		if ($("input[name='passwordCheck']").val() == "") {
			$("#validePasswordCheck").css("display", "inline");
			checkInput = false;
			alert("validePasswordCheck :" + checkInput);
		}
		if ($("input[name='email']").val() == ""
				|| validateEmail.test($("input[name='email']").val()) == false) {
			$("#valideEmail").css("display", "inline");
			checkInput = false;
			alert("valideEmail :" + checkInput);
		}
		if ($("input[name='phone']").val() == ""
				|| validatePhone.test($("input[name='phone']").val()) == false) {
			$("#validePhone").css("display", "inline");
			checkInput = false;
			alert("validePhone :" + checkInput);
		}
		if ($("select[name='departmentType']").val() == "") {
			$("#valideDepartmentType").css("display", "inline");
			checkInput = false;
			alert("valideDepartmentType :" + checkInput);
		}
	}

	function clearError() {
		$("#valideId").css("display", "none");
		$("#valideName").css("display", "none");
		$("#validePassword").css("display", "none");
		$("#validePasswordCheck").css("display", "none");
		$("#valideEmail").css("display", "none");
		$("#validePhone").css("display", "none");
		$("#valideDepartmentType").css("display", "none");

		$("#checkIdSuccess").css("display", "none");
		$("#checkIdFail").css("display", "none");
		$("#checkEmailSuccess").css("display", "none");
		$("#checkEmailFail").css("display", "none");
		$("#checkEmailSuccess").css("display", "none");
		$("#checkEmailFail").css("display", "none");
		$("#checkPasswordSuccess").css("display", "none");
		$("#checkPasswordFail").css("display", "none");
	}
	
	function checkAll() {
		if(checkInput == true && checkMemberId == true && checkMemberEmail == true && checkMemberPassword == true) {
			alert("true");
			return true;
		}
		else {
			alert("checkInput : " + checkInput + " checkMemberId : " + checkMemberId + " checkMemberEmail : " + checkMemberEmail + " checkMemberPassword : " + checkMemberPassword);
			return false;
		}
	}

	function checkId() {
		$("#valideId").css("display", "none");
		if ($("input[name='memberId']").val() == ""
				|| validateId.test($("input[name='memberId']").val()) == false) {
			$("#valideId").css("display", "inline");

			return false;
		}

		var memberId = $("input[name='memberId']").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/member/checkId",
			type : "post",
			data : {
				"memberId" : $("input[name='memberId']").val()
			},
			dataType : "text",
			success : function(res) {
				console.log(res);
		 		//alert(res);
				if (res == "true") {
					$("#checkIdSuccess").css("display", "none");
					$("#checkIdFail").css("display", "inline");
					checkMemberId = false;
				} else if (res == "false") {
					$("#checkIdSuccess").css("display", "inline");
					$("#checkIdFail").css("display", "none");
					checkMemberId = true;
				}
			}
		})

	}

	function checkEmail() {
		$("#valideEmail").css("display", "none");
		if ($("input[name='email']").val() == ""
				|| validateEmail.test($("input[name='email']").val()) == false) {
			$("#valideEmail").css("display", "inline");

			return false;
		}

		var email = $("input[name='email']").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/member/checkEmail",
			type : "post",
			data : {
				"email" : $("input[name='email']").val()
			},
			dataType : "text",
			success : function(res) {
				console.log(res);

				if (res == "true") {
					$("#checkEmailSuccess").css("display", "none");
					$("#checkEmailFail").css("display", "inline");
					checkMemberEmail = false;
				} else if (res == "false") {
					$("#checkEmailSuccess").css("display", "inline");
					$("#checkEmailFail").css("display", "none");
					checkMemberEmail = true;
				}
			}
		})

	}

	function samePassword() {
		$("#validePasswordCheck").css("display", "none");

		var password1 = $("input[name='password']").val();
		var password2 = $("input[name='passwordCheck']").val();

		if (password1 != "" && password2 != "") {

			if (password1 == password2) {
				$("#checkPasswordSuccess").css("display", "inline");
				$("#checkPasswordFail").css("display", "none");
				checkMemberPassword = true;
			} else {
				$("#checkPasswordSuccess").css("display", "none");
				$("#checkPasswordFail").css("display", "inline");
				checkMemberPassword = false;
			}

		}

	}
</script>


</head>
<body>
	<section class="width1200">
		<h3>회원 등록</h3>
		<div class="overflow">
			<div class="float">
				<b class="red">* 필수입력</b>
			</div>
		</div>
		<br>
		<form name="memberForm" action="insert" method="post" onsubmit="return check()">
			<table>
				<tr>
					<td><b>사번</b><b class="red">*</b></td>
					<td>
					<input name="memberId" type="text" size="20" />
					<span id="valideId"	class="error" size="20">사원번호를 입력하세요.</span>
					<span id="checkIdSuccess" class="success" size="20">사용가능한 사원번호 입니다.</span>
					<span id="checkIdFail" class="error" size="20">이미 존재하는 사원번호 입니다.</span>
					</td>
					<td colspan="2"><input type="button" onclick="checkId()" value="중복체크"></td>
					

				</tr>
				<tr>
					<td><b>사원명</b><b class="red">*</b></td>
					<td>
					<input name="name" type="text" size="20" />
					<span id="valideName" class="error" size="20">이름을 입력하세요.</span>
					</td>
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
					</select>
					<span id="valideDepartmentType" class="error" size="20">부서를 선택하세요.</span>
					</td>
					<td colspan="2"></td>
				</tr>
				</tr>
				<tr>
					<td><b>비빌번호</b><b class="red">*</b></td>
					<td><input name="password" type="password" size="20" />
					<span id="validePassword" class="error" size="20">비밀번호를 입력하세요.</span>
					</td>
					
					<td><b>비밀번호 확인</b><b class="red">*</b></td>
					<td colspan="1">
					<input id="passwordCheck" name="passwordCheck" type="password" size="20" />
					<span id="validePasswordCheck"	class="error" size="20">비밀번호 확인을 입력하세요.</span>
					<span id="checkPasswordSuccess" class="success" size="20">비밀번호가 일치합니다.</span>
					<span id="checkPasswordFail" class="error" size="20">비밀번호가 일치하지 않습니다.</span>
					</td>
				</tr>
				<tr>
					<td><b>이메일</b><b class="red">*</b></td>
					<td>
					<input name="email" type="text" size="20" />
					<span id="valideEmail" class="error" size="20">이메일을 입력하세요.</span>
					<span id="checkEmailSuccess" class="success" size="20">사용가능한 이메일	입니다.</span>
					<span id="checkEmailFail" class="error" size="20">이미 존재하는 이메일 입니다.</span>
					</td>
					<td colspan="2"><input type="button" id="employeeEmailCheck" onclick="checkEmail()" value="중복체크"></td>
				</tr>
				<tr>
					<td><label>전화번호</label></td>
					<td>
					<input name="phone" type="text" size="20" />
					<span id="validePhone" class="error" size="20">전화번호를 입력하세요.</span>
					</td>
					<td colspan="2"></td>
				</tr>

			</table>
			<input type="submit" value="회원가입" />
		</form>

	</section>




</body>
</html>