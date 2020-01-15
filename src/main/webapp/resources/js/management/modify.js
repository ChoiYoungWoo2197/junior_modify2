$(function() {
	$("#listManagement").click(function() {
		location.href = "list?management="+$("input[name='management']").val();
	});
	
	$("#updateManagementForm").submit(function() {
		$("input[name='name']").next().addClass("display_none");
		
		var result = confirm("수정하시겠습니까?");
		
		if(result == false) {
			return false;
		} else {
			if($("input[name='name']").val()=="") {
				$("input[name='name']").next().removeClass("display_none");
				return false;
			}
		}
	});
})