<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<style>
	td, th {
		border: 1px solid black;
	}
	table {
		border-collapse: collapse;
		width: 100%;
	}
</style>

<script>
	$(function() {
		$("#insertReservation").click(function() {
			location.href = "insert";
		})
		
		$(document).on("click", ".readReservation", function() {
		var reservationId = Number($(this).text());
		window.location.href = "${pageContext.request.contextPath}/reservationDetail/read?reservationId="+ reservationId;
		//location.href = "read?memberId=" + memberId;
		})
	})
</script>	
	
	<section class="width1200">
		<div>
			<label>사용일</label>
			<input type="date"> ~ <input type="date">
			<select>
				<option>상태</option>
				<option>예약</option>
				<option>예약취소</option>
				<option>연장</option>
				<option>종료</option>
				<option>종료확인</option>
			</select>
			<select>
				<option>회의실</option>
			</select>
			<select>
				<option>부서</option>
				<option>신청자</option>
				<option>회의목적</option>
			</select>
		</div>
		<table>
			<tr>
				<th>번호</th>
				<th>회의일자</th>
				<th>사용시간</th>
				<th>상태</th>
				<th>회의실</th>
				<th>회의목적</th>
				<th>신청자</th>
				<th>신청일시</th>
			</tr>
			<c:forEach var="reservation" items="${reservationList}">
				<tr>
					<td class="readReservation">${reservation.reservationId}</td>
					<td><fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd"/></td>
					<td><fmt:formatDate value="${reservation.startDate}" pattern="kk:mm"/> ~ <fmt:formatDate value="${reservation.endDate}" pattern="kk:mm"/></td>
					<td>
						<c:choose>
							<c:when test="${reservation.state == 'R'}">
								예약
							</c:when>
							<c:when test="${reservation.state == 'RC'}">
								예약취소
							</c:when>
							<c:when test="${reservation.state == 'E'}">
								연장
							</c:when>
							<c:when test="${reservation.state == 'F'}">
								종료
							</c:when>
							<c:when test="${reservation.state == 'FV'}">
								종료확인
							</c:when>
						</c:choose>
					</td>
					<td>${reservation.meetingRoomName}</td>
					<td>${reservation.meetPurpose}</td>
					<td>${reservation.employeeName}(${reservation.departmentName})</td>
					<td><fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm"/></td>
				</tr>
			</c:forEach>
		</table>
		<button id="insertReservation">예약등록</button>
	</section>
</body>
</html>