$(function() {
	displayCaldendar(new Date());
	
	$("#prevMonth").on("click", function() {
		prevMonth();
	});
	
	$("#nextMonth").on("click", function() {
		nextMonth();
	});

	$("#reservationList").hide();
	
	$("#meetingRoomSelect").change(function() {
		$("#reservationList").hide();
		$("td").removeClass("color_blue");
		//attr=> html attribute 취급 & prop=> javascript property취급
		//attr은 html attribute값이 모두 string으로 넘어오고 prop은 javascript property값이 넘어오기 때문에 boolean, date 등도 가져올 수 있음
		$("select[name='startHour'] option").eq(0).prop("selected",true);
		$("select[name='startMinute'] option").eq(0).prop("selected",true);
		$("select[name='endHour'] option").eq(0).prop("selected",true);
		$("select[name='endMinute'] option").eq(0).prop("selected",true);
		$("input[name='meetPurpose']").val("");
		$("select[name='meetAttendess']").find("option").each(function(){
			if($(this).val() != 0) {
				$(this).remove();
			}
		})
		
		if($("select[name='meetingRoomId']").val() != "none") {
			var meetingRoomId = Number($("select[name='meetingRoomId']").val());
			
			$("#meetingRoomEquipment h4").empty();
			$("#meetingRoomEquipment ul").empty();
			$("#meetingRoomEquipment p").empty();
			$("#meetingRoomSeats h4").empty();
			$("#meetingRoomSeats span").empty();
			$("#reservationList ul").empty(); //회의실 변경 시 예약내역 리셋
			$("#reservationList p").empty(); //회의실 변경 시 예약내역 리셋
			
			if(meetingRoomId != 0) {
				$.ajax({
					url : "/reservation/infoMeet?meetingRoomId="+meetingRoomId,
					type : "get",
					cache : false,
					success : function(res) {
						console.log(res);
						
						$("#meetingRoomEquipment h4").text("지원장비");
						if(res.meetingRoomEquipmentList.length != 0) {
							$(res.meetingRoomEquipmentList).each(function(index, element) {
								var $equipmentLi = $("<li>").text(element.equipmentName);
								$("#meetingRoomEquipment ul").append($equipmentLi);
							})
						} else {
							$("#meetingRoomEquipment p").text("지원하는 장비가 없습니다.");
						}
						
						$("#meetingRoomSeats h4").text("좌석수");
						$("#meetingRoomSeats span").text(res.meetingRoom.seats + "석");
						
						for(var i=1; i<=res.meetingRoom.seats; i++) {
							var $meetingRoomSeatsOption = $("<option>").attr("value",i).text(i);
							$("select[name='meetAttendess']").append($meetingRoomSeatsOption);
						}
					}
				})
			}
		}
	});
	
	var choiceDay;
	var date = new Date();
	var today = String(date.getFullYear())+String(('0'+(date.getMonth()+1)).slice(-2))+String(('0'+date.getDate()).slice(-2));
	
	$("#calendar").on("click", "td", function(e) {
		$("td").removeClass("color_blue");
		$("#reservationList ul").empty();
		$("#reservationList p").empty();
		
		var meetingRoomId = Number($("select[name='meetingRoomId']").val());
		
		if(Number($(this).text()) < 10) {
			choiceDay = $("#today").text().replace(".","")+'0'+$(this).text();
		} else {
			choiceDay = $("#today").text().replace(".","")+$(this).text();
		}
		
		if(Number(today) > Number(choiceDay)) {
			alert("지난 날짜를 선택하실 수 없습니다.");
			return false;
		}
		$(this).addClass("color_blue");
		
		$.ajax({
			url : "/reservation/infoReserve?meetingRoomId="+meetingRoomId+"&choiceDay="+choiceDay,
			type : "get",
			//async : false,
			cache : false, //IE의 경우 ajax로 호출하는 URL이 동일하고 파라미터가 없거나 할 경우 매번 URL을 호출하지 않고 Cache를 이용해서 이상한 값을 보내줌(서버에 요청을 안함). 이 옵션은 false로 하면 IE 에러 사라짐.
			success : function(res) {
				$("#reservationList").show();
				
				console.log(res);
				if(res.length == 0) {
					$("#reservationList p").text("예약 내역이 존재하지 않습니다.");	
				}else {
					$(res).each(function(index, element) {
						var startDateOrigin = new Date(element.startDate);
						var startDate = startDateOrigin.getHours()+":"+("00" + startDateOrigin.getMinutes()).slice(-2);
						var endDateOrigin = new Date(element.actualEndDate);
						var endDate = endDateOrigin.getHours()+":"+("00" + endDateOrigin.getMinutes()).slice(-2);
						
						console.log(element.startDate);
						console.log(element.actualEndDate);
						
						var $reservationLi = $("<li>").html("<span>"+ element.startDate + "</span><span>&ensp;~&ensp;</span><span>" + element.actualEndDate + "</span>&ensp;<span class='overflow_ellipsis'>&ensp;&ensp;" + element.meetPurpose +"</span><br>(" + element.employeeName + "("+ element.departmentName + "))" );
						$("#reservationList ul").append($reservationLi);
					})
				}
			}
		})
	});
	
	var currentDate = today+String(("00" + date.getHours()).slice(-2))+String(("00" + date.getMinutes()).slice(-2));
	
	$("#insertReservationForm").submit(function() {
		if($("select[name='meetingRoomId']").val() == "0") {
			alert("회의실을 선택하세요.");
			return false;
		}
		
		var start = Number($("select[name='startHour']").val() + $("select[name='startMinute']").val());
		var end = Number($("select[name='endHour']").val() + $("select[name='endMinute']").val());
		if(start >= end) {
			alert("시간을 잘못 입력하셨습니다.");
			return false;
		}
		
		if($("input[name='meetPurpose']").val() == "") {
			alert("회의목적을 입력하세요.");
			return false;
		}
		
		if($("select[name='meetAttendess']").val() == "0") {
			alert("참가 인원수를 선택하세요.");
			return false;
		}
		
		var date;
		for(var i=0; i<$("#calendar td").length; i++) {
			if($("#calendar td").eq(i).hasClass("color_blue") == true) {
				date = $("#calendar td").eq(i).attr("data-value");
			}
		}
		
		var startDate = $("#today").text().replace(".","-")+"-"+date+" "+$("select[name='startHour']").val()+":"+$("select[name='startMinute']").val();
		var endDate = $("#today").text().replace(".","-")+"-"+date+" "+$("select[name='endHour']").val()+":"+$("select[name='endMinute']").val();
		var startDate2 = $("#today").text().replace(".","")+date+$("select[name='startHour']").val()+$("select[name='startMinute']").val();
		var endDate2 = $("#today").text().replace(".","")+date+$("select[name='endHour']").val()+$("select[name='endMinute']").val();
		
		if(currentDate > startDate2 || currentDate > endDate2) {
			alert("지난 시간은 예약할 수 없습니다.");
			$("select[name='startHour']").focus();
			return false;
		}
		
		$("input[name='start']").val(startDate);
		$("input[name='end']").val(endDate);
		$("input[name='choiceDay']").val(choiceDay);
		
		var result = true;
		$.ajax({
			url : "/reservation/checkTime?choiceDay="+choiceDay+"&start="+startDate+"&end="+endDate
				+"&meetingRoomId="+$("select[name='meetingRoomId']").val()+"&employeeId="+$("input[name='employeeId']").val(),
			type : "get",
			async : false,
			cache : false,
			success : function(res) {
				console.log(res.result);

				if(res.result == "false") {
					if(res.meetingRoom == "none") {
						alert("이미 예약된 내역이 있습니다. 다른 시간을 선택해주세요.");
						result = false;
					} else {
						alert("동일한 시간에 '"+res.meetingRoom+"' 예약 내역이 있습니다.");
						result = false;
					}
				} else {
					result = true;
				}
			}
		})
		return result;
	});
	
	$("#listReservation").click(function() {
		location.href = "list";
	});
})