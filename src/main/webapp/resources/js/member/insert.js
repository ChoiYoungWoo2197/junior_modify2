//변수
var validateId = /^[A-Za-z0-9]+$/; //영어 + 숫자만 입력
var validateName = /^[가-힣]{2,5}$/; //한글만 입력
var validatePassword = /^[a-z][a-z0-9!@#$*%]{3,14}$/i; //비밀번호 양식 (3-14)
var validateEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 양식
var validatePhone = /^\d{2,3}-\d{3,4}-\d{4}$/; //전화번호 양식
var checkInput = true;
var checkMemberId = true;
var checkMemberEmail = true;
var checkMemberPassword = true;

function check() {
	checkRegister();

	clearError();

	valideInput();

	samePassword();

	var check = checkAll();
	if (check == true) {
		var departmentType = $("#departmentType option:selected").val();
		var manageType = $('input:radio[name="manager"][value="yes"]').is(':checked');
		var register =checkRegister();
		alert($("input[name='register']").val());
		window.location.href = "${pageContext.request.contextPath}/insert?departmentType="+ departmentType + "&manager=" + manageType + "&register=" + register;
		//window.location.href = "${pageContext.request.contextPath}/insert?departmentType="+ departmentType;

	}

	return check;
}

function valideRadio(name) {
	//document에서 함수의 인자와 같은 태그요소를 가져오기 위해 사용
	var chk_radio = document.getElementsByName(name);
	var sel_type = null;
	for(var i=0;i<chk_radio.length;i++){
		if(chk_radio[i].checked == true){ 
			return chk_radio[i].value;
		}
	}
}

function valideInput() {
	checkInput = true;
	if ($("input[name='memberId']").val() == ""
		|| validateId.test($("input[name='memberId']").val()) == false) {
		$("#valideId").css("display", "inline");
		checkInput = false;
		//alert("valideId :" + checkInput);
	}
	if ($("input[name='name']").val() == ""
		|| validateName.test($("input[name='name']").val()) == false) {
		$("#valideName").css("display", "inline");

		checkInput = false;
		//alert("valideName :" + checkInput);
	}
	if ($("input[name='password']").val() == ""
		|| validatePassword.test($("input[name='password']").val()) == false) {
		$("#validePassword").css("display", "inline");
		checkInput = false;
		//alert("validePassword :" + checkInput);
	}
	if ($("input[name='passwordCheck']").val() == "") {
		$("#validePasswordCheck").css("display", "inline");
		checkInput = false;
		//alert("validePasswordCheck :" + checkInput);
	}
	if ($("input[name='email']").val() == ""
		|| validateEmail.test($("input[name='email']").val()) == false) {
		$("#valideEmail").css("display", "inline");
		checkInput = false;
		//alert("valideEmail :" + checkInput);
	}
	if ($("input[name='phone']").val() == ""
		|| validatePhone.test($("input[name='phone']").val()) == false) {
		$("#validePhone").css("display", "inline");
		checkInput = false;
		//alert("validePhone :" + checkInput);
	}
	if ($("select[name='departmentType']").val() == "") {
		$("#valideDepartmentType").css("display", "inline");
		checkInput = false;
		//alert("valideDepartmentType :" + checkInput);
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
	if (checkInput == true && checkMemberId == true && checkMemberEmail == true && checkMemberPassword == true) {
		//alert("true");
		return true;
	} else {
		//alert("checkInput : " + checkInput + " checkMemberId : " + checkMemberId + " checkMemberEmail : " + checkMemberEmail + " checkMemberPassword : " + checkMemberPassword);
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

function checkRegister() {
	var register =  '<%=session.getAttribute("loginUser")%>';
	var result = register.indexOf("manager=true", 0 );

	if(result > 0) {
		$("input[name='register']").val("true");
		return true;
	}
	else {
		$("input[name='register']").val("false");
		return false;
	}


}