</html><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />

<style>
table {
	width: 100%;
}

table, th, td {
	border: 1px solid #bcbcbc;
}

.width1200 {
	width: 1200px;
	margin: 0 auto;
}

.overflow {
	overflow: hidden;
}

.floatRight {
	float: right;
}
.floatLeft {
	float: left;
}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		function hide() {
			$("#listDiv").hide();
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
			$("#listDiv").show();
			$("#reservationDiv").show();
		});

		$(document).on("click",	"#completeCancel", function() {
			if (confirm("취소하시겠습니까?") == true) {
				if($("input[name='cancelReason']").val() == "") {
					alert("취소사유를 입력해주세요.");
				}
				else {
					document.getElementById('reservationDetailForm').action = "/reservationDetail/cancel";
					document.getElementById('reservationDetailForm').submit();
				}
			}
		});

		//조기종료 클릭시
		$("#exitReservation").click(function() {
			hide();
			creatExitTag();
		})

		$(document).on("click", "#denyExit", function() {
			empty();
			$("#listDiv").show();
			$("#processingDiv").show();
		});

		$(document).on("click",	"#completeExit",function() {
			if (confirm("종료하시겠습니까?") == true) {			
				var actualDay = $("input[name='actualEndDay']").val();
				var actualDayArray = actualDay.split('.');				
				var startTime = $("input[name='startTime']").val();
				var actualTime = $("input[name='actualEndTime']").val();		
				var startDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+startTime);
				var actualDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+actualTime);		
				var exitDateHour = $("#exitTimeHours option:selected").val();
				var exitDateMinutes = $("#exitTimeMinutes option:selected").val();
				var exitDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+exitDateHour+ ':'+exitDateMinutes);
				
				if(exitDate <  startDate || exitDate > actualDate) {
					empty();
					creatExitTag();
					$('#exitTd').append('<label style="color:red"> 시작일시와 종료일시 사이에 종료하실수 있습니다. 다시입력해주세요.</label>');
					
				}
				else {
					document.getElementById('reservationDetailForm').action = "/reservationDetail/exit";
					document.getElementById('reservationDetailForm').submit();
				}
			}
		
		});

		//연장신청 클릭시
		$("#extandReservation").click(function() {
			hide();
			createExtandTag();
		})

		$(document).on("click", "#denyExtand", function() {
			empty();
			$("#listDiv").show();
			$("#processingDiv").show();
		});

		$(document).on("click",	"#completeExtand", function() {
			if (confirm("연장하시겠습니까?") == true) {
				if($("input[name='extandReason']").val() == "") {
					alert("연장사유를 입력해주세요.");	
				}
				else {
					var actualDay = $("input[name='actualEndDay']").val();
					var actualDayArray = actualDay.split('.');
					var actualTime = $("input[name='actualEndTime']").val();
					var actualDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+actualTime);
					
					var extandDateHour = $("#extandTimeHours option:selected").val();
					var extandDateMinutes = $("#extandTimeMinutes option:selected").val();
					var extandDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+extandDateHour+ ':'+extandDateMinutes);
					
					var endDate = actualDay + " " + extandDateHour + ":" + extandDateMinutes;
					
					var result = true;
					$.ajax({
						//연장신청날짜, 연장종료일시, 연장사유, 회의실 번호, 실제종료일시
						url : "/reservationDetail/checkTime?end="+endDate+"&meetingRoomId="+$("select[name='meetingRoomId']").val()+"&reservationId="+$("input[name='reservationId']").val(),
						type : "get",
						async : false,
						success : function(res) {
							console.log(res);
							
							if(res == "false") {
								result = false;
								alert("다른 시간을 선택해주세요.");
							} else {
								result = true;
							}
						}
					})
					
					if(result) {
						document.getElementById('reservationDetailForm').action = "/reservationDetail/extand";
						document.getElementById('reservationDetailForm').submit();	
					}
					else {
						empty();
						createExtandTag();
						$('#extandTd').append('<label style="color:red"> 예약일시보다 빠릅니다. 다시입력해주세요.</label>');
					}

				}

			}
		});

		$("#exitCheckReservation").click(function() {
			hide();
			var td = '<td> <b>이상유무확인</b></td>';
			var abnormality = '<td><input type="text" name="abnormality" style="width:100%;"/></td>';
			var cancel = '<input type="button" id="denyExitCheck" value="취소"/>';
			var complete = '<input type="button" id="completeExitCheck" value="완료"/>';
			$("#inputForm").append(td).append(abnormality);
			$("#btnDiv").append(cancel).append(complete);
		})

		$(document).on("click", "#denyExitCheck", function() {
			empty();
			$("#listDiv").show();
			$("#exitDiv").show();
		});

		$(document).on("click", "#completeExitCheck", function() {
			if (confirm("종료확인 하시겠습니까?") == true) {
				if($("input[name='abnormality']").val() == "") {
					alert("이상유무를 입력해주세요.");
				}
				else {
					document.getElementById('reservationDetailForm').action = "/reservationDetail/exitCheck";
					document.getElementById('reservationDetailForm').submit();	
				}

			}
		});

		$(document).on("click", "#list", function() {
			location.href = "/reservation/list";
		});
		
		$("#updateReservation").click(function() {
			location.href="/reservation/update?reservationId="+${reservation.reservationId};
		})
		
		function creatExitTag() {
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
		}
		
		function createExtandTag() {
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

			var actualEndTime = $("input[name='actualEndTime']").val().substring(0,2);
			var limitReservation = $("input[name='limitReservation']").val() == null ? 22 : $("input[name='limitReservation']").val().substring(0,2);
			
			$("#inputForm").append(td).append(extandTd);
			$('#extandTd').append(selectStart);
			for (var count = actualEndTime; count <= limitReservation; count++) {
				var option = $("<option>" + count + "</option>");
				$('#extandTimeHours').append(option);
			}
			$('#extandTd').append(spanHour).append(selectEnd);
			for (var count = 0; count <= 59; count++) {
				var option = $("<option>" + count + "</option>");
				$('#extandTimeMinutes').append(option);
			}
			
			if($("input[name='limitReservation']").val() != null) {
				var label = '<label> 이 후' +$("input[name='limitReservation']").val() +' 예약건이 있습니다. </label>';
				$('#extandTd').append(label);
			}
			
			$("#reasonForm").append(reasonTd).append(reason);
			$("#btnDiv").append(cancel).append(complete);
		}
		
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
				
				<c:when test="${reservation.state eq 'F' || reservation.state eq 'FV'}">
				<tr>
					<td>
						<b>종료일시</b>
					</td>
					<td>
						<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" />
					</td>
				</tr>
				<c:if test="${not empty extend}">
					<tr>
						<td>
							<b>연장사유</b>
						</td>
						<td>
							<span>${extend.extendReason}</span>
						</td>
					</tr>
				</c:if>
				<c:if test="${reservation.state eq 'FV'}">
					<tr>
						<td>
							<b>이상유무</b>
						</td>
						<td>
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
		<div class="overflow" >
			<div id="listDiv" class="floatLeft">
				<input type="button" id="list" value="목록" />
			</div>
			<c:if test="${loginUser.manager eq 'true' || isSelfReservation eq 'true'}">
				<c:if test="${reservation.state eq 'R' || reservation.state eq 'E'}">
					<fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
					<fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
					<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" var="actualEndDate" />

					<c:choose>
						<c:when test="${today >= startDate  &&  today < actualEndDate}">
							<div id="processingDiv"  class="floatRight">
								<input type="button" id="exitReservation" value="조기종료" />
								<c:if test="${loginUser.manager eq 'false' && extendIspossible eq 'true'}">
									<input type="button" id="extandReservation" value="연장신청" />
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<div id="reservationDiv" class="floatRight">
								<input type="button" id="cancelReservation" value="예약취소" />
								<c:if test="${loginUser.manager eq 'false'}">
									<input type="button" id="updateReservation" value="예약수정" />
								</c:if>
							</div>
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:if test="${reservation.state eq 'F'}">
					<div id="exitDiv" class="floatRight">
						<c:if test="${loginUser.manager eq 'true'}">
							<input type="button" id="exitCheckReservation" value="종료확인" />
						</c:if>
					</div>
				</c:if>
		
			</c:if>
		</div>
		<input type="hidden" size="50" name="meetingRoomId" value="${reservation.meetingRoomId}" />
		<input type="hidden" size="50" name="reservationId" value="${reservation.reservationId}" />
	</form>
</section>
</body>
</html>