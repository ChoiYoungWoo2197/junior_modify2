<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservation/list.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common/page.js"></script>

<section class="width1300">
	<h1>예약현황</h1>
	<div class="overflow_hidden">
		<div class="float_left">
			<label class="float_left">사용일</label>
			<input type="text" name="searchDate" id="searchStart" value="${searchCriteria.searchStart}" class="float_left">
			<img src="${pageContext.request.contextPath}/resources/images/calendar.png" id="startImg" class="float_left icon_img"> 
			<span class="float_left">~&nbsp;</span> 
			<input type="text" name="searchDate" id="searchEnd" value="${searchCriteria.searchEnd}" class="float_left">
			<img src="${pageContext.request.contextPath}/resources/images/calendar.png" id="endImg" class="float_left icon_img">
			<select name="state">
				<option value="none">상태</option>
				<option value="R" ${searchCriteria.state == 'R' ? 'selected' : ''}>예약(진행중)</option>
				<option value="RC" ${searchCriteria.state == 'RC' ? 'selected' : ''}>예약취소</option>
				<option value="E" ${searchCriteria.state == 'E' ? 'selected' : ''}>연장</option>
				<option value="F" ${searchCriteria.state == 'F' ? 'selected' : ''}>종료</option>
				<option value="FV" ${searchCriteria.state == 'FV' ? 'selected' : ''}>종료확인</option>
			</select>
			<select name="meetingRoomId">
				<option value="0">회의실</option>
				<c:forEach var="meetingRoom" items="${meetingRoomList}">
					<c:if test="${meetingRoom.meetingRoomId == searchCriteria.meetingRoomId}">
						<option value="${meetingRoom.meetingRoomId}" selected="selected">${meetingRoom.name}</option>
					</c:if>
					<c:if test="${meetingRoom.meetingRoomId != searchCriteria.meetingRoomId}">
						<option value="${meetingRoom.meetingRoomId}">${meetingRoom.name}</option>
					</c:if>
				</c:forEach>
			</select>
			<select name="searchType">
				<option value="department" ${searchCriteria.searchType == 'department' ? 'selected':''}>부서</option>
				<option value="employee" ${searchCriteria.searchType == 'employee' ? 'selected':''}>신청자</option>
				<option value="meetPurpose" ${searchCriteria.searchType == 'meetPurpose' ? 'selected':''}>회의목적</option>
			</select>
			<input type="search" name="searchContent" value="${searchCriteria.searchContent}">
		</div>
		<img src="${pageContext.request.contextPath}/resources/images/search.png" id="searchReservation" class="float_left icon_img">
		<!-- <button id="searchReservation">검색</button> -->
		<img src="${pageContext.request.contextPath}/resources/images/list2.png" id="allReservation" class="float_right icon_img">
		<!-- <button id="allReservation">전체보기</button> -->
	</div>
	<table id="listTable">
		<colgroup>
			<col width="70px" />
			<col width="130px" />
			<col width="160px" />
			<col width="100px" />
			<col width="120px" />
			<col width="*" />
			<col width="180px" />
			<col width="180px" />
		</colgroup>
		<tr>
			<th>번호</th>
			<th>회의일자</th>
			<th>사용시간</th>
			<th>상태</th>
			<th>회의실</th>
			<th>회의목적</th>
			<th>신청자</th>
			<th>신청일시</th>
		</tr>
		<c:if test="${empty reservationList}">
			<tr>
				<td colspan="8">예약내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${!empty reservationList}">
			<c:if test="${page.startPage == page.criteria.page}">
				<c:set var="listIndex" value="${page.total}"/>
			</c:if>
			<c:if test="${page.startPage != page.criteria.page}">
				<c:set var="listIndex" value="${page.total - (10*(page.criteria.page-1))}"/>
			</c:if>
			<c:forEach var="reservation" items="${reservationList}">
				<tr class="updateReservation">
					<td class="readReservation" data-reservationId="${reservation.reservationId}">${listIndex}</td>
					<c:set var="listIndex" value="${listIndex-1}"/>
					<td><fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd"/></td>
					<td><fmt:formatDate value="${reservation.startDate}" pattern="kk:mm"/> ~ <fmt:formatDate value="${reservation.actualEndDate}" pattern="kk:mm"/></td>
					<td>
						<c:choose>
							<c:when test="${reservation.state == 'R'}">
								<jsp:useBean id="now" class="java.util.Date" />
								${now < reservation.startDate == 'true'? '예약':'진행중'}
							</c:when>
							<c:when test="${reservation.state == 'RC'}">
								예약취소
							</c:when>
							<c:when test="${reservation.state == 'E'}">
								연장
							</c:when>
							<c:when test="${reservation.state == 'F'}">
								종료
							</c:when>
							<c:when test="${reservation.state == 'FV'}">
								종료확인
							</c:when>
						</c:choose>
					</td>
					<td>${reservation.meetingRoomName}</td>
					<td>${reservation.meetPurpose}</td>
					<td>${reservation.employeeName}(${reservation.departmentName})</td>
					<td><fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm"/></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div class="clear_both"></div>
	<button id="insertReservation" class="float_right">예약등록</button>
	<div class="clear_both"></div>
	
	<div id="page">
		<ul class="pagination">
			<c:if test="${page.prev}">
				<li>
					<a href='javascript:paging("list?page=${page.startPage-1}&searchType=${page.criteria.searchType}&searchContent=${page.criteria.searchContent}")'>&lt;</a>
				</li>
			</c:if>
			<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
				<li>					
					<a href='javascript:paging("list?page=${index}&searchType=${page.criteria.searchType}&searchContent=${page.criteria.searchContent}")'>
						<c:if test="${page.criteria.page == index}">
							<span class="page_shape color_sky"></span>
						</c:if>
						<c:if test="${page.criteria.page != index}">
							<span class="page_shape"></span>
						</c:if>
					</a>
				</li>
			</c:forEach>
			<c:if test="${page.next}">
				<li>					
					<a href='javascript:paging("list?page=${page.startPage-1}&searchType=${page.criteria.searchType}&searchContent=${page.criteria.searchContent}")'>&gt;</a>
				</li>
			</c:if>
		</ul>
	</div>
</section>
</body>
</html>