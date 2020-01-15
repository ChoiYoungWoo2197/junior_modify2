$(function() {
	$("#startImg").click(function() {
		$("#searchStart").focus();
	});
	
	$("#endImg").click(function() {
		$("#searchEnd").focus();
	});
	
	$.datepicker.setDefaults($.datepicker.regional['ko']); //한국어 설정
    $("#searchStart").datepicker({ 
        dateFormat:"yy-mm-dd",    // 날짜 출력폼 설정
    });
    
    $("#searchEnd").datepicker({ 
        dateFormat:"yy-mm-dd",    // 날짜 출력폼 설정
    });
    
	$("#insertReservation").click(function() {
		location.href = "insert";
	});
	
	$(".updateReservation").click(function() {
		var reservationId = Number($(this).find(".readReservation").attr("data-reservationId"));
		location.href = encodeURI("/reservationDetail/read?reservationId="+ reservationId);
	});
	
	$("#searchReservation").click(function() {
		$("#searchForm").submit();
	});
	
	$("#allReservation").click(function() {
		location.href = "list";
	});
})