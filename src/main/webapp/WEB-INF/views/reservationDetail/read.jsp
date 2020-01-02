</html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<script
	src="${pageContext.request.contextPath}/resources/css/reservationDetail/read.css"
	charset="UTF-8" type="text/javascript"></script>
<section class="width1200">
	<h3>예약 상세보기</h3>
	<br>
	<form name="reservationDetailForm" method="post">
		<table>
			<tr>
				<td><b>예약번호</b></td>
				<td colspan="2"><span>${reservation.reservationId}</span></td>
			</tr>
			<tr>
				<td><b>예약사용일시</b></td>
				<td colspan="2">
				<span>
				<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd"/>
				<fmt:formatDate value="${reservation.startDate}" pattern="kk:mm"/> ~ <fmt:formatDate value="${reservation.endDate}" pattern="kk:mm"/>
				</span>
				</td>
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
				<td colspan="2"><fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm"/></td>
			</tr>

		</table>
		<input type="button" value="예약취소"> <input type="submit"
			value="예약수정" />
	</form>
</section>
</body>
</html>