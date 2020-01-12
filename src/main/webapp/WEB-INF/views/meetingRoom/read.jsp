<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/meetingRoom/read.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/read.js"></script>

	<section class="width1200">
		<h1>회의실 상세내역</h1>
		<div>
			<img src="${pageContext.request.contextPath}/resources/images/list2.png" id="listMeetingRoom" class="float_right">
		</div>
		<table>
			<tr>
				<th>회의실명</th>
				<td id="meetingRoomName">${meetingRoom.name}</td>
			</tr>
			<tr>
				<th>좌석수</th>
				<td>${meetingRoom.seats}</td>
			</tr>
			<tr>
				<th>예약가능여부</th>
				<td>${meetingRoom.availability eq 'true' ? '가능':'불가능'}</td>
			</tr>
			<tr>
				<th>지원설비</th>
				<td>
					<c:forEach var="meetingRoomEquipment" items="${meetingRoomEquipmentList}" varStatus="status">
						<c:if test="${! status.last}">
							${meetingRoomEquipment.equipmentName}, 
						</c:if>
						<c:if test="${status.last}">
							${meetingRoomEquipment.equipmentName}
						</c:if>
					</c:forEach>
				</td>
			</tr>
		</table>
		<input type="hidden" name="meetingRoomId" value="${meetingRoom.meetingRoomId}">
		<!-- <button id="listMeetingRoom">목록</button> -->
		<c:if test="${loginUser.manager eq 'true'}"> 
			<div class="float_right">
				<button id="updateMeetingRoom">수정</button>
				<button id="deleteMeetingRoom">삭제</button>
			</div>
		</c:if>
	</section>
</body>
</html>