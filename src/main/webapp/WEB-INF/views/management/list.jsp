<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/common/list.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/management/list.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common/page.js"></script>

<section class="width1200">
	<c:if test="${management eq 'equipment'}">
		<c:set var="title" value="장비"/>
	</c:if>
	<c:if test="${management eq 'department'}">
		<c:set var="title" value="부서"/>
	</c:if>
	
	<h1>${title}관리</h1>
	<div class="overflow_hidden">
		<div class="float_left">
			<input type="search" name="searchContent" value="${searchCriteria.searchContent}">&nbsp;
		</div>
		<!-- <button id="searchManagement">검색</button> -->
		<img src="${pageContext.request.contextPath}/resources/images/search.png" id="searchManagement" class="float_left">
		<!-- <button id="AllManagement">전체보기</button> -->
		<img src="${pageContext.request.contextPath}/resources/images/list2.png" id="AllManagement" class="float_right">
	</div>
	<c:if test="${management eq 'equipment'}">
		<table>
			<c:if test="${empty equipmentList}">
				<tr>
					<th>번호</th>
					<th>장비명</th>
					<th>등록일시</th>
				</tr>
				<tr>
					<td colspan="3">내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty equipmentList}">
				<colgroup>
					<col width="120px" />
					<col width="*" />
					<col width="200px" />
					<col width="170px" />
				</colgroup>
				<tr>
					<th>번호</th>
					<th>장비명</th>
					<th>등록일시</th>
					<th></th>
				</tr>
				<c:if test="${page.startPage == page.criteria.page}">
					<c:set var="listIndex" value="${page.total}"/>
				</c:if>
				<c:if test="${page.startPage != page.criteria.page}">
					<c:set var="listIndex" value="${page.total - (10*(page.criteria.page-1))}"/>
				</c:if>
				<c:forEach var="equipment" items="${equipmentList}">
					<tr class="updateManagement">
						<td class="readManagement" data-managementId="${equipment.equipmentId}">${listIndex}</td>
						<c:set var="listIndex" value="${listIndex-1}"/>
						<td>${equipment.name}</td>
						<td><fmt:formatDate value="${equipment.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
						<td class="noEvent"><button class="deleteManagement" data-managementId="${equipment.equipmentId}">삭제</button></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button id="insertManagement" class="float_right">장비등록</button>
	</c:if>
	<c:if test="${management eq 'department'}">
		<table>
			<c:if test="${empty employeeByDepartmentList}">
				<tr>
					<th>번호</th>
					<th>부서명</th>
					<th>사원수</th>
					<th>등록일시</th>
				</tr>
				<tr>
					<td colspan="4">내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty employeeByDepartmentList}">
				<colgroup>
					<col width="120px" />
					<col width="*" />
					<col width="230px" />
					<col width="200px" />
					<col width="170px" />
				</colgroup>
				<tr>
					<th>번호</th>
					<th>부서명</th>
					<th>사원수</th>
					<th>등록일시</th>
					<th></th>
				</tr>
				<c:if test="${page.startPage == page.criteria.page}">
					<c:set var="listIndex" value="${page.total}"/>
				</c:if>
				<c:if test="${page.startPage != page.criteria.page}">
					<c:set var="listIndex" value="${page.total - (10*(page.criteria.page-1))}"/>
				</c:if>
				<c:forEach var="department" items="${employeeByDepartmentList}">
					<tr class="updateManagement">
						<td class="readManagement"  data-managementId="${department.departmentId}">${listIndex}</td>
						<c:set var="listIndex" value="${listIndex-1}"/>
						<td>${department.name}</td>
						<td>${department.emoloyeeCount}명</td>
						<td><fmt:formatDate value="${department.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
						<td class="noEvent"><button class="deleteManagement" data-managementId="${department.departmentId}">삭제</button></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button id="insertManagement" class="float_right">부서등록</button>
	</c:if>
	
	<div class="clear_both"></div>
	
	<form id="deleteForm">
		<input type="hidden" name="managementId">
		<input type="hidden" name="management" value="${management}">
	</form>
	
	<div id="page">
		<ul class="pagination">
			<c:if test="${page.prev}">
				<li>
					<a href='javascript:paging("list?management=${management}&page=${page.startPage-1}&searchContent=${page.criteria.searchContent}")'>&lt;</a>
				</li>
			</c:if>
			<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
				<li>
					<a href='javascript:paging("list?management=${management}&page=${index}&searchContent=${page.criteria.searchContent}")'>
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
					<a href='javascript:paging("list?management=${management}&page=${page.endPage+1}&searchContent=${page.criteria.searchContent}")'>&gt;</a>
				</li>
			</c:if>
		</ul>
	</div>
</section>
</body>
</html>