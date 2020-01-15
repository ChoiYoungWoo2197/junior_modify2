$(function() {
	$("#listManagement").click(function() {
		location.href = "list?management="+$("input[name='management']").val();
	});
	
	$("#insertManagementForm").submit(function() {
		$("input[name='name']").next().addClass("display_none");
		
		if($("input[name='name']").val()=="") {
			$("input[name='name']").next().removeClass("display_none");
			return false;
		}
	});
})