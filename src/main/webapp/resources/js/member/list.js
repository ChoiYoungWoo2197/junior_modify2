$(function() {
	$("#insertMember").click(function() {
		location.href = "/member/insert";
	})

	$("#searchEquipment").click(function() {
		if ($("input[name='searchContent']").val() == "") {
			alert("검색할 내용을 입력해주세요.");
			return false;
		}

		location.href = encodeURI("list?page=1&searchType="
				+ $("select[name='searchType']").val()
				+ "&searchContent="
				+ $("input[name='searchContent']").val());
	})

	$(document).on("click", ".readMember", function() {
		// var memberId = Number($(this).prev().text());
		// var memberId = $(this).prev().text();
		// location.href = "read?memberId=" + memberId;

		var memberId = $(this).find(".readMemberId").attr("data-memberId");
		location.href = "read?memberId=" + memberId;
	})

	$("#AllMeetingRoom").click(function() {
		location.href = "list";
	})

})
