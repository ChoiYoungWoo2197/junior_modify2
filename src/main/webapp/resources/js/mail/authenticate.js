	$(function() {
		$("#sendReMail").click(function() {
				
			$("input[name='authKey']").val("");
			$.ajax({
				url : "/mail/request",
				type : "post",
				cache: false,
				data : {"mail" : $("input[name='mail']").val()},
				dataType : "text",
				async: false, //비동기를 동기형식으로 변경
				success : function(res) {
					console.log(res);
					if(res == "true") {
						alert("이메일이 재발송되었습니다. 인증번호를 입력해주세요.");
					}
					else {
						alert("이메일발송이 실패했습니다. 2분뒤에 다시 발송해 주세요.");
					}
				}
			})
			//이메일 재발송 클릭시 비활성가 되어있다면 메일전송후 활성화로 바꿔준다.
			$('#sendReMail').attr('disabled',false);  //버튼 활성화
			
		})
		
		$("#cancel").click(function() {
			if(confirm("이메일 인증을 취소하시겠습니까?") == true) {
				window.location.href = '/reservation/list';
			}
			
		})
		
	})