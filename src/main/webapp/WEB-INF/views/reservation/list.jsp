<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<style>
	td, th {
		border: 1px solid black;
	}
	table {
		border-collapse: collapse;
		width: 100%;
	}
	
	/* ----------------- 페이지 ----------------- */
	#page {
		text-align: center;
		margin-top: 20px;
	}
	.pagination li {
		width: 20px;
		list-style: none;
		display: inline-block;
	}
	.color_sky {
		background-color: #6799FF !important;
	}
	.page_shape {
		background-color: rgb(189, 189, 189);
		width: 10px;
		height: 10px;
		border-radius: 5px;
		display: inline-block;
	}
</style>

<script>
	$(function() {
		$("#insertReservation").click(function() {
			location.href = "insert";
		})
		
		$(document).on("click", ".updateReservation", function(){
			var reservationId = Number($(this).find(".readReservation").text());
			location.href = "${pageContext.request.contextPath}/reservationDetail/read?reservationId="+ reservationId;
		})
		
		$("#searchReservation").click(function() {
			if($("#searchStart").val()!="" || $("#searchEnd").val()!="") {
				if($("#searchStart").val() > $("#searchEnd").val()!="") {
					alert("기간을 잘못 선택하셨습니다.");
					return false;
				}
				location.href="list?page=1&searchStart="+$("#searchStart").val()+"&searchEnd="+$("#searchEnd").val();
				return false;
			}
			
			if($("select[name='state']").val()!="none") {
				location.href = "list?page=1&state="+$("select[name='state']").val();
				return false;
			}
			
			if($("select[name='meetingRoomId']").val()!="0") {
				location.href = "list?page=1&meetingRoomId="+$("select[name='meetingRoomId']").val();
				return false;
			}
			
			if($("input[name='searchContent']").val()=="" && $("select[name='state']").val()=="none") {
				alert("검색할 내용을 입력해주세요.");
				return false;
			}
			
			location.href = "list?page=1&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val();
		})
		
		$("#allReservation").click(function() {
			location.href = "list";
		})
	})
</script>	
	
	<section class="width1200">
		<div>
			<label>사용일</label>
			<input type="date" name="searchDate" id="searchStart" value="${searchCriteria.searchStart}"> ~ 
			<input type="date" name="searchDate" id="searchEnd" value="${searchCriteria.searchEnd}">
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
				<option value="department">부서</option>
				<option value="employee">신청자</option>
				<option value="meetPurpose">회의목적</option>
			</select>
			<input type="text" name="searchContent" value="${searchCriteria.searchContent}">
			<button id="searchReservation">검색</button>
			<button id="allReservation">전체보기</button>
		</div>
		<table>
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
				<c:forEach var="reservation" items="${reservationList}">
					<tr class="updateReservation">
						<td class="readReservation">${reservation.reservationId}</td>
						<td><fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd"/></td>
						<td><fmt:formatDate value="${reservation.startDate}" pattern="kk:mm"/> ~ <fmt:formatDate value="${reservation.endDate}" pattern="kk:mm"/></td>
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
		<button id="insertReservation">예약등록</button>
		
		<div id="page">
			<ul class="pagination">
				<c:if test="${page.prev}">
					<li>
						<a href="list?page=${page.startPage-1}&searchContent=${page.criteria.searchContent}">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
					<li>
						<a href="list?page=${index}&searchContent=${page.criteria.searchContent}">
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
						<a href="list?page=${page.endPage+1}&searchContent=${page.criteria.searchContent}">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
	</section>
</body>
</html>