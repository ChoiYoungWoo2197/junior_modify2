//변수
var validateId = /^[A-Za-z0-9]+$/; // 영어 + 숫자만 입력
var validateName = /^[가-힣]{2,5}$/; // 한글만 입력
var validatePassword = /^[a-z][a-z0-9!@#$*%]{3,12}$/i; // 비밀번호 양식 (3-12)
var validateEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
                                                                              // 양식
var validatePhone = /^\d{2,3}-\d{3,4}-\d{4}$/; // 전화번호 양식
var checkInput = true;
var checkMemberId = true;
var checkMemberEmail = true;
var checkMemberPassword = true;

window.onload = function() {
   modifyDepartMentType();

   modifyManagerType();
}

function check() {
   clearError();

   valideInput();

   updatePassword();

   var check = checkAll();
   if (check == true) {
      var departmentType = $("#departmentType option:selected").val();
      var manageType = $('input:radio[name="manager"][value="yes"]').is(':checked');
      var originalMemberId = $("input[name='originalMemberId']").val();
      var memberId = $("input[name='modifyMemberId']").val();
      // alert(originalMemberId + " : " +memberId);
      window.location.href = "/modify?departmentType=" + departmentType + "&manager=" + manageType + "&originalMemberId=" + originalMemberId;

   }

   return check;
}

function updatePassword() {
   if ($("input[name='password']").val() != ""){
      if(validatePassword.test($("input[name='password']").val()) == true) {
         if(samePassword() == true) {
            $("#checkPasswordSuccess").css("display", "inline");
            $("#modifyPassword").val($("input[name='password']").val());
            checkMemberPassword = true;      
         }
         else {
            $("#validePassword").css("display", "inline");
            $("#validePassword").html('패스워드 확인과 일치하지 않습니다.');
            checkMemberPassword = false;
         }
      }
      else {
         $("#validePassword").css("display", "inline");
         $("#validePassword").html('패스워드 형식이 틀렸습니다.');
         checkMemberPassword = false;
      }
      
   }
}

function valideInput() {
   checkInput = true;
   if ($("input[name='modifyMemberId']").val() == "" || validateId.test($("input[name='modifyMemberId']").val()) == false) {
      $("#valideId").css("display", "inline");
      checkInput = false;
      // alert("valideId :" + checkInput);
   }
   if ($("input[name='name']").val() == ""   || validateName.test($("input[name='name']").val()) == false) {
      $("#valideName").css("display", "inline");

      checkInput = false;
      // alert("valideName :" + checkInput);
   }

   if ($("input[name='email']").val() == "" || validateEmail.test($("input[name='email']").val()) == false) {
      $("#valideEmail").css("display", "inline");
      checkInput = false;
      // alert("valideEmail :" + checkInput);
   }
   if ($("input[name='phone']").val() == "" || validatePhone.test($("input[name='phone']").val()) == false) {
      $("#validePhone").css("display", "inline");
      checkInput = false;
      // alert("validePhone :" + checkInput);
   }
   if ($("select[name='departmentType']").val() == "") {
      $("#valideDepartmentType").css("display", "inline");
      checkInput = false;
      // alert("valideDepartmentType :" + checkInput);
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
   if (checkInput == true && checkMemberId == true) {
      if(checkMemberPassword == false) {
         return false;
      }
      else {
         return true;
      }
      
   } else {
      return false;
   }
}

function checkId() {
   $("#valideId").css("display", "none");
   if ($("input[name='modifyMemberId']").val() == "" || validateId.test($("input[name='modifyMemberId']").val()) == false) {
      $("#valideId").css("display", "inline");
      return false;
   }

   var memberId = $("input[name='modifyMemberId']").val();
   $.ajax({
      url : "/member/checkId",
      type : "post",
      cache : false,
      data : {
         "memberId" : $("input[name='modifyMemberId']").val()
      },
      dataType : "text",
      success : function(res) {
         console.log(res);
         // alert(res);
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
      cache : false,
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
   var rtval = false;
   $("#validePasswordCheck").css("display", "none");

   var password1 = $("input[name='password']").val();
   var password2 = $("input[name='passwordCheck']").val();

   if (password1 != "" && password2 != "") {

      if (password1 == password2) {
         $("#checkPasswordSuccess").css("display", "inline");
         $("#checkPasswordFail").css("display", "none");
         rtval = true;
      } else {
         $("#checkPasswordSuccess").css("display", "none");
         $("#checkPasswordFail").css("display", "inline");
         rtval = false;
      }

   }
   return rtval;

}

function modifyDepartMentType() {
   var departmentType = $("input[name='departmentId']").val();
   $("select[name='departmentType']").val(departmentType).attr("selected",
         "selected");

}

function modifyManagerType() {
   var managerType = $("input[name='managerType']").val();
   if (managerType == true) {
      $('input:radio[name="manager"][value="yes"]').prop('checked', true);
   } else {
      $('input:radio[name="manager"][value="no"]').prop('checked', true);
   }
}

function memberList() {
   // alert("list");
   // window.location.href = "/member/list";
   var memberId = $("input[name='modifyMemberId']").val();
   location.href = "read?memberId=" + memberId;
}