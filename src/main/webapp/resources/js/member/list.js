$(function() {
	$("#insertMember").click(function() {
		//alert("?");
		//location.href = "${pageContext.request.contextPath}/member/insert";
	})

	$("#searchEquipment").click(function() {
		//alert("???");
		if ($("input[name='searchContent']").val() == "") {
			alert("검색할 내용을 입력해주세요.");
			return false;
		}

		location.href = "list?page=1&searchType=" + $("select[name='searchType']").val()+ "&searchContent="+ $("input[name='searchContent']").val();
	})

	$(document).on("click", ".readMember", function() {
		alert("???");
		var memberId = Number($(this).prev().text());
		
		//var memberId = $(this).prev().text();
		alert(memberId);
		location.href = "read?memberId=" + memberId;
	})

	$("#AllMeetingRoom").click(function() {
		location.href = "list";
	})

})
