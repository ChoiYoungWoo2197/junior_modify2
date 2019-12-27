<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<script>
	$(function() {
		$("#insertMeetingRoom").click(function() {
			location.href = "insert";
		})
	})
</script>
	<section class="width1200">
		<table>
			<tr>
				<th>번호</th>
				<th>회의실</th>
				<th>좌석수</th>
				<th>예약가능여부</th>
				<th>지원장비</th>
				<th>등록일시</th>
			</tr>
			<c:if test="${empty meetingRoomList}">
				<tr>
					<td colspan="6">내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty meetingRoomList}">
				<c:forEach var="meetingRoom" items="${meetingRoomList}">
					<tr>
						<td>${meetingRoom.meetingRoomId}</td>
						<td>${meetingRoom.name}</td>
						<td>${meetingRoom.seats}</td>
						<td>${meetingRoom.availability eq "true" ? "가능" : "불가능"}</td>
						<td></td>
						<td><fmt:formatDate value="${meetingRoom.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button id="insertMeetingRoom">회의실 등록</button>
	</section>
</body>
</html>