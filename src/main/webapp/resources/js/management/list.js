$(function() {
	$("#insertManagement").click(function() {
		location.href = "insert?management="+$("input[name=management]").val();
	});
	
	$("table tr").each(function() {
		$(".deleteManagement").on('click',function(e){
			e.stopImmediatePropagation(); //삭제버튼에서는 updateManagement클래스가 적용안되게 막음.
			var result = confirm("삭제하시겠습니까?");
			var managementId = Number($(this).attr("data-managementId"));
			var deleteAvailable = true;
			
			if(result == true) {
				if($("input[name=management]").val() == "department") {
					$.ajax({
						url : "/management/countEmp?managementId="+managementId,
						type : "get",
						dataType : "text",
						async: false,
						/*
						ajax는 비동기식이기 때문에 다른 호출을 먼저 할 수도 있다(ajax가 완료된것을 기다려주지 않음).
						비동기식인 ajax를 동기식으로 설정해줘야 함 => async: false
						*/
						success : function(res) {
							console.log(res);
							if(res == "false") {
								alert("소속된 사원이 존재하여 삭제할 수 없습니다.");
								deleteAvailable = false;
							}
						}
					})
				}
				
				if(deleteAvailable) {
					$("input[name='managementId']").val(managementId);
					$("#deleteForm").attr("action", "delete").attr("method", "post");
					$("#deleteForm").submit();
				}
			}
			
		})
	});
	
	//$(document).on("click", ".updateManagement", function(){
	$(".updateManagement").click(function() {
		var managementId = Number($(this).find(".readManagement").attr("data-managementId"));
		
		var result = confirm("수정하시겠습니까?");
		
		if(result == true) { 
			location.href = "modify?management="+$("input[name=management]").val()+"&managementId="+managementId;
		}
		
	});
	
	$("#searchManagement").click(function() {
		if($("input[name='searchContent']").val()=="") {
			alert("검색할 내용을 입력해주세요.");
			return false;
		}
		
		location.href = encodeURI("list?management="+$("input[name=management]").val()+"&page=1&searchContent="+$("input[name='searchContent']").val());
	});
	
	$("#AllManagement").click(function() {
		location.href = "list?management="+$("input[name=management]").val();
	});
})