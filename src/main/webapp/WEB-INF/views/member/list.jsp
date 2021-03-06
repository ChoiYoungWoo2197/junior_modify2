<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/member/list.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common/page.js"></script>

<section class="width1200">
	<h1>회원 관리</h1>
	<div id="search" class="overflow_hidden">
		<div class="float_left">
			<select name="searchType">
				<option value="memberId" ${searchCriteria.searchType == 'memberId' ? 'selected' : ''}>사번</option>
				<option value="name" ${searchCriteria.searchType == 'name' ? 'selected' : ''}>사원명</option>
				<option value="department" ${searchCriteria.searchType == 'department' ? 'selected' : ''}>부서명</option>
			</select>
			<input type="search" name="searchContent" value="${searchCriteria.searchContent}"> &nbsp;
		</div>
		<img src="${pageContext.request.contextPath}/resources/images/search.png" id="searchMember" class="float_left icon_img">
		<%-- <img src="${pageContext.request.contextPath}/resources/images/list2.png" id="allMember" class="float_right icon_img"> --%>
	</div>
	<table id="listTable">
		<colgroup>
			<col width="80px" />
			<col width="180px" />
			<col width="140px" />
			<col width="140px" />
			<col width="450px" />
			<col width="160px" />
		</colgroup>
	
		<tr>
			<th>번호</th>
			<th>사번</th>
			<th>사원명</th>
			<th>부서</th>
			<th>이메일</th>
			<th>전화번호</th>
		</tr>
		<c:if test="${not empty employeeList}">
				<c:if test="${page.startPage == page.criteria.page}">
					<c:set var="listIndex" value="${employeeListSize}"/>
				</c:if>
				<c:if test="${page.startPage != page.criteria.page}">
					<c:set var="listIndex" value="${employeeListSize - (10*(page.criteria.page-1))}"/>
				</c:if>
				
				<c:forEach var="member" items="${employeeList}">
					<tr class="readMember">
						<td data-employeeId="${member.employeeId}">${listIndex}</td>
						<c:set var="listIndex" value="${listIndex-1}"/>
						<td class="readMemberId" data-memberId="${member.memberId}">${member.memberId}</td>
						<td >${member.name}</td>
						<td>${member.departmentId}</td>
						<td>${member.email}</td>
						<td>${member.phone}</td>
					</tr>
				</c:forEach>
		</c:if>
		
	</table>
	
	<div class="float_right"><button id="insertMember">회원등록</button></div>
	<div class="clear_both"></div>
	
	<div id="page">
		<ul class="pagination">
			<c:if test="${page.prev}">
				<li><a href="./list?page=${page.startPage-1}&searchType=${page.criteria.searchType}&searchContent=${searchContent}">&lt;</a></li>
			</c:if>
			<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
				<li><a href="./list?page=${index}&searchType=${page.criteria.searchType}&searchContent=${searchContent}">
				 		<c:if test="${page.criteria.page == index}">
							<span class="page_shape color_sky"></span>
						</c:if> <c:if test="${page.criteria.page != index}">
							<span class="page_shape"></span>
						</c:if>
				</a></li>
			</c:forEach>
			<c:if test="${page.next}">
				<li><a href="./list?page=${page.endPage+1}&searchType=${page.criteria.searchType}&searchContent=${searchContent}">&gt;</a></li>
			</c:if>
		</ul>
	</div>
</section>
</body>
</html>