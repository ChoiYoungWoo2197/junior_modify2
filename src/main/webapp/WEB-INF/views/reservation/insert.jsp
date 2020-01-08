<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservation/insert.js"></script>
<!-- <script>
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
							if(element.state == "R" || element.state == "RC") {
								var startDateOrigin = new Date(element.startDate);
								var startDate = startDateOrigin.getHours()+":"+("00" + startDateOrigin.getMinutes()).slice(-2);
								var endDateOrigin = new Date(element.endDate);
								var endDate = endDateOrigin.getHours()+":"+("00" + endDateOrigin.getMinutes()).slice(-2);
								
								var $reservationLi = $("<li>").html(startDate + "~" + endDate + "&ensp;" + element.meetPurpose +"<br>(" + element.employeeName + "("+ element.departmentName + "))" );
								$("#reservationList ul").append($reservationLi);
								
								/* meetingStart[index] = startDate;
								meetingEnd[index] = endDate; */
							}
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
				url : "/reservation/checkTime?choiceDay="+choiceDay+"&start="+startDate+"&end="+endDate+"&meetingRoomId="+$("select[name='meetingRoomId']").val(),
				type : "get",
				async : false,
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
	})
</script>	 -->
	
	<section class="width1200">
		<form id="insertReservationForm" method="post" action="/reservation/insert">
			<div class="color_red">* 필수입력</div>
			<div class="width30 float_left">
				<h4>1.회의실선택</h4>
				<label>회의실 <span class="color_red">*</span></label> <br>
				<select id="meetingRoomSelect" name="meetingRoomId">
					<option value="0">회의실 선택</option>
					<c:forEach var="meetingRoom" items="${meetingRoomList}">
						<c:if test="${meetingRoom.availability eq 'true'}">
							<option value="${meetingRoom.meetingRoomId}">${meetingRoom.name}</option>
						</c:if>
						<c:if test="${meetingRoom.availability eq 'false'}">
							<option value="${meetingRoom.meetingRoomId}" disabled="disabled">${meetingRoom.name}(사용불가)</option>
						</c:if>
					</c:forEach>
				</select>
				<div id="meetingRoomEquipment">
					<h5></h5> <!-- 지원장비라벨 -->
					<ul></ul> <!-- 회의실 지원장비 리스트 -->
					<p></p> <!-- 지원장비 없는 회의실 -->
				</div>
				<div id="meetingRoomSeats">
					<h5></h5> <!-- 좌석수라벨 -->
					<span></span> <!-- 좌석수 정보 -->
				</div>
			</div>
			<div class="width30 float_left">
				<h4>2.회의일시</h4>
				<div>
					<div>
		        		<span id="prevMonth">&lt; </span><b id="today"></b><span id="nextMonth"> &gt;</span>
						<div id="calendar"></div>
					</div>
					<div id="reservationList">
						<ul></ul> <!-- 해당 날짜 및 회의실에 포함된 예약 리스트 -->
						<p></p> <!-- 예약내역 없는 경우 -->
					</div>
				</div>
				<div>
					<label>시작시간 <span class="color_red">*</span> : </label>
					<select name="startHour">
						<c:forEach var="hour" begin="9" end="22">
							<c:if test="${hour < 10}">
								<option value="0${hour}">0${hour}</option>
							</c:if>
							<c:if test="${hour >= 10}">
								<option value="${hour}">${hour}</option>
							</c:if>
						</c:forEach>
					</select>시
					<select name="startMinute">
						<c:forEach var="minute" begin="0" end="59">
							<c:if test="${minute < 10}">
								<option value="0${minute}">0${minute}</option>
							</c:if>
							<c:if test="${minute >= 10}">
								<option value="${minute}">${minute}</option>
							</c:if>
						</c:forEach>
					</select>분
					<br>
					<label>종료시간 <span class="color_red">*</span> : </label>
					<select name="endHour">
						<c:forEach var="hour" begin="9" end="22">
							<c:if test="${hour < 10}">
								<option value="0${hour}">0${hour}</option>
							</c:if>
							<c:if test="${hour >= 10}">
								<option value="${hour}">${hour}</option>
							</c:if>
						</c:forEach>
					</select>시
					<select name="endMinute">
						<c:forEach var="minute" begin="0" end="59">
							<c:if test="${minute < 10}">
								<option value="0${minute}">0${minute}</option>
							</c:if>
							<c:if test="${minute >= 10}">
								<option value="${minute}">${minute}</option>
							</c:if>
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
						<%-- <c:forEach var="index" begin="1" end="10">
							<option>${index}</option>
						</c:forEach> --%>
					</select>
				</div>
			</div>
			<input type="hidden" name="start">
			<input type="hidden" name="end">
			<input type="hidden" name="employeeId" value="${loginUser.user.employeeId}">
			<input type="hidden" name="choiceDay">
			<input type="submit" value="예약등록">
			<input type="button" value="취소" id="listReservation">
		</form>
	</section>
</body>
</html>