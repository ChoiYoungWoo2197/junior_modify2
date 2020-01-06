</html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<link
	href="${pageContext.request.contextPath}/resources/css/reservationDetail/read.css"
	rel="stylesheet" type="text/css" />
<script>
	$(function() {
		$("#cancelReservation").click(function() {
			$("#reservationDiv").hide();
			$("#cancelDiv").show();
			$("#cancelReason").show();
		})
		$("#cancel").click(function() {
			$("#reservationDiv").show();
			$("#cancelDiv").hide();
			$("#cancelReason").hide();
		})

		$("#updateReservation").click(function() {
			location.href="${pageContext.request.contextPath}/reservation/update?reservationId="+${reservation.reservationId};
		})

		$("#ok")
				.click(
						function() {
							if (confirm("취소하시겠습니까?") == true) {
								//alert("확인!");
								//var reason = $("input[name='reason']").val();

								document
										.getElementById('reservationDetailForm').action = "${pageContext.request.contextPath}/reservationDetail/cancel?";
								document
										.getElementById('reservationDetailForm')
										.submit();

							} else {
								//alert("취소!");
							}

						})

	})
</script>

<section class="width1200">
	<h3>예약 상세보기</h3>
	<br>
	<form name="reservationDetailForm" id="reservationDetailForm"
		method="post">
		<table>
			<tr>
				<td><b>예약번호</b></td>
				<td colspan="2"><span>${reservation.reservationId}</span></td>
			</tr>
			<tr>
				<td><b>예약사용일시</b></td>
				<td colspan="2"><span> <fmt:formatDate
							value="${reservation.startDate}" pattern="yyyy.MM.dd" /> <fmt:formatDate
							value="${reservation.startDate}" pattern="kk:mm" /> ~ <fmt:formatDate
							value="${reservation.endDate}" pattern="kk:mm" />
				</span></td>
			</tr>
			<tr>
				<td><b>회의실명</b></td>
				<td colspan="2"><span>${reservation.meetingRoomName}</span></td>
			</tr>
			<tr>
				<td><b>회의목적</b></td>
				<td colspan="2"><span>${reservation.meetPurpose}</span></td>
			</tr>
			<tr>
				<td><b>참석자수</b></td>
				<td colspan="2"><span>${reservation.meetAttendess}명</span></td>
			</tr>
			<tr>
				<td><b>상태</b></td>
				<td colspan="2"><span>${reservation.state}</span></td>
			</tr>
			<tr>
				<td><b>신청자</b></td>
				<td colspan="2"><span>${reservation.employeeName}</span></td>
			</tr>
			<tr>
				<td><b>소속부서</b></td>
				<td colspan="2"><span>${reservation.departmentName}</span></td>
			</tr>
			<tr>
				<td><b>예약신청일시</b></td>
				<td colspan="2"><fmt:formatDate
						value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm" /></td>
			</tr>
			<tr id="cancelReason" class="hide">
				<td><b>취소사유</b></td>
				<td colspan="2"><input type="text" size="50" name="reason" /></td>
			</tr>

		</table>
		<c:choose>
			<c:when test="${reservation.state eq 'R'}">
				<div id="reservationDiv">
					<input type="button" id="cancelReservation" value="예약취소" /> <input
						type="button" id="updateReservation" value="예약수정" />
				</div>
				<div id="cancelDiv" class="hide">
					<input type="button" id="cancel" value="취소" /> <input
						type="button" id="ok" value="확인" />
				</div>
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

		<input type="hidden" size="50" name="reservationId"
			value="${reservation.reservationId}" />
	</form>
</section>
</body>
</html>