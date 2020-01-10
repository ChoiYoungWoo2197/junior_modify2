</html><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
	.color_red {
		color: red;
		font-size: 14px;
	}
	table {
		border-collapse: collapse;
		width: 100%;
		margin: 20px 0 10px 0;
	}
	td, th {
		border: 1px solid black;
		padding: 5px;
	}
	td {
		padding-left: 20px;
		width: 70%;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/read.js"></script>
<!-- <script>
	$(function() {
		$("#listMeetingRoom").click(function() {
			location.href = "list";
		})
		
		$("#updateMeetingRoom").click(function() {
			var meetingRoomId = Number($("input[name=meetingRoomId]").val());
			location.href = "modify?meetingRoomId="+meetingRoomId;
		})
		
		$("#deleteMeetingRoom").click(function() {
			var result = confirm($("#meetingRoomName").text()+"회의실을 삭제하시겠습니까?");
			
			if(result == true) {
				var meetingRoomId = Number($("input[name=meetingRoomId]").val());
				location.href = "delete?meetingRoomId="+meetingRoomId;
			}
		})
	})
</script> -->

	<section class="width1200">
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
		<button id="listMeetingRoom">목록</button>
		<c:if test="${loginUser.manager eq 'true'}"> 
			<div class="float_right">
				<button id="updateMeetingRoom">수정</button>
				<button id="deleteMeetingRoom">삭제</button>
			</div>
		</c:if>
	</section>
</body>
</html>