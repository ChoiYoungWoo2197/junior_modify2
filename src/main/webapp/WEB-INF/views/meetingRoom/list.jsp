<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/managerHeader.jsp" %>

<script>
	$(function() {
		$("#insertMeetingRoom").click(function() {
			location.href = "insert";
		})
	})
</script>
	<section class="width1200">
		
		<button id="insertMeetingRoom">회의실 등록</button>
	</section>
</body>
</html>