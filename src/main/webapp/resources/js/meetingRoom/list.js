$(function() {
	$("#insertMeetingRoom").click(function() {
		location.href = "insert";
	})

	$("#updateMeetingRoom").click(function() {
		var meetingRoomId = Number($(this).find(".readMeetingRoom").attr("data-meetingRoomId"));
		
		location.href = "read?meetingRoomId="+meetingRoomId;
	})
	
	$("#searchMeetingRoom").click(function() {
		if($("input[name='searchContent']").val()=="") {
			alert("검색할 내용을 입력해주세요.");
			return false;
		}
		
		//alert($("input[name='searchContent']").val());
		/*location.href = "list?page=1&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val();*/
		location.href = encodeURI("list?page=1&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
	})
	
	$("#allMeetingRoom").click(function() {
		location.href = "list";
	})
})