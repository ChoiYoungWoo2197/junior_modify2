<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
	.color_red {
		color: red;
		font-size: 14px;
	}
	form {
		margin-top: 10px;
	}
	table {
		border-collapse: collapse;
		width: 100%;
		margin: 10px 0 10px 0;
	}
	td {
		border: 1px solid black;
		padding: 5px 5px 5px 20px;
	}
	td:first-child {
		width: 20%;
	}
	td:last-child > label {
		width: 140px;
		float: left;
	}
	input[type='checkbox'], input[type='radio'] {
		margin-right: 5px;
	}
	input[type='text'] {
		width: 80%;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/modify.js"></script>
<!-- <script>
	$(function() {
		$("#listManagement").click(function() {
			location.href = "list?management="+$("input[name='management']").val();
		})
		
		$("#updateMeetingRoomForm").submit(function() {
			var result = confirm("수정하시겠습니까?");
			
			if(result == true) {
				var check = true;
				$("input[name='name']").next().addClass("display_none");
				$("input[name='seats']").next().addClass("display_none");
				
				if($("input[name='name']").val() == "") {
					$("input[name='name']").next().removeClass("display_none");
					check = false;
				}
				
				if($("input[name='seats']").val() == "") {
					$("input[name='seats']").next().removeClass("display_none");
					check = false;
				} else if ($("input[name='seats']").val() != "") {
					if(Number($("input[name='seats']").val()) <= 0) {
						$("input[name='seats']").next().next().removeClass("display_none");
			        	check = false;
			        }
			        
			        if(Number($("input[name='seats']").val()) != $("input[name='seats']").val()) {
			        	$("input[name='seats']").next().next().removeClass("display_none");
			        	check = false;
			        }
				}
				
				var checkTrue = [];
				$("input[name='equipmentId']:checked").each(function(i) {
					checkTrue.push($(this).val());	// 체크된 것만 값을 뽑아서 배열에 push
			    })
			    $("input[name='checkTrue']").val(checkTrue);
				
				return check;
			} else {
				return false;
			}
		})
		
		$("#cancelUpdate").click(function() {
			var meetingRoomId = Number($("input[name='meetingRoomId']").val());
			location.href = "read?meetingRoomId="+meetingRoomId;
		})
	})
</script> -->

	<section class="width1200">
		<form id="updateMeetingRoomForm" method="post" action="/meetingRoom/modify">
			<div class="color_red">* 필수입력</div>
			<table>
				<tr>
					<td>
						<label>회의실명 <span class="color_red">*</span></label>
					</td>
					<td>
						<input type="text" name="name" value="${meetingRoom.name}">
						<span class="color_red display_none">회의실명을 입력하세요.</span>
					</td>
				</tr>
				<tr>
					<td>
						<label>좌석수 <span class="color_red">*</span></label>
					</td>
					<td>
						<input type="text" name="seats" value="${meetingRoom.seats}">
						<span class="color_red display_none">좌석수를 입력하세요.</span>
						<span class="color_red display_none">좌석수를 잘못 입력하셨습니다.</span>
					</td>
				</tr>
				<tr>
					<td>
						<label>예약가능여부 <span class="color_red">*</span></label>
					</td>
					<td>
						<c:if test="${meetingRoom.availability eq 'true'}">
							<label for="availabilityTrue"><input type="radio" name="availability" value="true" checked="checked" id="availabilityTrue">가능</label>
							<label for="availabilityFalse"><input type="radio" name="availability" value="false" id="availabilityFalse">불가능</label>
						</c:if>
						<c:if test="${meetingRoom.availability eq 'false'}">
							<label for="availabilityTrue"><input type="radio" name="availability" value="true" id="availabilityTrue">가능</label>
							<label for="availabilityFalse"><input type="radio" name="availability" value="false" checked="checked" id="availabilityFalse">불가능</label>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>
						<label>지원설비</label>
					</td>
					<td>
						<c:forEach var="equipment" items="${equipmentList}">
							<label for="${equipment.equipmentId}"><input type="checkbox" name="equipmentId" value="${equipment.equipmentId}" id="${equipment.equipmentId}">${equipment.name}</label>
							<c:forEach var="meetingRoomEquipment" items="${meetingRoomEquipmentList}" varStatus="status">
								<c:if test="${meetingRoomEquipment.equipmentName eq equipment.name}">
									<script>
										$("#${equipment.equipmentId}").attr("checked", "checked");
									</script>
								</c:if>
							</c:forEach>
						</c:forEach>
						<input type="hidden" name="checkTrue">
					</td>
				</tr>
			</table>
			<input type="button" value="목록" id="listMeetingRoom">
			<div class="float_right">
				<input type="hidden" name="meetingRoomId" value="${meetingRoom.meetingRoomId}">
				<input type="hidden" name="managerId" value="1">
				<input type="submit" value="수정">
				<input type="button" value="돌아가기" id="cancelUpdate">
			</div>
		</form>
	</section>
</body>
</html>