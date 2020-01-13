<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/meetingRoom/list.js"></script>

	<section class="width1200">
		<h1>회의실 관리</h1>
		<div class="overflow_hidden">
			<div class="float_left">
				<select name="searchType">
					<option value="meetingRoom" ${searchCriteria.searchType == 'meetingRoom' ? 'selected' : ''}>회의실</option>
					<option value="equipment" ${searchCriteria.searchType == 'equipment' ? 'selected' : ''}>지원장비</option>
				</select>
				<input type="search" name="searchContent" value="${searchCriteria.searchContent}">&nbsp;
			</div>
			<!-- <button id="searchEquipment">검색</button> -->
			<img src="${pageContext.request.contextPath}/resources/images/search.png" id="searchManagement" class="float_left">
			<!-- <button id="allMeetingRoom">전체보기</button> -->
			<img src="${pageContext.request.contextPath}/resources/images/list2.png" id="allMeetingRoom" class="float_right">
		</div>
		<table>
			<tr>
				<th>번호</th>
				<th>회의실</th>
				<th>좌석수</th>
				<th>지원장비</th>
				<th>예약가능여부</th>
				<c:if test="${loginUser.manager eq 'true'}">
					<th>등록일시</th>
				</c:if>
			</tr>
			<c:if test="${empty meetingRoomList}">
				<tr>
					<td colspan="6">내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty meetingRoomList}">
				<c:if test="${page.startPage == page.criteria.page}">
					<c:set var="listIndex" value="${page.total}"/>
				</c:if>
				<c:if test="${page.startPage != page.criteria.page}">
					<c:set var="listIndex" value="${page.total - (10*(page.criteria.page-1))}"/>
				</c:if>
				<c:forEach var="meetingRoom" items="${meetingRoomList}">
					<tr class="updateMeetingRoom">
						<td class="readMeetingRoom" data-meetingRoomId="${meetingRoom.meetingRoomId}">${listIndex}</td>
						<c:set var="listIndex" value="${listIndex-1}"/>
						<td>${meetingRoom.name}</td>
						<td>${meetingRoom.seats}</td>
						<td>${meetingRoom.meetingRoomEquipmenet}</td>
						<td>${meetingRoom.availability eq "true" ? "가능" : "불가능"}</td>
						<c:if test="${loginUser.manager eq 'true'}">
							<td><fmt:formatDate value="${meetingRoom.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<c:if test="${loginUser.manager eq 'true'}">
			<button id="insertMeetingRoom" class="float_right">회의실등록</button>
		</c:if>
		
		<div class="clear_both"></div>
		
		<div id="page">
			<ul class="pagination">
				<c:if test="${page.prev}">
					<li>
						<a href="list?page=${page.startPage-1}&searchType=${page.criteria.searchType}&searchContent=${page.criteria.searchContent}">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
					<li>
						<a href="list?page=${index}&searchType=${page.criteria.searchType}&searchContent=${page.criteria.searchContent}">
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
						<a href="list?page=${page.endPage+1}&searchType=${page.criteria.searchType}&searchContent=${page.criteria.searchContent}">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
	</section>
</body>
</html>