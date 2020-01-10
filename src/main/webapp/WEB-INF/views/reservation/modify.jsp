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
	select[name='meetAttendess'] {
		width: 50px;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservation/modify.js"></script>

<section class="width1200">
	<form id="updateReservationForm" method="post" action="/reservation/update">
		<div class="color_red">* 필수입력</div>
		<div class="width30 float_left">
			<h4>1.회의실선택</h4>
			<label>회의실 <span class="color_red">*</span></label> <br>
			<select id="meetingRoomSelect" name="meetingRoomId">
				<option value="0">회의실 선택</option>
				<c:forEach var="meetingRoom" items="${meetingRoomList}">
					<c:if test="${meetingRoom.availability eq 'true'}">
						<c:if test="${reservation.meetingRoomId == meetingRoom.meetingRoomId}">
							<option value="${meetingRoom.meetingRoomId}" selected="selected">${meetingRoom.name}</option>
						</c:if>
						<c:if test="${reservation.meetingRoomId != meetingRoom.meetingRoomId}">
							<option value="${meetingRoom.meetingRoomId}">${meetingRoom.name}</option>
						</c:if>
					</c:if>
					<c:if test="${meetingRoom.availability eq 'false'}">
						<option value="${meetingRoom.meetingRoomId}" disabled="disabled">${meetingRoom.name}(사용불가)</option>
					</c:if>
				</c:forEach>
			</select>
			<div id="meetingRoomEquipment">
				<h5>지원장비</h5>
				<ul>
					<c:if test="${!empty meetingRoomEquipmentList}">
						<c:forEach items="${meetingRoomEquipmentList}" var="meetingRoomEquipment">
							<li>${meetingRoomEquipment.equipmentName}</li>
						</c:forEach>
					</c:if>
				</ul>
				<p>
					<c:if test="${empty meetingRoomEquipmentList}">
						지원하는 장비가 없습니다.
					</c:if>
				</p>
			</div>
			<div id="meetingRoomSeats">
				<h5>좌석수</h5>
				<span>${seats}</span>
			</div>
		</div>
		<div class="width30 float_left">
			<h4>2.회의일시</h4>
			<div>
				<div>
					<span class="display_none" id="reservationDate"><fmt:formatDate value="${reservation.startDate}" pattern="yyyy-MM-dd"/></span>
	        		<span id="prevMonth">&lt; </span><b id="today"></b><span id="nextMonth"> &gt;</span>
					<div id="calendar"></div>
				</div>
				<div id="reservationList">
					<ul>
						<c:forEach items="${reservationList}" var="reservation">
							<fmt:formatDate value="${reservation.startDate}" pattern="kk:mm" var="start"/>
							<fmt:formatDate value="${reservation.endDate}" pattern="kk:mm" var="end"/>
							<li>${start}~${end} &ensp; ${reservation.meetPurpose} <br>
								(${reservation.employeeName}(${reservation.departmentName}))
							</li>
						</c:forEach>
					</ul>
					<p></p> <!-- 예약내역 없는 경우 -->
				</div>
			</div>
			<div>
				<label>시작시간 <span class="color_red">*</span> : </label>
				<select name="startHour">
					<c:forEach var="hour" begin="9" end="22">
						<fmt:formatDate value="${reservation.startDate}" pattern="kk" var="start"/>
						<c:if test="${hour < 10}">
							<option value="0${hour}" selected="selected">0${hour}</option>
						</c:if>
						<c:if test="${hour >= 10}">
							<option value="${hour}" ${hour == start ? 'selected':''}>${hour}</option>
						</c:if>
					</c:forEach>
				</select>시
				<select name="startMinute">
					<c:forEach var="minute" begin="0" end="59">
						<fmt:formatDate value="${reservation.startDate}" pattern="mm" var="start"/>
						<c:if test="${minute < 10}">
							<option value="0${minute}" ${minute == start ? 'selected':''}>0${minute}</option>
						</c:if>
						<c:if test="${minute >= 10}">
							<option value="${minute}" ${minute == start ? 'selected':''}>${minute}</option>
						</c:if>
					</c:forEach>
				</select>분
				<br>
				<label>종료시간 <span class="color_red">*</span> : </label>
				<select name="endHour">
					<c:forEach var="hour" begin="9" end="22">
						<fmt:formatDate value="${reservation.endDate}" pattern="kk" var="end"/>
						<c:if test="${hour < 10}">
							<option value="0${hour}" ${hour == end ? 'selected':''}>0${hour}</option>
						</c:if>
						<c:if test="${hour >= 10}">
							<option value="${hour}" ${hour == end ? 'selected':''}>${hour}</option>
						</c:if>
					</c:forEach>
				</select>시
				<select name="endMinute">
					<c:forEach var="minute" begin="0" end="59">
						<fmt:formatDate value="${reservation.endDate}" pattern="mm" var="end"/>
						<c:if test="${minute < 10}">
							<option value="0${minute}" ${minute == end ? 'selected':''}>0${minute}</option>
						</c:if>
						<c:if test="${minute >= 10}">
							<option value="${minute}" ${minute == end ? 'selected':''}>${minute}</option>
						</c:if>
					</c:forEach>
				</select>분
			</div>
		</div>
		<div class="width30 float_left">
			<h4>3.회의정보</h4>
			<div>
				<label>회의목적 <span class="color_red">*</span></label> <br>
				<input type="text" placeholder="회의목적(주제)를 입력해주세요." name="meetPurpose" value="${reservation.meetPurpose}">
			</div>
			<div>
				<label>회의참석자 <span class="color_red">*</span></label> <br>
				<select name="meetAttendess">
					<c:forEach var="index" begin="1" end="${seats}">
						<option ${index == reservation.meetAttendess ? 'selected':''}>${index}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<input type="hidden" name="seats" value="${reservation.meetAttendess}">
		<input type="hidden" name="start">
		<input type="hidden" name="end">
		<input type="hidden" name="employeeId" value="${loginUser.user.employeeId}">
		<input type="hidden" name="reservationId" value="${reservation.reservationId}">
		<input type="hidden" name="choiceDay">
		<input type="submit" value="예약수정">
		<input type="button" value="취소" id="readReservation">
	</form>
</section>
</body>
</html>