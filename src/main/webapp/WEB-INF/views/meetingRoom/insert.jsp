<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/meetingRoom/insert.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/insert.js"></script>

<section class="width1200">
	<form id="insertMeetingRoomForm" method="post" action="/meetingRoom/insert">
		<div class="color_red float_right">* 필수입력</div>
		<div class="clear_both"></div>
		<table>
			<tr>
				<td>
					<label>회의실명 <span class="color_red">*</span></label>
				</td>
				<td>
					<input type="text" name="name" placeholder="회의실명을 입력해주세요.">
					<span class="color_red display_none">회의실명을 입력하세요.</span>
				</td>
			</tr>
			<tr>
				<td>
					<label>좌석수 <span class="color_red">*</span></label>
				</td>
				<td>
					<input type="text" name="seats" placeholder="좌석수를 입력해주세요.">
					<span class="color_red display_none">좌석수를 입력하세요.</span>
					<span class="color_red display_none">좌석수를 잘못 입력하셨습니다.</span>
				</td>
			</tr>
			<tr>
				<td>
					<label>예약가능여부 <span class="color_red">*</span></label>
				</td>
				<td>
					<label for="availabilityTrue"><input type="radio" name="availability" checked="checked" value="true" id="availabilityTrue">가능</label>
					<label for="availabilityFalse"><input type="radio" name="availability" value="false" id="availabilityFalse">불가능</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>지원설비</label>
				</td>
				<td>
					<c:forEach var="equipment" items="${equipmentList}">
						<label for="${equipment.equipmentId}"><input type="checkbox" name="equipmentId" value="${equipment.equipmentId}" id="${equipment.equipmentId}">${equipment.name}</label>
					</c:forEach>
					<input type="hidden" name="checkTrue">
				</td>
			</tr>
		</table>
		<input type="button" value="목록" id="listMeetingRoom">
		<div class="float_right">
			<input type="hidden" name="managerId" value="${loginUser.user.employeeId}">
			<input type="submit" value="등록">
		</div>
	</form>
</section>
</body>
</html>