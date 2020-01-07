<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
	.color_red {
		color: red;
		font-size: 14px;
	}
	.display_none {
		display: none;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/insert.js"></script>
<!-- <script>
	$(function() {
		$("#listMeetingRoom").click(function() {
			location.href = "list";
		})
		
		$("#insertMeetingRoomForm").submit(function() {
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
</script> -->

	<section class="width1200">
		<form id="insertMeetingRoomForm" method="post" action="/meetingRoom/insert">
			<div class="color_red">* 필수입력</div>
			<div>
				<label>회의실명 <span class="color_red">*</span></label>
				<input type="text" name="name" placeholder="회의실명을 입력해주세요.">
				<span class="color_red display_none">회의실명을 입력하세요.</span>
			</div>
			<div>
				<label>좌석수 <span class="color_red">*</span></label>
				<input type="text" name="seats" placeholder="좌석수를 입력해주세요.">
				<span class="color_red display_none">좌석수를 입력하세요.</span>
				<span class="color_red display_none">좌석수를 잘못 입력하셨습니다.</span>
			</div>
			<div>
				<label>예약가능여부 <span class="color_red">*</span></label>
				<label for="availabilityTrue"><input type="radio" name="availability" checked="checked" value="true" id="availabilityTrue">가능</label>
				<label for="availabilityFalse"><input type="radio" name="availability" value="false" id="availabilityFalse">불가능</label>
			</div>
			<div>
				<label>지원설비</label>
				<c:forEach var="equipment" items="${equipmentList}">
					<label for="${equipment.equipmentId}"><input type="checkbox" name="equipmentId" value="${equipment.equipmentId}" id="${equipment.equipmentId}">${equipment.name}</label>
				</c:forEach>
				<input type="hidden" name="checkTrue">
			</div>
			<div>
				<input type="hidden" name="managerId" value="${loginUser.user.employeeId}">
				<input type="submit" value="등록">
			</div>
		</form>
		<button id="listMeetingRoom">목록</button>
	</section>
</body>
</html>