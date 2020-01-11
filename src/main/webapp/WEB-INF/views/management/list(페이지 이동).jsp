<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/standard.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/management/list.js"></script>
<!-- <script>
	$(function() {
		$("#insertManagement").click(function() {
			location.href = "insert?management="+$("input[name=management]").val();
		})
		
		$("table tr").each(function() {
			$(".deleteManagement").on('click',function(e){
				e.stopImmediatePropagation(); //삭제버튼에서는 updateManagement클래스가 적용안되게 막음.
				var result = confirm("삭제하시겠습니까?");
				var managementId = Number($(this).attr("data-managementId"));
				var deleteAvailable = true;
				
				if(result == true) {
					if($("input[name=management]").val() == "department") {
						$.ajax({
							url : "/management/countEmp?managementId="+managementId,
							type : "get",
							dataType : "text",
							async: false,
							/*
							ajax는 비동기식이기 때문에 다른 호출을 먼저 할 수도 있다(ajax가 완료된것을 기다려주지 않음).
							비동기식인 ajax를 동기식으로 설정해줘야 함 => async: false
							*/
							success : function(res) {
								console.log(res);
								if(res == "false") {
									alert("소속된 사원이 존재하여 삭제할 수 없습니다.");
									deleteAvailable = false;
								}
							}
						})
					}
					
					if(deleteAvailable) {
						$("input[name='managementId']").val(managementId);
						$("#deleteForm").attr("action", "delete").attr("method", "post");
						$("#deleteForm").submit();
					}
				}
				
			})
		})
		
		$(document).on("click", ".updateManagement", function(){
			var managementId = Number($(this).find(".readManagement").attr("data-managementId"));
			
			var result = confirm("수정하시겠습니까?");
			
			if(result == true) { 
				location.href = "modify?management="+$("input[name=management]").val()+"&managementId="+managementId;
			}
			
		})
		
		$("#searchManagement").click(function() {
			if($("input[name='searchContent']").val()=="") {
				alert("검색할 내용을 입력해주세요.");
				return false;
			}
			
			location.href = "list?management="+$("input[name=management]").val()+"&page=1&searchContent="+$("input[name='searchContent']").val();
		})
		
		$("#AllManagement").click(function() {
			location.href = "list?management="+$("input[name=management]").val();
		})
	})
</script> -->

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