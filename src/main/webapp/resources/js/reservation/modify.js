$(function() {
	displayCaldendar($("#reservationDate").text());
	
	$("#prevMonth").on("click", function() {
		prevMonth();
	})
	
	$("#nextMonth").on("click", function() {
		nextMonth();
	})

	var choiceDay;
	var choiceDay2;
	$("#today").text($("#reservationDate").text().substring(0,$("#reservationDate").text().length-3).replace("-","."));
	for(var i=0; i<$("#calendar td").length; i++) {
		if($("#calendar td").eq(i).attr("data-value") == $("#reservationDate").text().substring($("#reservationDate").text().length-2,$("#reservationDate").text().length)) {
			$("#calendar td").eq(i).addClass("color_blue");
			choiceDay2 = $("#calendar td").eq(i).attr("data-value");
		}
	}
	choiceDay = $("#today").text().replace(".","")+choiceDay2; //수정했을 때 달력 선택 안해도 값이 저장될 수 있도록
	
	$("#meetingRoomSelect").change(function() {
		if($("select[name='meetingRoomId']").val() != "none") {
			var meetingRoomId = Number($("select[name='meetingRoomId']").val());
			
			$("#meetingRoomEquipment h4").empty();
			$("#meetingRoomEquipment ul").empty();
			$("#meetingRoomEquipment p").empty();
			$("#meetingRoomSeats h4").empty();
			$("#meetingRoomSeats span").empty();
			$("#reservationList ul").empty(); //회의실 변경 시 예약내역 리셋
			$("#reservationList p").empty(); //회의실 변경 시 예약내역 리셋
			$("select[name='meetAttendess']").find("option").each(function(){
				$(this).remove();
			})
			
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
						var $meetingRoomSeatsOption;
						if($("input[name='seats").val() == i) {
							$meetingRoomSeatsOption = $("<option selected>").attr("value",i).text(i);
						} else {
							$meetingRoomSeatsOption = $("<option>").attr("value",i).text(i);
						}
						$("select[name='meetAttendess']").append($meetingRoomSeatsOption);
					}
				}
			})
			
			$.ajax({
				url : "/reservation/infoReserve?meetingRoomId="+meetingRoomId+"&choiceDay="+choiceDay,
				type : "get",
				cache : false,
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
							
							var $reservationLi = $("<li>").html(startDate + "~" + endDate + "&ensp;" + element.meetPurpose +"<br>(" + element.employeeName + "("+ element.departmentName + "))" );
							$("#reservationList ul").append($reservationLi);
						})
					}
				}
			})
		}
	})
	
	var date = new Date();
	var today = String(date.getFullYear())+String(('0'+(date.getMonth()+1)).slice(-2))+String(('0'+date.getDate()).slice(-2));
	
	$("#calendar").on("click", "td", function() {
		$("td").removeClass("color_blue");
		$("#reservationList ul").empty();
		$("#reservationList p").empty();
		
		var meetingRoomId = Number($("select[name='meetingRoomId']").val());
		
		if(Number($(this).text()) < 10) {
			choiceDay = $("#today").text().replace(".","")+$(this).attr("data-value");
		} else {
			choiceDay = $("#today").text().replace(".","")+$(this).attr("data-value");
		}
		
		if(Number(today) > Number(choiceDay)) {
			alert("지난 날짜를 선택하실 수 없습니다.");
			return false;
		}
		$(this).addClass("color_blue");
		
		$.ajax({
			url : "/reservation/infoReserve?meetingRoomId="+meetingRoomId+"&choiceDay="+choiceDay,
			type : "get",
			cache : false,
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
						
						var $reservationLi = $("<li>").html(startDate + "~" + endDate + "&ensp;" + element.meetPurpose +"<br>(" + element.employeeName + "("+ element.departmentName + "))" );
						$("#reservationList ul").append($reservationLi);
					})
				}
			}
		})
	})
	
	var currentDate = today+String(("00" + date.getHours()).slice(-2))+String(("00" + date.getMinutes()).slice(-2));
	
	$("#updateReservationForm").submit(function() {
		var confirmResult = confirm("수정하시겠습니까?");
		
		if(confirmResult == false) {
			return false;
		}
		
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
		
		var result = true;
		$.ajax({
			url : "/reservation/checkTime?choiceDay="+choiceDay+"&start="+startDate+"&end="+endDate
					+"&meetingRoomId="+$("select[name='meetingRoomId']").val()+"&reservationId="+$("input[name='reservationId']").val(),
			type : "get",
			async : false,
			cache : false,
			success : function(res) {
				console.log(res);
				
				if(res == "false") {
					result = false;
					alert("이미 예약된 건이 있습니다. 다른 시간을 선택해주세요.");
				} else {
					result = true;
				}
			}
		})
		return result;
	})
	
	$("#readReservation").click(function() {
		location.href="/reservationDetail/read?reservationId="+$("input[name='reservationId']").val();
	})
})