$(function() {
	$("#list").click(function() {
		location.href = "list";
	})

	$("#update").click(function() {
		//var memberId = Number($("input[name=memberId]").val());
		//alert( $("input[name=memberId]").val());
		var memberId = $("input[name=memberId]").val();
		location.href = "modify?memberId="+memberId;
	})

	$("#delete").click(function() {
		var result = confirm($("#name").text()+"님을 삭제하시겠습니까?");

		if(result == true) {
			//var memberId = Number($("input[name=memberId]").val());
			var memberId = $("input[name=memberId]").val();
			location.href = "delete?memberId="+memberId;
		}
	})
})