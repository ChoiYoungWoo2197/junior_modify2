$(function() {
	displayCaldendar(new Date());
	
	$("#prevMonth").on("click", function() {
		prevMonth();
	})
	
	$("#nextMonth").on("click", function() {
		nextMonth();
	})

	$("#meetingRoomSelect").change(function() {
		$("td").removeClass("color_blue");
		//attr=> html attribute 취급 & prop=> javascript property취급
		//attr은 html attribute값이 모두 string으로 넘어오고 prop은 javascript property값이 넘어오기 때문에 boolean, date 등도 가져올 수 있음
		$("select[name='startHour'] option").eq(0).prop("selected",true);
		$("select[name='startMinute'] option").eq(0).prop("selected",true);
		$("select[name='endHour'] option").eq(0).prop("selected",true);
		$("select[name='endMinute'] option").eq(0).prop("selected",true);
		
		if($("select[name='meetingRoomId']").val() != "none") {
			var meetingRoomId = Number($("select[name='meetingRoomId']").val());
			
			$("#meetingRoomEquipment h5").empty();
			$("#meetingRoomEquipment ul").empty();
			$("#meetingRoomEquipment p").empty();
			$("#meetingRoomSeats h5").empty();
			$("#meetingRoomSeats span").empty();
			$("#reservationList ul").empty(); //회의실 변경 시 예약내역 리셋
			$("#reservationList p").empty(); //회의실 변경 시 예약내역 리셋
			$("select[name='meetAttendess']").find("option").each(function(){
				$(this).remove();
			})
			
			$.ajax({
				url : "/reservation/infoMeet?meetingRoomId="+meetingRoomId,
				type : "get",
				success : function(res) {
					console.log(res);
					
					$("#meetingRoomEquipment h5").text("지원장비");
					if(res.meetingRoomEquipmentList.length != 0) {
						$(res.meetingRoomEquipmentList).each(function(index, element) {
							var $equipmentLi = $("<li>").text(element.equipmentName);
							$("#meetingRoomEquipment ul").append($equipmentLi);
						})
					} else {
						$("#meetingRoomEquipment p").text("지원하는 장비가 없습니다.");
					}
					
					$("#meetingRoomSeats h5").text("좌석수");
					$("#meetingRoomSeats span").text(res.meetingRoom.seats + "석");
					
					for(var i=1; i<=res.meetingRoom.seats; i++) {
						var $meetingRoomSeatsOption = $("<option>").attr("value",i).text(i);
						$("select[name='meetAttendess']").append($meetingRoomSeatsOption);
					}
				}
			})
		}
	})
	
	/* var meetingStart = new Array(); //ajax로 받은 값을 담을 변수 지정
	var meetingEnd = new Array(); */
	var choiceDay;
	var date = new Date();
	var today = String(date.getFullYear())+String(('0'+(date.getMonth()+1)).slice(-2))+String(('0'+date.getDate()).slice(-2));
	
	$("#calendar").on("click", "td", function() {
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
			success : function(res) {
				console.log(res);
				if(res.length == 0) {
					$("#reservationList p").text("예약 내역이 존재하지 않습니다.");	
				}else {
					$(res).each(function(index, element) {
						var startDateOrigin = new Date(element.startDate);
						var startDate = startDateOrigin.getHours()+":"+("00" + startDateOrigin.getMinutes()).slice(-2);
						var endDateOrigin = new Date(element.endDate);
						var endDate = endDateOrigin.getHours()+":"+("00" + endDateOrigin.getMinutes()).slice(-2);
						
						if(element.extendEndDate != null) {
							var extendDateOrigin = new Date(element.extendEndDate);
							endDate = extendDateOrigin.getHours()+":"+("00" + extendDateOrigin.getMinutes()).slice(-2);
						}
						
						var $reservationLi = $("<li>").html(startDate + "~" + endDate + "&ensp;" + element.meetPurpose +"<br>(" + element.employeeName + "("+ element.departmentName + "))" );
						$("#reservationList ul").append($reservationLi);
						
						/* meetingStart[index] = startDate;
						meetingEnd[index] = endDate; */
					})
				}
			}
		})
	})
	
	var currentDate = today+String(("00" + date.getHours()).slice(-2))+String(("00" + date.getMinutes()).slice(-2));
	
	$("#insertReservationForm").submit(function() {
		if($("select[name='meetingRoomId']").val() == "0") {
			alert("회의실을 선택하세요.");
			return false;
		}
		
		if($("input[name='meetPurpose']").val() == "") {
			alert("회의목적을 입력하세요.");
			return false;
		}
		
		var start = Number($("select[name='startHour']").val() + $("select[name='startMinute']").val());
		var end = Number($("select[name='endHour']").val() + $("select[name='endMinute']").val());
		if(start >= end) {
			alert("시간을 잘못 입력하셨습니다.");
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
		
		if(currentDate >= startDate2 || currentDate >= endDate2) {
			alert("지난 시간은 예약할 수 없습니다.");
			$("select[name='startHour']").focus();
			return false;
		}
		
		$("input[name='start']").val(startDate);
		$("input[name='end']").val(endDate);
		$("input[name='choiceDay']").val(choiceDay);
		
		/* for(var i=0; i<meetingStart.length; i++) {
			if(Number(meetingStart[i].replace(":","")) <= start && start <= Number(meetingEnd[i].replace(":",""))) {
				alert("이미 예약된 건이 있습니다. 다른 시간을 선택해주세요.1");
				$("select[name='startHour']").focus();
				return false;
			}
			if(Number(meetingStart[i].replace(":","")) <= end && end <= Number(meetingEnd[i].replace(":",""))) {
				alert("이미 예약된 건이 있습니다. 다른 시간을 선택해주세요.2");
				$("select[name='endHour']").focus();
				return false;
			}
		} */
		
		var result = true;
		$.ajax({
			url : "/reservation/checkTime?choiceDay="+choiceDay+"&start="+startDate+"&end="+endDate
				+"&meetingRoomId="+$("select[name='meetingRoomId']").val()+"&insertEmployee="+$("input[name='employeeId']").val(),
			type : "get",
			async : false,
			success : function(res) {
				console.log(res);
				
				if(res == "false") {
					result = false;
					alert("이미 예약된 건이 있습니다. 다른 시간을 선택해주세요.");
				} else if(res == "true") {
					result = true;
				} else {
					result = false;
					alert("해당시간에 '"+ res + "'에 예약한 내역이 있습니다.");
				}
			}
		})
		return result;
	})
	
	$("#listReservation").click(function() {
		location.href = "list";
	})
})