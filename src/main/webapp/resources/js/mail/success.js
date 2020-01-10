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