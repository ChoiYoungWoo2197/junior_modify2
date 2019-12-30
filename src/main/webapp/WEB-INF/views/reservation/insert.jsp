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
		
		$(document).on("click", "td", function() {
			$("td").removeClass("color_blue");
			
			var date = new Date();
			var today = String(date.getFullYear())+String((date.getMonth()+1))+String(date.getDate());
			var choiceDay = $("#today").text().replace(".","")+$(this).text();
			
			alert(today);
			alert(choiceDay);
			
			/* if($(this).text() < date.getDate()) {
				alert("이전 날짜를 선택할 수 없습니다.");
				return false;
			} else {
				$(this).addClass("color_blue");
				
				alert($("#today").text());
			} */
			
			$(this).addClass("color_blue");
			
			//alert($("#today").text());
		})
		
		$("#meetingRoomSelect").change(function() {
			if($("select[name='meetingRoom']").val() != "none") {
				var meetingRoomId = Number($("select[name='meetingRoom']").val());
				
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
						var $seats = $("<span>").text(res.meetingRoom.seats + "석");
						$("#meetingRoomSeats").append($seatLabel).append($seats);
					}
				})
			}
		})
	})
</script>	
	
	<section class="width1200">
		<div class="width30 float_left">
			<h4>1.회의실선택</h4>
			<label>회의실</label> <br>
			<select id="meetingRoomSelect" name="meetingRoom">
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
				<div>
					
				</div>
			</div>
			<div>
				<label>시작시간 : </label>
				<select>
					<c:forEach var="hour" begin="9" end="22">
						<option>${hour}</option>
					</c:forEach>
				</select>시
				<select>
					<c:forEach var="minute" begin="0" end="59">
						<option>${minute}</option>
					</c:forEach>
				</select>분
				<br>
				<label>종료시간 : </label>
				<select>
					<c:forEach var="hour" begin="9" end="22">
						<option>${hour}</option>
					</c:forEach>
				</select>시
				<select>
					<c:forEach var="minute" begin="0" end="59">
						<option>${minute}</option>
					</c:forEach>
				</select>분
			</div>
		</div>
		<div class="width30 float_left">
			<h4>3.회의정보</h4>
		</div>
	</section>
</body>
</html>