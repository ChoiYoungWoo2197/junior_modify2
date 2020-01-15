$(function() {
	$("#listMeetingRoom").click(function() {
		location.href = "list";
	});
	
	$("#updateMeetingRoom").click(function() {
		var meetingRoomId = Number($("input[name=meetingRoomId]").val());
		location.href = "modify?meetingRoomId="+meetingRoomId;
	});
	
	$("#deleteMeetingRoom").click(function() {
		var result = confirm($("#meetingRoomName").text()+"회의실을 삭제하시겠습니까?");
		
		if(result == true) {
			var meetingRoomId = Number($("input[name=meetingRoomId]").val());
			location.href = "delete?meetingRoomId="+meetingRoomId;
		}
	});
})