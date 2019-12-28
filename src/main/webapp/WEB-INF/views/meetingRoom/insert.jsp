<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<style>
	.color_red {
		display: none;
		color: red;
		font-size: 14px;
	}
</style>
<script>
	$(function() {
		$("#insertMeetingRoomForm").submit(function() {
			var check = true;
			$(".color_red").css("display", "none");
			
			if($("input[name='name']").val() == "") {
				$("input[name='name']").next().css("display", "block");
				check = false;
			}
			
			if($("input[name='seats']").val() == "") {
				$("input[name='seats']").next().css("display", "block");
				check = false;
			}
			
			if(Number($("input[name='seats']").val()) <= 0) {
				$("input[name='seats']").next().next().css("display", "block");
	        	check = false;
	        }
	        
	        if(Number($("input[name='seats']").val()) != $("input[name='seats']").val()) {
	        	$("input[name='seats']").next().next().css("display", "block");
	        	check = false;
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
		<form id="insertMeetingRoomForm" method="post" action="/meetingRoom/insert">
			<div>
				<label>회의실명</label>
				<input type="text" name="name" placeholder="회의실명을 입력해주세요.">
				<span class="color_red">회의실명을 입력하세요.</span>
			</div>
			<div>
				<label>좌석수</label>
				<input type="text" name="seats" placeholder="좌석수를 입력해주세요.">
				<span class="color_red">좌석수를 입력하세요.</span>
				<span class="color_red">좌석수를 잘못 입력하셨습니다.</span>
			</div>
			<div>
				<label>예약가능여부</label>
				<input type="radio" name="availability" checked="checked" value="true">가능
				<input type="radio" name="availability" value="false">불가능
			</div>
			<div>
				<label>지원설비</label>
				<c:forEach var="equipment" items="${equipmentList}">
					<input type="checkbox" name="equipmentId" value="${equipment.equipmentId}">${equipment.name}
				</c:forEach>
				<input type="hidden" name="managerId" value="1">
				<input type="hidden" name="checkTrue">
			</div>
			<div>
				<input type="submit" value="등록">
			</div>
		</form>
	</section>
</body>
</html>