$(function() {
	$("#listManagement").click(function() {
		location.href = "list?management="+$("input[name='management']").val();
	})
	
	$("#insertManagementForm").submit(function() {
		if($("input[name='name']").val()=="") {
			alert("등록할 이름을 적어주세요.");
			return false;
		}
	})
})