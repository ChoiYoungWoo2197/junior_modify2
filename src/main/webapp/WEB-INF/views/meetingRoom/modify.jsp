<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<style>
	.color_red {
		color: red;
		font-size: 14px;
	}
	.display_none {
		display: none;
	}
</style>
<script>
	$(function() {
		$("#listManagement").click(function() {
			location.href = "list?management="+$("input[name='management']").val();
		})
		
		$("#updateMeetingRoomForm").submit(function() {
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
		})
	})
</script>

	<section class="width1200">
		<form id="updateMeetingRoomForm" method="post" action="/meetingRoom/modify">
			<div class="color_red">* 필수입력</div>
			<div>
				<label>회의실명 <span class="color_red">*</span></label>
				<input type="text" name="name" value="${meetingRoom.name}">
				<span class="color_red display_none">회의실명을 입력하세요.</span>
			</div>
			<div>
				<label>좌석수 <span class="color_red">*</span></label>
				<input type="text" name="seats" value="${meetingRoom.seats}">
				<span class="color_red display_none">좌석수를 입력하세요.</span>
				<span class="color_red display_none">좌석수를 잘못 입력하셨습니다.</span>
			</div>
			<div>
				<label>예약가능여부 <span class="color_red">*</span></label>
				<c:if test="${meetingRoom.availability eq 'true'}">
					<input type="radio" name="availability" value="true" checked="checked">가능
					<input type="radio" name="availability" value="false">불가능
				</c:if>
				<c:if test="${meetingRoom.availability eq 'false'}">
					<input type="radio" name="availability" value="true">가능
					<input type="radio" name="availability" value="false" checked="checked">불가능
				</c:if>	
			</div>
			<div>
				<label>지원설비</label>
				<c:forEach var="equipment" items="${equipmentList}">
					<input type="checkbox" name="equipmentId" value="${equipment.equipmentId}" id="${equipment.equipmentId}">${equipment.name}
					<c:forEach var="meetingRoomEquipment" items="${meetingRoomEquipmentList}" varStatus="status">
						<c:if test="${meetingRoomEquipment.equipmentName eq equipment.name}">
							<script>
								$("#${equipment.equipmentId}").attr("checked", "checked");
							</script>
						</c:if>
					</c:forEach>
				</c:forEach>
				<input type="hidden" name="checkTrue">
			</div>
			<div>
				<input type="hidden" name="meetingRoomId" value="${meetingRoom.meetingRoomId}">
				<input type="hidden" name="managerId" value="1">
				<input type="submit" value="수정">
			</div>
		</form>
		<button id="listManagement">목록</button>
	</section>
</body>
</html>