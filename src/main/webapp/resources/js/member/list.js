$(function() {
	$("#insertMember").click(function() {
		location.href = "/member/insert";
	})

	$("#searchMember").click(function() {
		if ($("input[name='searchContent']").val() == "") {
			alert("검색할 내용을 입력해주세요.");
			return false;
		}

		location.href = encodeURI("list?page=1&searchType="
				+ $("select[name='searchType']").val()
				+ "&searchContent="
				+ $("input[name='searchContent']").val());
	})
	
	$(".readMember").click(function() {
		var memberId = $(this).find(".readMemberId").attr("data-memberId");
		location.href = "read?memberId=" + memberId;
	})

	$("#allMember").click(function() {
		location.href = "list";
	})

})
