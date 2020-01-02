<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<style>
	.width30 {
		width: 30%;
	}
	section ul li {
		list-style: disc;
	}
	td, th {
		border: 1px solid black;
	}
	.color_blue {
		color: blue;
		font-weight: bold;
	}
	.color_red {
		color: red;
		font-size: 14px;
	}
</style>

<script>
	$(function() {
		displayCaldendar();
		
		$("#prevMonth").on("click", function() {
			prevMonth();
		})
		
		$("#nextMonth").on("click", function() {
			nextMonth();
		})
		
		$("#meetingRoomSelect").change(function() {
			$("td").removeClass("color_blue");
			if($("select[name='meetingRoomId']").val() != "none") {
				var meetingRoomId = Number($("select[name='meetingRoomId']").val());
				
				$("#meetingRoomEquipment").empty();
				$("#meetingRoomSeats").empty();
				
				$.ajax({
					url : "/reservation/infoMeet?meetingRoomId="+meetingRoomId,
					type : "get",
					success : function(res) {
						console.log(res);
						
						if(res.meetingRoomEquipmentList.length != 0) {
							var $equipmentLabel = $("<h5>").text("지원장비");
							var $equipmentUl = $("<ul>");
							
							$(res.meetingRoomEquipmentList).each(function(index, element) {
								var $equipmentLi = $("<li>").text(element.equipmentName);
								$equipmentUl.append($equipmentLi);
							})
							
							$("#meetingRoomEquipment").append($equipmentLabel).append($equipmentUl);
						} else {
							var $equipmentLabel = $("<h5>").text("지원장비");
							var $equipment = $("<div>").text("지원하는 장비가 없습니다.");
							
							$("#meetingRoomEquipment").append($equipmentLabel).append($equipment);
						}
						
						
						var $seatLabel = $("<h5>").text("좌석수");
						var $seats = $("<span id='meetingRoomSeats'>").text(res.meetingRoom.seats + "석");
						$("#meetingRoomSeats").append($seatLabel).append($seats);
					}
				})
			}
		})
		
		$("#calendar").on("click", "td", function() {
			$("td").removeClass("color_blue");
			
			var meetingRoomId = Number($("select[name='meetingRoomId']").val());
			
			var date = new Date();
			var today = String(date.getFullYear())+String(('0'+(date.getMonth()+1)).slice(-2))+String(('0'+date.getDate()).slice(-2));
			if(Number($(this).text()) < 10) {
				var choiceDay = $("#today").text().replace(".","")+'0'+$(this).text();
			} else {
				var choiceDay = $("#today").text().replace(".","")+$(this).text();
			}
			
			if(Number(today) > Number(choiceDay)) {
				alert("지난 날짜를 선택하실 수 없습니다.");
				return false;
			}
			$(this).addClass("color_blue");
			
			$.ajax({
				url : "/reservation/infoReserve?meetingRoomId="+meetingRoomId+"&choiceDay="+choiceDay,
				type : "get",
				success : function(res) {
					console.log(res);
					
					if(res.length == 0) {
						$("#reservationList").text("예약 내역이 존재하지 않습니다.");	
					}else {
						var $reservationUl = $("<ul>");
						$(res).each(function(index, element) {
							var startDateOrigin = new Date(element.startDate);
							var startDate = startDateOrigin.getHours()+":"+("00" + startDateOrigin.getMinutes()).slice(-2);
							var endDateOrigin = new Date(element.endDate);
							var endDate = endDateOrigin.getHours()+":"+("00" + endDateOrigin.getMinutes()).slice(-2);
							
							var $reservationLi = $("<li>").html(startDate + "~" + endDate + "&ensp;" + element.meetPurpose +"<br>(" + element.employeeName + "("+ element.departmentName + "))" );
							$reservationUl.append($reservationLi);
						})
							$("#reservationList").append($reservationUl);
					}
				}
			})
		})
		
		$("#insertReservationForm").submit(function() {
			if($("select[name='meetingRoomId']").val() == "none") {
				alert("회의실을 입력하세요.");
				return false;
			}
			
			if($("input[name='meetPurpose']").val() == "") {
				alert("회의목적을 입력하세요.");
				return false;
			}
			
			var startDate = $("select[name='startHour']").val() + $("select[name='startMinute']").val();
			var endDate = $("select[name='endHour']").val() + $("select[name='endMinute']").val();
			if(startDate >= endDate) {
				alert("시간을 잘못 입력하셨습니다.");
				return false;
			}
		})
		
	})
</script>	
	
	<section class="width1200">
		<form id="insertReservationForm" method="post" action="/reservation/insert">
			<div class="color_red">* 필수입력</div>
			<div class="width30 float_left">
				<h4>1.회의실선택</h4>
				<label>회의실 <span class="color_red">*</span></label> <br>
				<select id="meetingRoomSelect" name="meetingRoomId">
					<option value="none">회의실 선택</option>
					<c:forEach var="meetingRoom" items="${meetingRoomList}">
						<option value="${meetingRoom.meetingRoomId}">${meetingRoom.name}</option>
					</c:forEach>
				</select>
				<div id="meetingRoomEquipment"></div>
				<div id="meetingRoomSeats"></div>
			</div>
			<div class="width30 float_left">
				<h4>2.회의일시</h4>
				<div>
					<div>
		        		<span id="prevMonth">&lt; </span><b id="today"></b><span id="nextMonth"> &gt;</span>
						<div id="calendar"></div>
					</div>
					<div id="reservationList"></div>
				</div>
				<div>
					<label>시작시간 <span class="color_red">*</span> : </label>
					<select name="startHour">
						<c:forEach var="hour" begin="9" end="22">
							<option>${hour}</option>
						</c:forEach>
					</select>시
					<select name="startMinute">
						<c:forEach var="minute" begin="0" end="59">
							<option>${minute}</option>
						</c:forEach>
					</select>분
					<br>
					<label>종료시간 <span class="color_red">*</span> : </label>
					<select name="endHour">
						<c:forEach var="hour" begin="9" end="22">
							<option>${hour}</option>
						</c:forEach>
					</select>시
					<select name="endMinute">
						<c:forEach var="minute" begin="0" end="59">
							<option>${minute}</option>
						</c:forEach>
					</select>분
				</div>
			</div>
			<div class="width30 float_left">
				<h4>3.회의정보</h4>
				<div>
					<label>회의목적 <span class="color_red">*</span></label> <br>
					<input type="text" placeholder="회의목적(주제)를 입력해주세요." name="meetPurpose">
				</div>
				<div>
					<label>회의참석자 <span class="color_red">*</span></label> <br>
					<select name="meetAttendess">
						<c:forEach var="index" begin="1" end="1">
							<option>${index}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<input type="submit" value="예약등록">
		</form>
	</section>
</body>
</html>