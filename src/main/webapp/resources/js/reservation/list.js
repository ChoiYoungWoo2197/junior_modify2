$(function() {
	$("#insertReservation").click(function() {
		location.href = "insert";
	})
	
	$(document).on("click", ".updateReservation", function(){
		var reservationId = Number($(this).find(".readReservation").attr("data-reservationId"));
		location.href = "/reservationDetail/read?reservationId="+ reservationId;
	})
	
	$("#searchReservation").click(function() {
		//기간별로 검색할 경우
		if($("#searchStart").val()!="" || $("#searchEnd").val()!="") {
			if($("#searchStart").val() > $("#searchEnd").val()!="") {
				alert("기간을 잘못 선택하셨습니다.");
				return false;
			}
			
			//기간별 & 상태로 검색하는 경우
			if($("select[name='state']").val()!="none") {
				location.href="list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
						+"&state="+$("select[name='state']").val();
				//기간별 & 상태 & 회의실로 검색하는 경우
				if($("select[name='meetingRoomId']").val()!="0") {
					location.href="list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
							+"&state="+$("select[name='state']").val()+"&meetingRoomId="+$("select[name='meetingRoomId']").val();
					
					//기간별 & 상태 & 회의실 & input내용으로 검색하는 경우
					if($("input[name='searchContent']").val()!="") {
						location.href=encodeURI("list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
								+"&state="+$("select[name='state']").val()+"&meetingRoomId="+$("select[name='meetingRoomId']").val()
								+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
						return false;
					}
					return false;
				}
				
				//기간별 & 상태 & input내용으로 검색하는 경우
				if($("input[name='searchContent']").val()!="") {
					location.href=encodeURI("list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
							+"&state="+$("select[name='state']").val()+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
					return false;
				}
				return false;
			}
			
			//기간별 & 회의실로 검색하는 경우
			if($("select[name='meetingRoomId']").val()!="0") {
				location.href="list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
						+"&meetingRoomId="+$("select[name='meetingRoomId']").val();
				
				//기간별 & 회의실 & input내용으로 검색하는 경우
				if($("input[name='searchContent']").val()!="") {
					location.href=encodeURI("list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
					+"&meetingRoomId="+$("select[name='meetingRoomId']").val()+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
					return false;
				}
				return false;
			}
			
			//기간별 & input내용으로 검색하는 경우
			if($("input[name='searchContent']").val()!="") {
				location.href=encodeURI("list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val()
						+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
				return false;
			}
			
			location.href="list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val();
			return false;
		}
		
		//상태로 검색할 경우
		if($("select[name='state']").val()!="none") {
			//상태 & 회의실로 검색하는 경우
			if($("select[name='meetingRoomId']").val()!="0") {
				location.href = "list?page=1&state="+$("select[name='state']").val()+"&meetingRoomId="+$("select[name='meetingRoomId']").val();
				
				//상태 & 회의실 & input내용으로 검색하는 경우
				if($("input[name='searchContent']").val()!="") {
					location.href = encodeURI("list?page=1&state="+$("select[name='state']").val()+"&meetingRoomId="+$("select[name='meetingRoomId']").val()
							+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
					return false;
				}
				return false;
			}
			
			//상태 & input내용으로 검색하는 경우
			if($("input[name='searchContent']").val()!="") {
				location.href = encodeURI("list?page=1&state="+$("select[name='state']").val()
						+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
				return false;
			}
			location.href = "list?page=1&state="+$("select[name='state']").val();
			return false;
		}
		
		//회의실로 검색할 경우
		if($("select[name='meetingRoomId']").val()!="0") {
			location.href = "list?page=1&meetingRoomId="+$("select[name='meetingRoomId']").val();
			
			//회의실 & input내용으로 검색하는 경우
			if($("input[name='searchContent']").val()!="") {
				location.href = encodeURI("list?page=1&meetingRoomId="+$("select[name='meetingRoomId']").val()
						+"&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
				return false;
			}
			return false;
		}
		
		if($("input[name='searchContent']").val()=="" && $("select[name='state']").val()=="none") {
			alert("검색할 내용을 입력해주세요.");
			return false;
		}
		
		location.href = encodeURI("list?page=1&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val());
	})
	
	$("#allReservation").click(function() {
		location.href = "list";
	})
})