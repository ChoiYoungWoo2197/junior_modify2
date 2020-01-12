	//변수
	var validateId = /^[A-Za-z0-9]+$/; //영어 + 숫자만 입력
	var validateName = /^[가-힣]{2,5}$/; //한글만 입력
	var validatePassword = /^[a-z][a-z0-9!@#$*%]{3,12}$/i; //비밀번호 양식 (3-12)
	//var validateEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 양식
	var validateEmail = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	var validatePhone = /^\d{2,3}-\d{3,4}-\d{4}$/; //전화번호 양식
	var checkInput = true;
	var checkMemberId = false;
	var checkMemberEmail = false;
	var checkMemberPassword = false;

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
			window.location.href = "/insert?departmentType="+ departmentType + "&manager=" + manageType + "&register=" + register;
		}
		else {
			alert("입력값 혹은 중복체크를 확인해주세요.");
		}

		return check;
	}
	
	function valideInput() {
		checkInput = true;
		if ($("input[name='memberId']").val() == ""	|| validateId.test($("input[name='memberId']").val()) == false) {
			checkInput = false;
			$("#valideId").css("display", "inline");
			if(validateId.test($("input[name='memberId']").val()) == false && $("input[name='memberId']").val() != "") {
				$("#valideId").html('사원번호 형식이 틀렸습니다.');
			}
			else {
				$("#valideId").html('사원번호를 입력해 주세요.');
			}
		}
		if ($("input[name='name']").val() == ""	|| validateName.test($("input[name='name']").val()) == false) {
			checkInput = false;
			$("#valideName").css("display", "inline");
			
			if(validateName.test($("input[name='name']").val()) == false && $("input[name='name']").val() != "") {
				$("#valideName").html('이름 형식이 틀렸습니다.');
			}
			else {
				$("#valideName").html('이름을 입력해주세요.');
			}
		}
		if ($("input[name='password']").val() == ""	|| validatePassword.test($("input[name='password']").val()) == false) {
			checkInput = false;
			$("#validePassword").css("display", "inline");
			
			if(validatePassword.test($("input[name='password']").val()) == false && $("input[name='password']").val() != "") {
				$("#validePassword").html('패스워드 형식이 틀렸습니다.');
			}
			else {
				$("#validePassword").html('패스워드를 입력해주세요.');
			}
		}
		if ($("input[name='passwordCheck']").val() == "") {
			$("#validePasswordCheck").css("display", "inline");
			checkInput = false;
		}
		if ($("input[name='email']").val() == "" || validateEmail.test($("input[name='email']").val()) == false) {
			checkInput = false;
			$("#valideEmail").css("display", "inline");
			if(validateEmail.test($("input[name='email']").val()) == false && $("input[name='email']").val() != "") {
				$("#valideEmail").html('이메일 형식이 틀렸습니다.');
			}
			else {
				$("#valideEmail").html('이메일을 입력해주세요.');
			}
		}


		if ($("input[name='phone']").val() == "" || validatePhone.test($("input[name='phone']").val()) == false) {
			checkInput = false;
			$("#validePhone").css("display", "inline");
			
			if(validatePhone.test($("input[name='phone']").val()) == false && $("input[name='phone']").val() != "") {
				$("#validePhone").html('전화번호 형식이 틀렸습니다.');
			}
			else {
				$("#validePhone").html('전화번호를 입력해주세요.');
			}
			
		}
		if ($("select[name='departmentType']").val() == "") {
			$("#valideDepartmentType").css("display", "inline");
			checkInput = false;
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
			return true;
		} else {
			return false;
		}
	}

	function checkId() {
		$("#valideId").css("display", "none");
		if ($("input[name='memberId']").val() == ""	|| validateId.test($("input[name='memberId']").val()) == false) {
			$("#valideId").css("display", "inline");

			return false;
		}

		var memberId = $("input[name='memberId']").val();
		$.ajax({
			url : "/member/checkId",
			type : "post",
			data : {
				"memberId" : $("input[name='memberId']").val()
			},
			dataType : "text",
			success : function(res) {
				console.log(res);
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
		if ($("input[name='email']").val() == "" || validateEmail.test($("input[name='email']").val()) == false) {
			$("#valideEmail").css("display", "inline");

			return false;
		}

		var email = $("input[name='email']").val();
		$.ajax({
			url : "/member/checkEmail",
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
		var register = $("input[name='manager']").val();
	
		//alert(register + " ::");
		//var result = register.indexOf("manager=true", 0);
		if (register != null) {
			$("input[name='register']").val("true");
			return true;
		} else {
			$("input[name='register']").val("false");
			return false;
		}

	}

	$(function() {
		$(".listMember").click(function() {
			location.href = "list";
		})
	})