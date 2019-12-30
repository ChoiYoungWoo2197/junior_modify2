<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<script>
	$(function() {
		$("#insertReservation").click(function() {
			location.href = "insert";
		})
	})
</script>	
	
	<section class="width1200">
	
		list
		<button id="insertReservation">예약등록</button>
	</section>
</body>
</html>