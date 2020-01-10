<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
	.width30 {
		width: 20%;
	}
	.width40 {
		width: 55%;
		border-right: 1px solid black;
		border-left: 1px solid black;
		padding-left: 10px;
	}
	section ul li {
		list-style: disc;
	}
	.color_blue {
		color: blue;
		font-weight: bold;
	}
	.color_red {
		color: red;
		font-size: 14px;
	}
	 table {
		border-collapse: collapse;
	  	width: 50%;
	}
	td, th {
	   	padding: 10px 0;
	   	text-align: center;
	   	border: 1px solid #bbb;
	}
	th {
	   	background-color: #D8D8D8;
	}
	select[name='meetAttendess'] {
		width: 50px;
	}
	
	
	
	
	
	
	
	
	
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservation/insert.js"></script>

<section class="width1300">
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
		<div class="width40 float_left">
			<div>
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
			</div>
			<div>
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
					<c:forEach var="index" begin="1" end="10">
						<option>${index}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="clear_both"></div>
		<input type="hidden" name="start">
		<input type="hidden" name="end">
		<input type="hidden" name="employeeId" value="${loginUser.user.employeeId}">
		<input type="hidden" name="choiceDay">
		<input type="submit" value="예약등록" class="float_right">
	</form>
</section>
</body>
</html>