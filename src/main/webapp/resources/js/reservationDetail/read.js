$(function() {
		function hide() {
			$("#listDiv").hide();
			$("#reservationDiv").hide();
			$("#processingDiv").hide();
			$("#exitDiv").hide();
		}

		function empty() {
			$("#inputForm").empty();
			$("#reasonForm").empty();
			$("#btnDiv").empty();
		}

		//예약취소 클릭시
		$("#cancelReservation").click(function() {
			hide();
			var td = '<th> 취소사유</th>';
			var reason = '<td class="td_input"><input type="text" name="cancelReason" style="width:100%;"/></td>';
			var cancel = '<input type="button" id="denyCancel" value="취소"/>';
			var complete = '<button id="completeCancel" class="margin_right">완료 </button>';
			$("#inputForm").append(td).append(reason);
			$("#btnDiv").append(complete).append(cancel);
			/*$('#btnDiv').addClass('float_right');*/

		})
		$(document).on("click", "#denyCancel", function() {
			empty();
			$("#listDiv").show();
			$("#reservationDiv").show();
		});

		$(document).on("click",	"#completeCancel", function() {
			if (confirm("취소하시겠습니까?") == true) {
				if($("input[name='cancelReason']").val() == "") {
					alert("취소사유를 입력해주세요.");
				}
				else {
					document.getElementById('reservationDetailForm').action = "/reservationDetail/cancel";
					document.getElementById('reservationDetailForm').submit();
				}
			}
		});

		//조기종료 클릭시
		$("#exitReservation").click(function() {
			hide();
			creatExitTag();
			$("#lastTr").removeClass("border_bottom");
			$("#inputForm").addClass("border_bottom");
		})

		$(document).on("click", "#denyExit", function() {
			empty();
			$("#listDiv").show();
			$("#processingDiv").show();
			$("#lastTr").addClass("border_bottom");
			
		});

		$(document).on("click",	"#completeExit",function() {
			if (confirm("종료하시겠습니까?") == true) {			
				var actualDay = $("input[name='actualEndDay']").val();
				var actualDayArray = actualDay.split('.');				
				var startTime = $("input[name='startTime']").val();
				var actualTime = $("input[name='actualEndTime']").val();		
				var startDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+startTime);
				//Date가 크롬에서는 먹히는데 IE에서는 Invalid Date뜸 그래서 오류처리해줌.
				if(startDate.toString() == 'Invalid Date') {
					startDate = parseDate(actualDay + ' '+startTime);	
				}

				var actualDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+actualTime);		
				//Date가 크롬에서는 먹히는데 IE에서는 Invalid Date뜸 그래서 오류처리해줌.
				if(actualDate.toString() == 'Invalid Date') {
					actualDate = parseDate(actualDay + ' '+actualTime);	
				}

				var exitDateHour = $("#exitTimeHours option:selected").val();
				var exitDateMinutes = $("#exitTimeMinutes option:selected").val();
				var exitDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+exitDateHour+ ':'+exitDateMinutes);

				//Date가 크롬에서는 먹히는데 IE에서는 Invalid Date뜸 그래서 오류처리해줌.
				if(exitDate.toString() == 'Invalid Date') {
					exitDate = parseDate(actualDay + ' '+exitDateHour+ ':'+exitDateMinutes);	
				}

				var currentTime = new Date();
	
				if(exitDate <  startDate || exitDate > actualDate) {
					empty();
					creatExitTag();
					$('#exitTd').append('<div><span style="color:red"> 예약사용일시에 종료하실수 있습니다. 다시입력해주세요.</span></div>');
					
				}
				else {
					if(currentTime < exitDate) {
						document.getElementById('reservationDetailForm').action = "/reservationDetail/exit";
						document.getElementById('reservationDetailForm').submit();
					}
					else {
						empty();
						creatExitTag();
						$('#exitTd').append('<div><span style="color:red"> 현재일시보다 일찍 종료할수 없습니다. 다시입력해주세요.</span></div>');
					}
					

				}
			}
		
		});

		//연장신청 클릭시
		$("#extendReservation").click(function() {
			hide();
			createExtendTag();
			$("#lastTr").removeClass("border_bottom");
			$("#inputForm").removeClass("border_bottom");
		})

		$(document).on("click", "#denyExtend", function() {
			empty();
			$("#listDiv").show();
			$("#processingDiv").show();
			$("#lastTr").addClass("border_bottom");
		});

		$(document).on("click",	"#completeExtend", function() {
			if (confirm("연장하시겠습니까?") == true) {
				if($("input[name='extendReason']").val() == "") {
					alert("연장사유를 입력해주세요.");	
				}
				else {
					var actualDay = $("input[name='actualEndDay']").val();
					var actualDayArray = actualDay.split('.');
					var actualTime = $("input[name='actualEndTime']").val();
					var actualDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+actualTime);
					//Date가 크롬에서는 먹히는데 IE에서는 Invalid Date뜸 그래서 오류처리해줌.
					if(actualDate.toString() == 'Invalid Date') {
						actualDate = parseDate(actualDay + ' '+actualTime);	
					}
					
					var extendDateHour = $("#extendTimeHours option:selected").val();
					var extendDateMinutes = $("#extendTimeMinutes option:selected").val();
					var extendDate = new Date(actualDayArray[0]+'/' +actualDayArray[1]+'/'+actualDayArray[2]+'/'+extendDateHour+ ':'+extendDateMinutes);
					//Date가 크롬에서는 먹히는데 IE에서는 Invalid Date뜸 그래서 오류처리해줌.
					if(extendDate.toString() == 'Invalid Date') {
						extendDate = parseDate(actualDay + ' '+extendDateHour+ ':'+extendDateMinutes);	
					}
					
					var endDate = actualDayArray[0]+'-' +actualDayArray[1]+'-'+actualDayArray[2] + " " + extendDateHour + ":" + extendDateMinutes;
	
					if(actualDate >= extendDate) {
						empty();
						createExtendTag();
						$('#extendTd').append('<div><span style="color:red"> 예약종료일시보다 빠릅니다. 다시입력해주세요.</span></div>');

					}
					else {
						var result = true;
						$.ajax({
							//연장신청날짜, 연장종료일시, 연장사유, 회의실 번호, 실제종료일시
							url : "/reservationDetail/checkTime?end="+endDate+"&meetingRoomId="+$("input[name='meetingRoomId']").val()+"&reservationId="+$("input[name='reservationId']").val(),
							type : "get",
							cache: false,
							async : false,
							success : function(res) {
								console.log(res);
								
								if(res == "false") {
									result = false;
									alert("다른 시간을 선택해주세요.");
								} else {
									result = true;
								}
							}
						})
						
						if(result) {
							document.getElementById('reservationDetailForm').action = "/reservationDetail/extend";
							document.getElementById('reservationDetailForm').submit();	
						}
					}


				}

			}
		});

		$("#exitCheckReservation").click(function() {
			hide();
			var td = '<th> 이상유무확인</th>';
			var abnormality = '<td class="td_input"><input type="text" name="abnormality" style="width:100%;"/></td>';
			var cancel = '<input type="button" id="denyExitCheck" value="취소"/>';
			var complete = '<button id="completeExitCheck" class="margin_right">완료 </button>';
			$("#inputForm").append(td).append(abnormality);
			$("#btnDiv").append(complete).append(cancel);
			/*$('#btnDiv').addClass('float_right');*/
		})

		$(document).on("click", "#denyExitCheck", function() {
			empty();
			$("#listDiv").show();
			$("#exitDiv").show();
		});

		$(document).on("click", "#completeExitCheck", function() {
			if (confirm("종료확인 하시겠습니까?") == true) {
				if($("input[name='abnormality']").val() == "") {
					alert("이상유무를 입력해주세요.");
				}
				else {
					document.getElementById('reservationDetailForm').action = "/reservationDetail/exitCheck";
					document.getElementById('reservationDetailForm').submit();	
				}

			}
		});

		$(document).on("click", "#list", function() {
			//location.href = "/reservation/list";
			location.href=$("input[name='oldUrl']").val();
		});
		
		$("#updateReservation").click(function() {
			location.href="/reservation/update?reservationId="+ $("input[name='reservationId']").val();
		})
		
		function creatExitTag() {
			var td = '<th > 조기종료시각</th>';
			var exitTd = '<td id="exitTd"></td>';
			var selectStart = '<select name="exitTimeHours" id="exitTimeHours"></select>';
			var selectEnd = '<select name="exitTimeMinutes" id="exitTimeMinutes"></select>';
			var spanHour = '<span> : </span>';
			var spanMinutes = '<span> 분 </span>';
			var cancel = '<input type="button" id="denyExit"  value="취소"/>';
			var complete = '<button id="completeExit" class="margin_right">완료 </button>';
	
			var startTime= $("input[name='startTime']").val();
			var startTimeArray = startTime.split(':');
			var actualEndTime = $("input[name='actualEndTime']").val();
			var actualEndTimeArray = actualEndTime.split(':');
			//alert(startTimeArray[0] + " : " + actualEndTimeArray[0]);
			
			
			$("#inputForm").append(td).append(exitTd);
			$('#exitTd').addClass('td_input');
			$('#exitTd').append(selectStart);
			for (var count = startTimeArray[0]; count <= actualEndTimeArray[0]; count++) {
				var option = $("<option>" + count + "</option>");
				$('#exitTimeHours').append(option);
			}
			$('#exitTd').append(spanHour).append(selectEnd);
			for (var count = 0; count <= 59; count++) {
				var option = $("<option>" + count + "</option>");
				$('#exitTimeMinutes').append(option);
			}
			
			//$("#inputForm").append(spanMinutes);
			$("#btnDiv").append(complete).append(cancel);
			/*$('#btnDiv').addClass('float_right');*/
		}
		
		function createExtendTag() {
			var td = '<th>종료시각</th>';
			var extendTd = '<td id="extendTd"></td>';
			var reasonTd = '<th id="reasonTd">연장사유</th>';
			var selectStart = '<select name="extendTimeHours" id="extendTimeHours"></select>';
			var selectEnd = '<select name="extendTimeMinutes" id="extendTimeMinutes"></select>';
			var spanHour = '<span> : </span>';
			var spanMinutes = '<span> 분 </span>';
			var reason = '<td><input type="text" name="extendReason" style="width:100%;"/></td>';
			var cancel = '<input type="button" id="denyExtend" value="취소"/>';
			var complete = '<button id="completeExtend" class="margin_right">완료 </button>';

			var actualEndTime = $("input[name='actualEndTime']").val().substring(0,2);
			var limitReservation = $("input[name='limitReservation']").val() == null ? 22 : $("input[name='limitReservation']").val().substring(0,2);
			
			$("#inputForm").append(td).append(extendTd);
			$('#extendTd').addClass('td_input');
			$('#extendTd').append(selectStart);

			for (var count = actualEndTime; count <= limitReservation; count++) {
				var option = $("<option>" + count + "</option>");
				$('#extendTimeHours').append(option);
			}
			$('#extendTd').append(spanHour).append(selectEnd);
			for (var count = 0; count <= 59; count++) {
				var option = $("<option>" + count + "</option>");
				$('#extendTimeMinutes').append(option);
			}
			
			if($("input[name='limitReservation']").val() != null) {
				var label = '<label> 이 후' +$("input[name='limitReservation']").val() +' 예약건이 있습니다. </label>';
				$('#extendTd').append(label);
			}
			
			$("#reasonForm").append(reasonTd).append(reason);
			$("#btnDiv").append(complete).append(cancel);
			/*$('#btnDiv').addClass('float_right');*/
		}
		
		function parseDate(strDate) {
		    var _strDate = strDate;
		    var _dateObj = new Date(_strDate);
		    if (_dateObj.toString() == 'Invalid Date') {
		        _strDate = _strDate.split('.').join('-');
		        _dateObj = new Date(_strDate);
		    }
		    if (_dateObj.toString() == 'Invalid Date') {
		        var _parts = _strDate.split(' ');
		 
		        var _dateParts = _parts[0];
		        _dateObj = new Date(_dateParts);
		 
		        if (_parts.length > 1) {
		            var _timeParts = _parts[1].split(':');
		            _dateObj.setHours(_timeParts[0]);
		            _dateObj.setMinutes(_timeParts[1]);
	            if (_timeParts.length > 2) {
		                _dateObj.setSeconds(_timeParts[2]);
		            }
		        }
		    }
		 
		    return _dateObj;
		}
		
	})