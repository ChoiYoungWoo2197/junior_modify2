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
		$("#insertMeetingRoom").click(function() {
			location.href = "insert";
		})
		
		$(document).on("click", ".updateMeetingRoom", function(){
			var meetingRoomId = Number($(this).prev().text());
			
			location.href = "read?meetingRoomId="+meetingRoomId;
		})
		
		$("#searchEquipment").click(function() {
			if($("input[name='searchContent']").val()=="") {
				alert("검색할 내용을 입력해주세요.");
				return false;
			}
			
			location.href = "list?page=1&searchType="+$("select[name='searchType']").val()+"&searchContent="+$("input[name='searchContent']").val();
		})
		
		$("#AllMeetingRoom").click(function() {
			location.href = "list";
		})
	})
</script>
	<section class="width1200">
		<div>
			<select name="searchType">
				<option value="meetingRoom" ${searchCriteria.searchType == 'meetingRoom' ? 'selected' : ''}>회의실</option>
				<option value="equipment" ${searchCriteria.searchType == 'equipment' ? 'selected' : ''}>지원장비</option>
			</select>
			<input type="text" name="searchContent" value="${searchCriteria.searchContent}">
			<button id="searchEquipment">검색</button>
			<button id="AllMeetingRoom">전체보기</button>
		</div>
		<table>
			<tr>
				<th>번호</th>
				<th>회의실</th>
				<th>좌석수</th>
				<th>예약가능여부</th>
				<th>지원장비</th>
				<th>등록일시</th>
			</tr>
			<c:if test="${empty meetingRoomList}">
				<tr>
					<td colspan="6">내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty meetingRoomList}">
				<c:forEach var="meetingRoom" items="${meetingRoomList}">
					<tr>
						<td>${meetingRoom.meetingRoomId}</td>
						<td class="updateMeetingRoom">${meetingRoom.name}</td>
						<td>${meetingRoom.seats}</td>
						<td>${meetingRoom.availability eq "true" ? "가능" : "불가능"}</td>
						<td>${meetingRoom.meetingRoomEquipmenet}</td>
						<td><fmt:formatDate value="${meetingRoom.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button id="insertMeetingRoom">회의실등록</button>
		
		<div id="page">
			<ul class="pagination">
				<c:if test="${page.prev}">
					<li>
						<a href="list?management=${management}&page=${page.startPage-1}&searchContent=${page.criteria.searchContent}">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
					<li>
						<a href="list?management=${management}&page=${index}&searchContent=${page.criteria.searchContent}">
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
						<a href="list?management=${management}&page=${page.endPage+1}&searchContent=${page.criteria.searchContent}">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
	</section>
</body>
</html>