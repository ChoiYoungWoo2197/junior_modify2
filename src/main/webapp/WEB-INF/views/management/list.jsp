<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		$("#insertManagement").click(function() {
			location.href = "insert?mgt="+$("input[name=mgt]").val();
		})
		
		$(document).on("click", ".updateManagement", function(){
			var managementId = Number($(this).attr("data-managementId"));
			
			var result = confirm("수정하시겠습니까?");
			
			if(result == true) { 
				location.href = "modify?mgt="+$("input[name=mgt]").val()+"&managementId="+managementId;
			}
			
		})
		
		$(document).on("click", ".deleteManagement", function(){
			var result = confirm("삭제하시겠습니까?");
			
			if(result == true) {
				if($("input[name=mgt]").val() == "department") {
					if($(this).parent().prev().prev().text() != "0") {
						alert("소속된 사원이 존재하여 삭제할 수 없습니다.");
						return false;
					}
				}
				
				var managementId = Number($(this).attr("data-managementId"));
				$("input[name='managementId']").val(managementId);
				$("#deleteForm").attr("action", "delete").attr("method", "post");
				$("#deleteForm").submit();
			}
		})
		
		$("#searchEquipment").click(function() {
			if($("input[name='searchContent']").val()=="") {
				alert("검색할 내용을 입력해주세요.");
				return false;
			}
			
			location.href = "list?mgt="+$("input[name=mgt]").val()+"&page=1&searchContent="+$("input[name='searchContent']").val();
		})
		
		$("#AllEquipment").click(function() {
			location.href = "list?mgt="+$("input[name=mgt]").val();
		})
	})
</script>

	<section class="width1200">
		<c:if test="${mgt eq 'equipment'}">
			<c:set var="title" value="장비"/>
		</c:if>
		<c:if test="${mgt eq 'department'}">
			<c:set var="title" value="부서"/>
		</c:if>
		
		<h1>${title}관리</h1>
		<div>
			<input type="text" name="searchContent" value="${criteria.searchContent}">
			<button id="searchEquipment">검색</button>
			<button id="AllEquipment">전체보기</button>
		</div>
		<c:if test="${mgt eq 'equipment'}">
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
					<c:forEach var="equipment" items="${equipmentList}">
						<tr>
							<td>${equipment.equipmentId}</td>
							<td class="updateManagement" data-managementId="${equipment.equipmentId}">${equipment.name}</td>
							<td><fmt:formatDate value="${equipment.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
							<td><button class="deleteManagement" data-managementId="${equipment.equipmentId}">삭제</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<button id="insertManagement">장비등록</button>
		</c:if>
		<c:if test="${mgt eq 'department'}">
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
					<c:forEach var="department" items="${employeeByDepartmentList}">
						<tr>
							<td>${department.departmentId}</td>
							<td class="updateManagement" data-managementId="${department.departmentId}">${department.name}</td>
							<td>${department.emoloyeeCount}</td>
							<td><fmt:formatDate value="${department.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
							<td><button class="deleteManagement" data-managementId="${department.departmentId}">삭제</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<button id="insertManagement">부서등록</button>
		</c:if>
		
		<form id="deleteForm">
			<input type="hidden" name="managementId">
			<input type="hidden" name="mgt" value="${mgt}">
		</form>
		
		<div id="page">
			<ul class="pagination">
				<c:if test="${page.prev}">
					<li>
						<a href="list?mgt=${mgt}&page=${page.startPage-1}&searchContent=${page.criteria.searchContent}">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="index" begin="${page.startPage}" end="${page.endPage}">
					<li>
						<a href="list?mgt=${mgt}&page=${index}&searchContent=${page.criteria.searchContent}">
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
						<a href="list?mgt=${mgt}&page=${page.endPage+1}&searchContent=${page.criteria.searchContent}">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
	</section>
</body>
</html>