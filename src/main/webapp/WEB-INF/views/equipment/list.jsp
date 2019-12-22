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
	}
	
	#insertEquipmentDiv {
		display: none;
	}
	
	
	/* ----------------- 페이지 ----------------- */
	#paging {
		text-align: center;
		margin-top: 20px;
	}
	.pagination li {
		width: 20px;
		list-style: none;
		display: inline-block;
	}
	.active {
		background-color: #4285f4;
	}
	span {
		background-color: rgb(189, 189, 189);
		width: 10px;
		height: 10px;
		border-radius: 5px;
		display: inline-block;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		$("#insertEquipment").click(function() {
			$("#insertEquipmentDiv").css("display","block");
			
			$("input[name='name']").val("");
			$("#insert").css("display","inline");
			$("#update").css("display","none");
		})
		
		$("#insert").click(function() {
			if($("input[name='name']").val()=="") {
				alert("장비명을 입력하세요");
				return false;
			}
			
			$.ajax({
				url: "${pageContext.request.contextPath}/equipment/insert",
				type: "post",
				data: {"name":$("input[name='name']").val()},
				success: function(res) {
					$("#tableEquipment").empty();
					$("#tableEquipment").append("<tr><th>번호</th><th>장비명</th><th>등록일시</th><th></th></tr>");
					
					$(res).each(function(i, obj) {
						var register_date = new Date(obj.registerDate);
						var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
											register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
						 
						var $tr = $("<tr>");
						var $equipmentId = $("<td>").text(obj.equipmentId);
						var $name = $("<td>").addClass("updateEquipment").attr("data-equipmentId", obj.equipmentId).text(obj.name);
						var $registerDate = $("<td>").text(registerDate);
						var $button = $("<button>").addClass("deleteEquipment").attr("data-equipmentId", obj.equipmentId).text("삭제");
						var $buttonWrap = $("<td>").append($button);
						
						$tr.append($equipmentId).append($name).append($registerDate).append($buttonWrap);
						$("#tableEquipment").append($tr);
					})
					
					$("#insertEquipmentDiv").css("display","none");
					$("input[name='name']").val("");
				}
			})
		})
		
		$(document).on("click", ".deleteEquipment", function(){
			$("#insertEquipmentDiv").css("display","none");
			
			var result = confirm("선택하신 장비를 삭제하시겠습니까?");
			
			if(result == true) {
				var equipmentId = $(this).attr("data-equipmentId");
				
				$.ajax({
					url: "${pageContext.request.contextPath}/equipment/delete",
					type: "post",
					data: {"equipmentId":Number(equipmentId)},
					success: function(res) {
						$("#tableEquipment").empty();
						$("#tableEquipment").append("<tr><th>번호</th><th>장비명</th><th>등록일시</th><th></th></tr>");
						
						$(res).each(function(i, obj) {
							var register_date = new Date(obj.registerDate);
							var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
												register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
							 
							var $tr = $("<tr>");
							var $equipmentId = $("<td>").text(obj.equipmentId);
							var $name = $("<td>").addClass("updateEquipment").attr("data-equipmentId", obj.equipmentId).text(obj.name);
							var $registerDate = $("<td>").text(registerDate);
							var $button = $("<button>").addClass("deleteEquipment").attr("data-equipmentId", obj.equipmentId).text("삭제");
							var $buttonWrap = $("<td>").append($button);
							
							$tr.append($equipmentId).append($name).append($registerDate).append($buttonWrap);
							$("#tableEquipment").append($tr);
						})
					}
				})
			}
		})
		
		$(document).on("click", ".updateEquipment", function(){
			$("#insertEquipmentDiv").css("display","block");
			
			$("input[name='name']").val($(this).text());
			$("#update").css("display","inline");
			$("#insert").css("display","none");
			
			var equipmentId = $(this).attr("data-equipmentId");
			
			$("#update").click(function() {
				var result = confirm("장비를 수정하시겠습니까?");
				
				if(result == true) { 
					$.ajax({
						url: "${pageContext.request.contextPath}/equipment/update",
						type: "post",
						data: {"name":$("input[name='name']").val(),"equipmentId":Number(equipmentId)},
						success: function(res) {
							$("#tableEquipment").empty();
							$("#tableEquipment").append("<tr><th>번호</th><th>장비명</th><th>등록일시</th><th></th></tr>");
							
							$(res).each(function(i, obj) {
								var register_date = new Date(obj.registerDate);
								var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
													register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
								 
								var $tr = $("<tr>");
								var $equipmentId = $("<td>").text(obj.equipmentId);
								var $name = $("<td>").addClass("updateEquipment").attr("data-equipmentId", obj.equipmentId).text(obj.name);
								var $registerDate = $("<td>").text(registerDate);
								var $button = $("<button>").addClass("deleteEquipment").attr("data-equipmentId", obj.equipmentId).text("삭제");
								var $buttonWrap = $("<td>").append($button);
								
								$tr.append($equipmentId).append($name).append($registerDate).append($buttonWrap);
								$("#tableEquipment").append($tr);
							})
							
							$("#insertEquipmentDiv").css("display","none");
							$("input[name='name']").val("");
						}
					})
				}
			})
		})
		
		$("#searchEquipment").click(function() {
			/* $.ajax({
				url: "${pageContext.request.contextPath}/equipment/search?searchContent="+$("input[name='searchContent']").val(),
				type: "get",
				success: function(res) {
					$("#tableEquipment").empty();
					$(".pagination").empty();
					
					$("#tableEquipment").append("<tr><th>번호</th><th>장비명</th><th>등록일시</th><th></th></tr>");
					
					$(res.equipmentList).each(function(i, obj) {
						var register_date = new Date(obj.registerDate);
						var registerDate = register_date.getFullYear()+"."+(register_date.getMonth()+1)+"."+("00" + register_date.getDate()).slice(-2)+" "+
											register_date.getHours()+":"+("00" + register_date.getMinutes()).slice(-2);
						 
						var $tr = $("<tr>");
						var $equipmentId = $("<td>").text(obj.equipmentId);
						var $name = $("<td>").addClass("updateEquipment").attr("data-equipmentId", obj.equipmentId).text(obj.name);
						var $registerDate = $("<td>").text(registerDate);
						var $button = $("<button>").addClass("deleteEquipment").attr("data-equipmentId", obj.equipmentId).text("삭제");
						var $buttonWrap = $("<td>").append($button);
						
						$tr.append($equipmentId).append($name).append($registerDate).append($buttonWrap);
						$("#tableEquipment").append($tr);
					})
					
					
					$(res.pageMaker).each(function(i, obj) {
						for(var i=obj.startPage; i<=obj.endPage; i++) {
							var $li = $("<li>");
							var $a = $("<a>").attr("href","list?page="+i+"&searchContent="+obj.criteria.searchContent);
							var $span = $("<span>");
							console.log(i);
						}
						
						$a.append($span);
						$li.append($a);
						$(".pagination").append($li);
					})
					
					$("#insertEquipmentDiv").css("display","none");
					$("input[name='name']").val("");
				}
			}) */
			location.href = "list?page=1&searchContent="+$("input[name='searchContent']").val();
		})
	})
</script>


	<section class="width1200">
		<h1>장비관리</h1>
		<div>
			<input type="text" name="searchContent" value="${criteria.searchContent}">
			<button id="searchEquipment">검색</button>
		</div>
		<table id="tableEquipment">
			<tr>
				<th>번호</th>
				<th>장비명</th>
				<th>등록일시</th>
				<th></th>
			</tr>
			<c:forEach var="equipment" items="${equipmentList}">
				<tr>
					<td>${equipment.equipmentId}</td>
					<td class="updateEquipment" data-equipmentId="${equipment.equipmentId}">${equipment.name}</td>
					<td><fmt:formatDate value="${equipment.registerDate}" pattern="yyyy.MM.dd kk:mm"/></td>
					<td><button class="deleteEquipment" data-equipmentId="${equipment.equipmentId}">삭제</button></td>
				</tr>
			</c:forEach>
		</table>
		<button id="insertEquipment">장비등록</button>
		
		<div id="paging">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li><a href="list?page=${pageMaker.startPage-1}&searchContent=${criteria.searchContent}">&laquo;</a></li>
				</c:if>
				<c:forEach var="index" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li><a href="list?page=${index}&searchContent=${criteria.searchContent}"><span ${pageMaker.criteria.page == index ? 'class="active"' : ''}></span></a></li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li><a href="list?page=${pageMaker.startPage-1}&searchContent=${criteria.searchContent}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
		
		<div id="insertEquipmentDiv">
			<label>장비명</label>
			<input type="text" name="name">
			<button id="insert">등록</button>
			<button id="update">수정</button>
			<button id="reset">초기화</button>
		</div>
	</section>
</body>
</html>