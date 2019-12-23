<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/managerHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>departMent test</title>
<style>
	table {
		width: 100%;
	}
	
	table, th, td {
		border: 1px solid #bcbcbc;
	}
	
	function rowDel (obj ) {var tr = obj.parentNode.parentNode;tr
		.parentNode.removeChild(tr);
		
	}

	#insertDepartMentDiv {
		display: none;
	}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#insertDepartMent").click(function() {
			$("#insertDepartMentDiv").css("display","block");
			$("input[name='departmentName']").val("");
			$("#insert").css("display","inline");
			$("#update").css("display","none");
		})
		
		$("#insert").click(function() {
			if($("input[name='departmentName']").val()=="") {
				alert("부서명을 입력하세요");
				return false;
			}
			
			
			$.ajax({
				url: "${pageContext.request.contextPath}/department/insert",
				type: "post",
				data: {"departmentName":$("input[name='departmentName']").val()},
				success: function(res) {
					$("#tableDepartment").empty();
					$("#tableDepartment").append("<tr>" +
												 "<th>번호</th>" + 
							                     "<th>부서명</th>" +
							                     "<th>총인원</th>" +
							                     "<th>등록일시</th>" +
							                     "<th></th>" +
							                     "</tr>");
					
					$(res).each(function(i, obj) {					
						var register_date = new Date(obj.registerDate);
						var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
											register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
						 
						var $tr = $("<tr>");
						var $departmentId = $("<td>").text(obj.departmentId);
						var $name = $("<td>").addClass("updateDepartment").attr("data-departmentId", obj.departmentId).text(obj.name);
						var $account = $("<td>").text(obj.account);
						var $registerDate = $("<td>").text(registerDate);
						var $button = $("<button>").addClass("deleteDepartment").attr("data-departmentId", obj.departmentId).text("삭제");
						var $buttonWrap = $("<td>").append($button);
						
						$tr.append($departmentId).append($name).append($account).append($registerDate).append($buttonWrap);
						$("#tableDepartment").append($tr);
					})
					
					
					$("#insertDepartMentDiv").css("display","none");
					$("input[name='departmentName']").val("");
				}
			})
		})
		
	    $(document).on("click", ".deleteDepartment", function(){
			$("#insertDepartMentDiv").css("display","none");
			
			var result = confirm("선택하신 장비를 삭제하시겠습니까?");
			
			if(result == true) {
				var departmentId = $(this).attr("data-departmentId");
				
				$.ajax({
					url: "${pageContext.request.contextPath}/department/delete",
					type: "post",
					data: {"departmentId":Number(departmentId)},
					success: function(res) {
					 
						$("#tableDepartment").empty();
						$("#tableDepartment").append("<tr>" +
													 "<th>번호</th>" + 
								                     "<th>부서명</th>" +
								                     "<th>총인원</th>" +
								                     "<th>등록일시</th>" +
								                     "<th></th>" +
								                     "</tr>");
						
						$(res).each(function(i, obj) {			
							var register_date = new Date(obj.registerDate);
							var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
												register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
							 
							var $tr = $("<tr>");
							var $departmentId = $("<td>").text(obj.departmentId);
							var $name = $("<td>").addClass("updateDepartment").attr("data-departmentId", obj.departmentId).text(obj.name);
							var $account = $("<td>").text(obj.account);
							var $registerDate = $("<td>").text(registerDate);
							var $button = $("<button>").addClass("deleteDepartment").attr("data-departmentId", obj.departmentId).text("삭제");
							var $buttonWrap = $("<td>").append($button);
							
							$tr.append($departmentId).append($name).append($account).append($registerDate).append($buttonWrap);
							$("#tableDepartment").append($tr);
						})
					}
				})
			}
		})
		
	    $(document).on("click", ".updateDepartment", function(){
			$("#insertDepartMentDiv").css("display","block");
			
			$("input[name='departmentName']").val($(this).text());
			$("#update").css("display","inline");
			$("#insert").css("display","none");
			
			var departmentId = $(this).attr("data-departmentId");
			
			$("#update").click(function() {
				var result = confirm("부서를 수정하시겠습니까?");
				if(result == true) { 
					$.ajax({
						url: "${pageContext.request.contextPath}/department/update",
						type: "post",
						data: {"departmentId":Number(departmentId), "updateName":$("input[name='departmentName']").val()},
						dataType:"json",
						success: function(res) {
							$("#tableDepartment").empty();
							$("#tableDepartment").append("<tr>" +
														 "<th>번호</th>" + 
									                     "<th>부서명</th>" +
									                     "<th>총인원</th>" +
									                     "<th>등록일시</th>" +
									                     "<th></th>" +
									                     "</tr>"); 
							$(res).each(function(i, obj) {		
								var register_date = new Date(obj.registerDate);
								var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
													register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
								 
								var $tr = $("<tr>");
								var $departmentId = $("<td>").text(obj.departmentId);
								var $name = $("<td>").addClass("updateDepartment").attr("data-departmentId", obj.departmentId).text(obj.name);
								var $account = $("<td>").text(obj.account);
								var $registerDate = $("<td>").text(registerDate);
								var $button = $("<button>").addClass("deleteDepartment").attr("data-departmentId", obj.departmentId).text("삭제");
								var $buttonWrap = $("<td>").append($button);
								
								$tr.append($departmentId).append($name).append($account).append($registerDate).append($buttonWrap);
								$("#tableDepartment").append($tr);
							})
						}
					})
				}
			})
		})
		
		$(document).on("click", "#searchDepartMent", function(){
			var search = $("input[name='searchName']").val();
			$.ajax({
				url: "${pageContext.request.contextPath}/department/search",
				type: "post",
				data: {"searchName":$("input[name='searchName']").val()},
				success: function(res) {
					$("#tableDepartment").empty();
					$("#tableDepartment").append("<tr>" +
												 "<th>번호</th>" + 
							                     "<th>부서명</th>" +
							                     "<th>총인원</th>" +
							                     "<th>등록일시</th>" +
							                     "<th></th>" +
							                     "</tr>"); 
					$(res).each(function(i, obj) {		
						var register_date = new Date(obj.registerDate);
						var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
											register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
						 
						var $tr = $("<tr>");
						var $departmentId = $("<td>").text(obj.departmentId);
						var $name = $("<td>").addClass("updateDepartment").attr("data-departmentId", obj.departmentId).text(obj.name);
						var $account = $("<td>").text(obj.account);
						var $registerDate = $("<td>").text(registerDate);
						var $button = $("<button>").addClass("deleteDepartment").attr("data-departmentId", obj.departmentId).text("삭제");
						var $buttonWrap = $("<td>").append($button);
						
						$tr.append($departmentId).append($name).append($account).append($registerDate).append($buttonWrap);
						$("#tableDepartment").append($tr);
					})
				}
			})
		})
	})


</script>


</head>
<body>
	<h3>부서관리</h1>
	<div>
		<label>부서명</label>
		<input type="text" name="searchName">
		<button id="searchDepartMent">검색</button>
	</div>


	<table id="tableDepartment">
		<thead>
			<tr>
				<th>No.</th>
				<th>부서명</th>
				<th>총인원</th>
				<th>등록일시</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${departmentData}">
				<tr>
					<th>${data.departmentId}</th>
					<th class="updateDepartment" data-departmentId="${data.departmentId}">${data.name}</th>
					<th>${data.account}</th>
					<td><fmt:formatDate value="${data.registerDate}" pattern="yyyy.MM.dd kk:mm" /></td>
					<td><button class="deleteDepartment" data-departmentId="${data.departmentId}">삭제</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button id="insertDepartMent">부서등록</button>
	

		<div id="insertDepartMentDiv">
			<label>부서명</label>
			<input type="text" name="departmentName">
			<button id="insert">등록</button>
			<button id="update">수정</button>
			<button id="reset">초기화</button>
		</div>
</body>
</html>