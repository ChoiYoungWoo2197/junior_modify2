$(function() {
	$("#listMeetingRoom").click(function() {
		location.href = "list";
	})
	
	$("#insertMeetingRoomForm").submit(function() {
		var check = true;
		$("input[name='name']").next().addClass("display_none");
		$("input[name='seats']").next().addClass("display_none");
		
		if($("input[name='name']").val() == "") {
			$("input[name='name']").next().removeClass("display_none");
			check = false;
		}
		
		if($("input[name='seats']").val() == "") {
			$("input[name='seats']").next().removeClass("display_none");
			check = false;
		} else if ($("input[name='seats']").val() != "") {
			if(Number($("input[name='seats']").val()) <= 0) {
				$("input[name='seats']").next().next().removeClass("display_none");
	        	check = false;
	        }
	        
	        if(Number($("input[name='seats']").val()) != $("input[name='seats']").val()) {
	        	$("input[name='seats']").next().next().removeClass("display_none");
	        	check = false;
	        }
		}
		
		var checkTrue = [];
		$("input[name='equipmentId']:checked").each(function(i) {
			checkTrue.push($(this).val());	// 체크된 것만 값을 뽑아서 배열에 push
	    })
	    $("input[name='checkTrue']").val(checkTrue);
		
		return check;
	})
})