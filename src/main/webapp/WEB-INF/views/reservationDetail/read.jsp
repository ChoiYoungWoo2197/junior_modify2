</html><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />

<link href="${pageContext.request.contextPath}/resources/css/reservationDetail/read.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		function hide() {
			$("#reservationDiv").hide();
			$("#processingDiv").hide();
			$("#exitDiv").hide();
		}

		function empty() {
			$("#inputForm").empty();
			$("#reasonForm").empty();
			$("#btnDiv").empty();
		}

		//예약취소 클릭시
		$("#cancelReservation").click(function() {
			hide();
			var td = '<td> <b>취소사유</b></td>';
			var reason = '<td><input type="text" name="cancelReason" style="width:100%;"/></td>';
			var cancel = '<input type="button" id="denyCancel" value="취소"/>';
			var complete = '<input type="button" id="completeCancel" value="완료"/>';
			$("#inputForm").append(td).append(reason);
			$("#btnDiv").append(cancel).append(complete);

		})
		$(document).on("click", "#denyCancel", function() {
			empty();
			$("#reservationDiv").show();
		});

		$(document).on("click",	"#completeCancel", function() {
			if (confirm("취소하시겠습니까?") == true) {
				document.getElementById('reservationDetailForm').action = "${pageContext.request.contextPath}/reservationDetail/cancel";
				document.getElementById('reservationDetailForm').submit();

			}
		});

		//조기종료 클릭시
		$("#exitReservation").click(function() {
			hide();
			var td = '<td> <b>조기종료시각</b></td>';
			var exitTd = '<td id="exitTd"></td>';
			var selectStart = '<select name="exitTimeHours" id="exitTimeHours"></select>';
			var selectEnd = '<select name="exitTimeMinutes" id="exitTimeMinutes"></select>';
			var spanHour = '<span> : </span>';
			var spanMinutes = '<span> 분 </span>';
			var cancel = '<input type="button" id="denyExit" value="취소"/>';
			var complete = '<input type="button" id="completeExit" value="완료"/>';

			$("#inputForm").append(td).append(exitTd);
			$('#exitTd').append(selectStart);
			for (var count = 9; count <= 22; count++) {
				var option = $("<option>" + count + "</option>");
				$('#exitTimeHours').append(option);
			}
			$('#exitTd').append(spanHour).append(selectEnd);
			for (var count = 0; count <= 59; count++) {
				var option = $("<option>" + count + "</option>");
				$('#exitTimeMinutes').append(option);
			}
			
			//$("#inputForm").append(spanMinutes);
			$("#btnDiv").append(cancel).append(complete);
		})

		$(document).on("click", "#denyExit", function() {
			empty();
			$("#processingDiv").show();
		});

		$(document).on("click",	"#completeExit",function() {
			if (confirm("종료하시겠습니까?") == true) {
				document.getElementById('reservationDetailForm').action = "${pageContext.request.contextPath}/reservationDetail/exit";
				document.getElementById('reservationDetailForm').submit();
			}
		});

		//연장신청 클릭시
		$("#extandReservation").click(function() {
			hide();
			var td = '<td><b>종료시각</b></td>';
			var extandTd = '<td id="extandTd"></td>';
			var reasonTd = '<td id="reasonTd"><b>연장사유</b></td>';
			var selectStart = '<select name="extandTimeHours" id="extandTimeHours"></select>';
			var selectEnd = '<select name="extandTimeMinutes" id="extandTimeMinutes"></select>';
			var spanHour = '<span> : </span>';
			var spanMinutes = '<span> 분 </span>';
			var reason = '<td><input type="text" name="extandReason" style="width:100%;"/></td>';
			var cancel = '<input type="button" id="denyExtand" value="취소"/>';
			var complete = '<input type="button" id="completeExtand" value="완료"/>';

			$("#inputForm").append(td).append(extandTd);
			$('#extandTd').append(selectStart);
			for (var count = 9; count <= 22; count++) {
				var option = $("<option>" + count + "</option>");
				$('#extandTimeHours').append(option);
			}
			$('#extandTd').append(spanHour).append(selectEnd);
			for (var count = 0; count <= 59; count++) {
				var option = $("<option>" + count + "</option>");
				$('#extandTimeMinutes').append(option);
			}
			
			$("#reasonForm").append(reasonTd).append(reason);
			$("#btnDiv").append(cancel).append(complete);
		})

		$(document).on("click", "#denyExtand", function() {
			empty();
			$("#processingDiv").show();
		});

		$(document).on("click",	"#completeExtand", function() {
			if (confirm("연장하시겠습니까?") == true) {
				document.getElementById('reservationDetailForm').action = "${pageContext.request.contextPath}/reservationDetail/extand";
				document.getElementById('reservationDetailForm').submit();
			}
		});

		$("#exitCheckReservation").click(function() {
			hide();
			var td = '<td> <b>이상유무확인</b></td>';
			var abnormality = '<input type="text" name="abnormality"/>';
			var cancel = '<input type="button" id="denyExitCheck" value="취소"/>';
			var complete = '<input type="button" id="completeExitCheck" value="완료"/>';
			$("#inputForm").append(td).append(abnormality);
			$("#btnDiv").append(cancel).append(complete);
		})

		$(document).on("click", "#denyExitCheck", function() {
			empty();
			$("#exitDiv").show();
		});

		$(document).on("click", "#completeExitCheck", function() {
			var abnormality = $("input[name='abnormality']").val()
			alert(abnormality);
		});

	})
</script>

<section class="width1200">
	<h3>예약 상세보기</h3>
	<br>
	<form name="reservationDetailForm" id="reservationDetailForm" method="post">
		<table>
			<tr>
				<td>
					<b>예약번호</b>
				</td>
				<td colspan="2">
					<span>${reservation.reservationId}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>예약사용일시</b>
				</td>
				<td colspan="2">
					<span> <fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd" /> <fmt:formatDate value="${reservation.startDate}" pattern="kk:mm" /> ~ <fmt:formatDate value="${reservation.endDate}" pattern="kk:mm" />
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>회의실명</b>
				</td>
				<td colspan="2">
					<span>${reservation.meetingRoomName}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>회의목적</b>
				</td>
				<td colspan="2">
					<span>${reservation.meetPurpose}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>참석자수</b>
				</td>
				<td colspan="2">
					<span>${reservation.meetAttendess}명</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>상태</b>
				</td>
				<td colspan="2">
					<c:choose>
						<c:when test="${reservation.state eq 'R'}">
							<fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
							<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
							<fmt:formatDate value="${reservation.endDate}" pattern="yyyy.MM.dd kk:mm" var="endDate" />
							<c:choose>
								<c:when test="${today > startDate  &&  today < endDate}">
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
				<td colspan="2">
					<span>${reservation.employeeName}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>소속부서</b>
				</td>
				<td colspan="2">
					<span>${reservation.departmentName}</span>
				</td>
			</tr>
			<tr>
				<td>
					<b>예약신청일시</b>
				</td>
				<td colspan="2">
					<fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm" />
				</td>
			</tr>
			<c:choose>
				<c:when test="${reservation.state eq 'RC'}">
				<tr>
					<td>
						<b>취소사유</b>
					</td>
					<td>
						<span>${reservation.cancelReason}</span>
					</td>
				</tr>

				</c:when>

				<c:when test="${reservation.state eq 'E' && not empty extend}">
				<tr>
					<td>
						<b>종료일시</b>
					</td>
					<td>
						<fmt:formatDate value="${extend.endDate}" pattern="yyyy.MM.dd kk:mm" />
					</td>
				</tr>
				<tr>
					<td>
						<b>연장사유</b>
					</td>
					<td>
						<span>${extend.extendReason}</span>
					</td>
				</tr>
				</c:when>
			</c:choose>

			<tr id="inputForm"></tr>
			<tr id="reasonForm"></tr>

		</table>
		<div id="btnDiv"></div>
		<c:if test="${reservation.state eq 'R' || reservation.state eq 'E'}">
			<fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
			<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
			<fmt:formatDate value="${reservation.endDate}" pattern="yyyy.MM.dd kk:mm" var="endDate" />

<%-- 			<h5>${today}</h5>
			<h5>${startDate}</h5>
			<h5>${endDate}</h5> --%>
			<c:choose>
				<c:when test="${today > startDate  &&  today < endDate || reservation.state eq 'E'}">
					<div id="processingDiv">
						<input type="button" id="exitReservation" value="조기종료" />

						<c:if test="${loginUser.manager eq 'false'}">
							<input type="button" id="extandReservation" value="연장신청" />
						</c:if>
					</div>

				</c:when>
				<c:otherwise>
					<div id="reservationDiv">
						<input type="button" id="cancelReservation" value="예약취소" />
						<c:if test="${loginUser.manager eq 'false'}">
							<input type="button" id="updateReservation" value="예약수정" />
						</c:if>
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${reservation.state eq 'F'}">
			<div id="exitDiv">
				<c:if test="${loginUser.manager eq 'true'}">
					<input type="button" id="exitCheckReservation" value="종료확인" />
				</c:if>
			</div>
		</c:if>

		<input type="hidden" size="50" name="reservationId" value="${reservation.reservationId}" />
	</form>
</section>
</body>
</html>