</html><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />

<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/standard.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/reservationDetail/read.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservationDetail/read.js"></script>

<section class="width1200">
	<h1>예약 상세보기</h1>
	<form name="reservationDetailForm" id="reservationDetailForm" method="post">
		<table>
			<tr>
				<td>
					<b>예약번호</b>
				</td>
				<td colspan="2" class="td_input">
					<span>${reservation.reservationId}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>예약사용일시</b>
				</td>
				<td colspan="2" class="td_input">
					<span>
					<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd" /> <fmt:formatDate value="${reservation.startDate}" pattern="kk:mm" /> ~ <fmt:formatDate value="${reservation.endDate}" pattern="kk:mm" />
					<input type="hidden" size="50" name="startTime" value=<fmt:formatDate value="${reservation.startDate}" pattern="kk:mm" /> />
					<input type="hidden" size="50" name="actualEndDay" value=<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd" /> />
					<input type="hidden" size="50" name="actualEndTime" value=<fmt:formatDate value="${reservation.actualEndDate}" pattern="kk:mm" /> />
					<c:if test="${not empty limitReservation}">
					<input type="hidden" size="50" name="limitReservation" value=<fmt:formatDate value="${limitReservation}" pattern="kk:mm" /> />
					</c:if>
					
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>회의실명</b>
				</td>
				<td colspan="2" class="td_input">
					<span>${reservation.meetingRoomName}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>회의목적</b>
				</td>
				<td colspan="2" class="td_input">
					<span>${reservation.meetPurpose}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>참석자수</b>
				</td>
				<td colspan="2" class="td_input">
					<span>${reservation.meetAttendess}명</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>상태</b>
				</td>
				<td colspan="2" class="td_input">
					<c:choose>
						<c:when test="${reservation.state eq 'R'}">
							<fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
							<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
							<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" var="actualEndDate" />
							<c:choose>
								<c:when test="${today >= startDate  &&  today < actualEndDate}">
									<span>진행중</span>
								</c:when>
								<c:otherwise>
									<span>예약</span>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${reservation.state eq 'RC'}">
							<span>예약취소</span>
						</c:when>
						<c:when test="${reservation.state eq 'E'}">
							<span>연장</span>
						</c:when>
						<c:when test="${reservation.state eq 'F'}">
							<span>종료</span>
						</c:when>
						<c:when test="${reservation.state eq 'FV'}">
							<span>종료확인</span>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>
					<b>신청자</b>
				</td>
				<td colspan="2" class="td_input">
					<span>${reservation.employeeName}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>소속부서</b>
				</td>
				<td colspan="2" class="td_input">
					<span>${reservation.departmentName}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>예약신청일시</b>
				</td>
				<td colspan="2" class="td_input">
					<fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm" />
				</td>
			</tr>
			<c:choose>
				<c:when test="${reservation.state eq 'RC'}">
				<tr>
					<td>
						<b>취소사유</b>
					</td>
					<td class="td_input">
						<span>${reservation.cancelReason}</span>
					</td>
				</tr>

				</c:when>

				<c:when test="${reservation.state eq 'E' && not empty extend}">
				<tr>
					<td>
						<b>종료일시</b>
					</td>
					<td class="td_input">
						<fmt:formatDate value="${extend.endDate}" pattern="yyyy.MM.dd kk:mm" />
					</td>
				</tr>
				<tr>
					<td>
						<b>연장사유</b>
					</td>
					<td class="td_input">
						<span>${extend.extendReason}</span>
					</td>
				</tr>	
				</c:when>
				
				<c:when test="${reservation.state eq 'F' || reservation.state eq 'FV'}">
				<tr>
					<td>
						<b>종료일시</b>
					</td>
					<td class="td_input">
						<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" />
					</td>
				</tr>
				<c:if test="${not empty extend}">
					<tr>
						<td>
							<b>연장사유</b>
						</td>
						<td class="td_input">
							<span>${extend.extendReason}</span>
						</td>
					</tr>
				</c:if>
				<c:if test="${reservation.state eq 'FV'}">
					<tr>
						<td>
							<b>이상유무</b>
						</td>
						<td class="td_input">
							<span>${reservation.abnormality}</span>
						</td>
					</tr>
				</c:if>
				</c:when>
			</c:choose>

			<tr id="inputForm"></tr>
			<tr id="reasonForm"></tr>

		</table>
		<div id="btnDiv"></div>
		<div>
			<div id="listDiv" class="float_left">
				<input type="button" id="list" value="목록" />
			</div>
			<div class="clear_both"></div>
			<c:if test="${loginUser.manager eq 'true' || isSelfReservation eq 'true'}">
				<c:if test="${reservation.state eq 'R' || reservation.state eq 'E'}">
					<fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
					<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
					<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" var="actualEndDate" />

					<c:choose>
						<c:when test="${today >= startDate  &&  today < actualEndDate}">
							<div id="processingDiv"  class="float_right position_down">
								<input type="button" id="exitReservation" value="조기종료" />
								<c:if test="${loginUser.manager eq 'false' && extendIspossible eq 'true'}">
									<input type="button" id="extendReservation" value="연장신청" />
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<div id="reservationDiv" class="float_right position_down">
								<input type="button" id="cancelReservation" value="예약취소" />
								<c:if test="${loginUser.manager eq 'false'}">
									<input  type="button" id="updateReservation" value="예약수정" />
								</c:if>
							</div>
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:if test="${reservation.state eq 'F'}">
					<div id="exitDiv" class="float_right position_down">
						<c:if test="${loginUser.manager eq 'true'}">
							<input type="button" id="exitCheckReservation" value="종료확인" />
						</c:if>
					</div>
				</c:if>
			</c:if>
			<div class="clear_both"></div>
		</div>
		<input type="hidden" size="50" name="oldUrl" value="${oldUrl}" />
		<input type="hidden" size="50" name="meetingRoomId" value="${reservation.meetingRoomId}" />
		<input type="hidden" size="50" name="reservationId" value="${reservation.reservationId}" />
	</form>
</section>
</body>
</html>