<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/insert.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/insert.js"></script>

<section class="width1200">
	<h1>회의실 등록</h1>
	<form id="insertMeetingRoomForm" method="post" action="/meetingRoom/insert">
		<div class="color_red float_right">* 필수입력</div>
		<div class="clear_both"></div>
		<table>
			<tr>
				<th>
					<label>회의실명 <span class="color_red display_inline">*</span></label>
				</th>
				<td>
					<input type="text" name="name" placeholder="회의실명을 입력해주세요.">
					<span class="color_red display_none">회의실명을 입력하세요.</span>
				</td>
			</tr>
			<tr>
				<th>
					<label>좌석수 <span class="color_red display_inline">*</span></label>
				</th>
				<td>
					<input type="text" name="seats" placeholder="좌석수를 입력해주세요.">
					<span class="color_red display_none">좌석수를 입력하세요.</span>
					<span class="color_red display_none">좌석수를 잘못 입력하셨습니다.</span>
				</td>
			</tr>
			<tr>
				<th>
					<label>예약가능여부 <span class="color_red display_inline">*</span></label>
				</th>
				<td>
					<label for="availabilityTrue"><input type="radio" name="availability" checked="checked" value="true" id="availabilityTrue">가능</label>
					<label for="availabilityFalse"><input type="radio" name="availability" value="false" id="availabilityFalse">불가능</label>
				</td>
			</tr>
			<tr>
				<th>
					<label>지원설비</label>
				</th>
				<td>
					<c:forEach var="equipment" items="${equipmentList}">
						<label for="${equipment.equipmentId}"><input type="checkbox" name="equipmentId" value="${equipment.equipmentId}" id="${equipment.equipmentId}">${equipment.name}</label>
					</c:forEach>
					<input type="hidden" name="checkTrue">
				</td>
			</tr>
		</table>
		<div class="float_right">
			<input type="hidden" name="managerId" value="${loginUser.user.employeeId}">
			<input type="submit" value="등록">
			<input type="button" value="취소" id="listMeetingRoom">
		</div>
	</form>
</section>
</body>
</html>