<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/reservation/insert.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservation/modify.js"></script>

<section class="width1300">
	<h1>예약 수정</h1>
	<form id="updateReservationForm" method="post" action="/reservation/update">
		<div class="color_red float_right">* 필수입력</div>
		<div class="clear_both"></div>
		<div class="width15 float_left">
			<h3>1.회의실선택</h3>
			<label>회의실 <span class="color_red">*</span></label> <br>
			<select id="meetingRoomSelect" name="meetingRoomId">
				<option value="0">회의실 선택</option>
				<c:forEach var="meetingRoom" items="${meetingRoomList}">
					<c:if test="${meetingRoom.availability eq 'true'}">
						<c:if test="${reservation.meetingRoomId == meetingRoom.meetingRoomId}">
							<option value="${meetingRoom.meetingRoomId}" selected="selected" class="font_bold">${meetingRoom.name}</option>
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
				<h4>지원장비</h4>
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
				<h4>좌석수</h4>
				<span>${seats}석</span>
			</div>
		</div>
		<div class="width55 float_left">
			<h3>2.회의일시</h3>
			<div class="float_left width65">
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
			</div>
			<div class="float_left width35">
				<div id="timeInsert">
					<label>시작시간 <span class="color_red">*</span> : </label>
					<select name="startHour">
						<c:forEach var="hour" begin="9" end="22">
							<fmt:formatDate value="${reservation.startDate}" pattern="kk" var="start"/>
							<c:if test="${hour < 10}">
								<option value="0${hour}" ${09 == start ? 'selected class="font_bold"':''}>0${hour}</option>
							</c:if>
							<c:if test="${hour >= 10}">
								<option value="${hour}" ${hour == start ? 'selected class="font_bold"':''}>${hour}</option>
							</c:if>
						</c:forEach>
					</select>시 &nbsp;
					<select name="startMinute">
						<c:forEach var="minute" begin="0" end="59">
							<fmt:formatDate value="${reservation.startDate}" pattern="mm" var="start"/>
							<c:if test="${minute < 10}">
								<option value="0${minute}" ${minute == start ? 'selected class="font_bold"':''}>0${minute}</option>
							</c:if>
							<c:if test="${minute >= 10}">
								<option value="${minute}" ${minute == start ? 'selected class="font_bold"':''}>${minute}</option>
							</c:if>
						</c:forEach>
					</select>분
					<br>
					<label>종료시간 <span class="color_red">*</span> : </label>
					<select name="endHour">
						<c:forEach var="hour" begin="9" end="22">
							<fmt:formatDate value="${reservation.endDate}" pattern="kk" var="end"/>
							<c:if test="${hour < 10}">
								<option value="0${hour}" ${hour == end ? 'selected class="font_bold"':''}>0${hour}</option>
							</c:if>
							<c:if test="${hour >= 10}">
								<option value="${hour}" ${hour == end ? 'selected class="font_bold"':''}>${hour}</option>
							</c:if>
						</c:forEach>
					</select>시 &nbsp;
					<select name="endMinute">
						<c:forEach var="minute" begin="0" end="59">
							<fmt:formatDate value="${reservation.endDate}" pattern="mm" var="end"/>
							<c:if test="${minute < 10}">
								<option value="0${minute}" ${minute == end ? 'selected class="font_bold"':''}>0${minute}</option>
							</c:if>
							<c:if test="${minute >= 10}">
								<option value="${minute}" ${minute == end ? 'selected class="font_bold"':''}>${minute}</option>
							</c:if>
						</c:forEach>
					</select>분
				</div>
			</div>
		</div>
		<div class="width20 float_left">
			<h3>3.회의정보</h3>
			<div>
				<label>회의목적 <span class="color_red">*</span></label> <br>
				<input type="text" placeholder="회의목적(주제)를 입력해주세요." name="meetPurpose" value="${reservation.meetPurpose}">
			</div>
			<div>
				<label>회의참석자 <span class="color_red">*</span></label> <br>
				<select name="meetAttendess">
					<c:forEach var="index" begin="1" end="${seats}">
						<option ${index == reservation.meetAttendess ? 'selected class="font_bold"':''}>${index}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="clear_both"></div>
		<input type="hidden" name="seats" value="${reservation.meetAttendess}">
		<input type="hidden" name="start">
		<input type="hidden" name="end">
		<input type="hidden" name="employeeId" value="${loginUser.user.employeeId}">
		<input type="hidden" name="reservationId" value="${reservation.reservationId}">
		<input type="hidden" name="choiceDay">
		<div class="float_right">
			<input type="submit" value="수정">
			<input type="button" value="취소" id="readReservation">
		</div>
	</form>
</section>
</body>
</html>