<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>

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
		$("#insertMember").click(function() {
			location.href = "${pageContext.request.contextPath}/member/insert";
		})

		$("#searchEquipment").click(function() {
			if ($("input[name='searchContent']").val() == "") {
				alert("검색할 내용을 입력해주세요.");
				return false;
			}

			location.href = "list?page=1&searchType=" + $("select[name='searchType']").val()+ "&searchContent="+ $("input[name='searchContent']").val();
		})

		$(document).on("click", ".readMember", function() {
			var memberId = Number($(this).prev().text());
			location.href = "read?memberId=" + memberId;
		})
		
		$("#AllMeetingRoom").click(function() {
			location.href = "list";
		})

	})
</script>

<section class="width1200">
	<h1>회원 관리</h1>
	<div>
		<select name="searchType">
			<option value="memberId" ${searchCriteria.searchType == 'memberId' ? 'selected' : ''}>사번</option>
			<option value="name"  ${searchCriteria.searchType == 'name' ? 'selected' : ''}>사원명</option>
			<option value="department" ${searchCriteria.searchType == 'department' ? 'selected' : ''}>부서</option>
		</select> <input type="text" name="searchContent" value="${searchCriteria.searchContent}">
		<button id="searchEquipment">검색</button>
		<button id="AllMeetingRoom">전체보기</button>
	</div>
	<table>
		<tr>
			<th>No.</th>
			<th>사번</th>
			<th>사원명</th>
			<th>부서</th>
			<th>이메일</th>
			<th>전화번호</th>
		</tr>
		<c:forEach var="member" items="${employeeList}">
			<tr>
				<td>${member.employeeId}</td>
				<td>${member.memberId}</td>
				<td class="readMember">${member.name}</td>
				<td>${member.departmentId}</td>
				<td>${member.email}</td>
				<td>${member.phone}</td>
			</tr>
		</c:forEach>
	</table>
	<button id="insertMember">회원등록</button>

	<div id="page">
		<ul class="pagination">
			<c:if test="${page.prev}">
				<li><a
					href="list?management=${management}&page=${page.startPage-1}&searchContent=${page.criteria.searchContent}">&lt;</a>
				</li>
			</c:if>
			<c:forEach var="index" begin="${page.startPage}"
				end="${page.endPage}">
				<li><a
					href="list?management=${management}&page=${index}&searchContent=${page.criteria.searchContent}">
						<c:if test="${page.criteria.page == index}">
							<span class="page_shape color_sky"></span>
						</c:if> <c:if test="${page.criteria.page != index}">
							<span class="page_shape"></span>
						</c:if>
				</a></li>
			</c:forEach>
			<c:if test="${page.next}">
				<li><a
					href="list?management=${management}&page=${page.endPage+1}&searchContent=${page.criteria.searchContent}">&gt;</a>
				</li>
			</c:if>
		</ul>
	</div>
</section>
</body>
</html>