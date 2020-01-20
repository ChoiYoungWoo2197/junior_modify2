      function hide() {
         $("#listDiv").hide();
         $("#reservationDiv").hide();
         $("#processingDiv").hide();
         $("#exitDiv").hide();
      };

      function empty() {
         $("#inputForm").empty();
         $("#reasonForm").empty();
         $("#btnDiv").empty();
         $("#cancelTr").remove();
         $("#exitTimeTr").remove();
         $("#exitCheckTr").remove();
         $("#extendTimeTr").remove();
         $("#extendReasonTr").remove();
      };
      
      function createCancelTag() {
    	  var cancelTr = '<tr id="cancelTr">';
    	  cancelTr += '<th> 취소사유</th>';
    	  cancelTr += '<td ><input type="text" name="cancelReason" style="width:100%;"/></td>';
    	  cancelTr += '</tr>';
          var cancel = '<input type="button" id="denyCancel" value="취소"/>';
          var complete = '<button id="completeCancel" class="margin_right">완료 </button>';
          $("#reservationTable").append(td).append(reason);
          $("#btnDiv").append(complete).append(cancel);   
      }
      
      function creatExitTag() {
    	 var exitTimeTr = '<tr id="exitTimeTr">';
    	 exitTimeTr += '<th > 조기종료시각</th>';
    	 exitTimeTr += '<td id="exitTd" ></td>';
    	 exitTimeTr	+=  '</tr>';
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
 
         $("#reservationTable").append(exitTimeTr);
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

         $("#btnDiv").append(complete).append(cancel);
      };
      
      function createExtendTag() {
    	 var extendTimeTr = '<tr id="extendTimeTr">';
    	 extendTimeTr += '<th>종료시각</th>';
    	 extendTimeTr += '<td id="extendTd"></td>';
    	 extendTimeTr += '</tr>';
         var selectStart = '<select name="extendTimeHours" id="extendTimeHours"></select>';
         var selectEnd = '<select name="extendTimeMinutes" id="extendTimeMinutes"></select>';
         var spanHour = '<span> : </span>';
         var spanMinutes = '<span> 분 </span>';
         
    	 var extendReasonTr = '<tr id="extendReasonTr">';
    	 extendReasonTr += '<th id="reasonTd" >연장사유</th>';
    	 extendReasonTr += '<td><input type="text" name="extendReason" style="width:100%;"/></td>';
    	 extendReasonTr += '</tr>';

    	 var cancel = '<input type="button" id="denyExtend" value="취소"/>';
         var complete = '<button id="completeExtend" class="margin_right">완료 </button>';

         var actualEndTime = $("input[name='actualEndTime']").val().substring(0,2);
         var limitReservation = $("input[name='limitReservation']").val() == null ? 22 : $("input[name='limitReservation']").val().substring(0,2);
         
         $("#reservationTable").append(extendTimeTr);
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
        
         $("#reservationTable").append(extendReasonTr);
         $("#btnDiv").append(complete).append(cancel);
      };
      
      function createExitCheckTag() {
    	  var exitCheckTr = '<tr id="exitCheckTr">';
    	  exitCheckTr += '<th> 이상유무확인</th>';
    	  exitCheckTr += '<td><input type="text" name="abnormality" style="width:100%;"/></td>';
    	  exitCheckTr += '</tr>';
          var cancel = '<input type="button" id="denyExitCheck" value="취소"/>';
          var complete = '<button id="completeExitCheck" class="margin_right">완료 </button>';
          
          $("#reservationTable").append(exitCheckTr);
          $("#btnDiv").append(complete).append(cancel);
      };
      
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
      };
      
      function getJson(map) {
    	  var object = map;
		  object = object.replace(/'/gi,'"');
		  object = object.replace(/"="/gi,'":"');
		  return JSON.parse(object);
      };
      

$(function() {
	  if($("#fv").text().indexOf("예약") > 0) {
		  var jsonObj = getJson($("input[name='Map']").val());
		  var th = '<th>예약신청일시</th>';
	      var td = '<td><span>'+ jsonObj.reservationDate + '</span></td>';
	      $("#readForm").append(th).append(td);
	     
	      if($("#fv").text().indexOf("취소") > 0) {
	    	  var trReason = '<tr id="cancelTr">';
	    	  trReason += "<th>취소사유</th>";
	    	  trReason += "<td><span>" +jsonObj.cancelReason + "</span></td>";
	    	  trReason += "</tr>";
	    	  $("#reservationTable").append(trReason);
	      }
	      else {
	    	  $("#readForm").addClass("tr_last_child");
	      } 
	  }
	  else if($("#fv").text().indexOf("연장") > 0) {
		  var jsonObj = getJson($("input[name='Map']").val());
		  var th = '<th>예약신청일시</th>';
	      var td = '<td><span>'+ jsonObj.reservationDate + '</span></td>';
	      $("#readForm").append(th).append(td);
	      
    	  var trExtendTime = '<tr>';
    	  trExtendTime += "<th>종료일시</th>";
    	  trExtendTime += "<td><span>" +jsonObj.actualEndDate + "</span></td>";
    	  trExtendTime += "</tr>";
    	  $("#reservationTable").append(trExtendTime);
    	  
    	  var extendObj = getJson($("input[name='ExtendMap']").val());
    	  var trExtendReason = '<tr>';
    	  trExtendReason += "<th>연장사유</th>";
    	  trExtendReason += "<td><span>" +extendObj.extendReason + "</span></td>";
    	  trExtendReason += "</tr>";
    	  $("#reservationTable").append(trExtendReason);
	  }
	  else if($("#fv").text().indexOf("종료") > 0) {
		  
	  }
	  else if($("#fv").text().indexOf("종료확인") > 0) {
		  
	  }
	  
	  if($("#extendReason").text() != "" && $("#fv").text().indexOf("종료확인") < 0) {
		  $("#finishTr").removeClass("tr_last_child");
		  $("#extendTr").addClass("tr_last_child");
	  };
	  
      //예약취소 클릭시
      $("#cancelReservation").click(function() {
         hide();
         createCancelTag();
      });
      
      $(document).on("click", "#denyCancel", function() {
      /*$("#cancelReservation").click(function() { //이 형식으로 할경우 이벤트가 안먹힘 제외*/
         empty();
         $("#listDiv").show();
         $("#reservationDiv").show();
      });

      $(document).on("click",   "#completeCancel", function() {
         if (confirm("취소하시겠습니까?")) {
            if($("input[name='cancelReason']").val() == "") {
               alert("취소사유를 입력해주세요.");
            }
            else {
               document.getElementById('reservationDetailForm').action = "/reservationDetail/cancel";
               document.getElementById('reservationDetailForm').submit();
            }
         }
         else {
            return false;
         }
      });

      //조기종료 클릭시
      $("#exitReservation").click(function() {
         hide();
         creatExitTag();
      });

      $(document).on("click", "#denyExit", function() {
         empty();
         $("#listDiv").show();
         $("#processingDiv").show();
      });

      $(document).on("click",   "#completeExit",function() {
         if (confirm("종료하시겠습니까?")) {         
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
         else {
            return false;
         }
      
      });

      //연장신청 클릭시
      $("#extendReservation").click(function() {
         hide();
         createExtendTag();
      });

      $(document).on("click", "#denyExtend", function() {
         empty();
         $("#listDiv").show();
         $("#processingDiv").show();
      });

      $(document).on("click",   "#completeExtend", function() {
         if (confirm("연장하시겠습니까?")) {
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
                           /*location.href = "/reservationDetail/extend";*/
                           document.getElementById('reservationDetailForm').action = "/reservationDetail/extend";
                           document.getElementById('reservationDetailForm').submit();   
                        }
                     }
                  })

               }
            }
         }
         else {
            return false;
         }
      });

      $("#exitCheckReservation").click(function() {
         hide();
         createExitCheckTag9();
      });

      $(document).on("click", "#denyExitCheck", function() {
         empty();
         $("#listDiv").show();
         $("#exitDiv").show();
      });

      $(document).on("click", "#completeExitCheck", function() {
         if (confirm("종료확인 하시겠습니까?")) {
            if($("input[name='abnormality']").val() == "") {
               alert("이상유무를 입력해주세요.");
            }
            else {
               document.getElementById('reservationDetailForm').action = "/reservationDetail/exitCheck";
               document.getElementById('reservationDetailForm').submit();   
            }

         }
         else {
            return false;
         }
      });

      $("#list").click(function() {
         location.href = "/reservation/list";
         //location.href=$("input[name='oldUrl']").val();
      });
      
      $("#updateReservation").click(function() {
         location.href="/reservation/update?reservationId="+ $("input[name='reservationId']").val();
      });

   })