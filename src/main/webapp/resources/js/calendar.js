var today = new Date();

function displayCaldendar(str) { 
	today = new Date(str);
	
	var year = today.getFullYear();
	var month = today.getMonth();
	var date = today.getDate();
	
	//현재 월의 1일을 구한다.
	var firstDate = new Date(year, month, 1);
	var dayWeek = firstDate.getDay();//빈칸 갯수를 위해 사용(getDay=>요일정보)
	
	var lastArray = [31,28,31,30,31,30,31,31,30,31,30,31]; 
	
	//윤년(4년주기이고 100년 주기는 제외 또는 400년 주기)
	if( (year%4==0 && year%100!=0) || (year%400==0)){
		lastArray[1] = 29;
	}
	var lastDate = lastArray[month];//해당 월의 마지막 날짜
	
	var row = Math.ceil((dayWeek + lastDate) / 7 ); //행의 갯수(ceil=>올림)
	
	$("#today").text(year+"."+("0"+(month+1)).slice(-2));
	
	var calendar = "<table>";
	calendar +="<tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>";

	var num = 1;//날짜
	for(var i = 1; i<=row; i++){//행
		calendar += "<tr>";
		for(var j=1; j<=7; j++){ //열
			//첫번째 행이고, dayWeek빈칸 갯수만큼 & 마지막 날짜보다 num값이 커지면 빈칸으로 채움
			if(i == 1 && j <= dayWeek || num > lastDate){ 
			   calendar += "<td></td>";
			} else {
				if(num<10) {
					calendar += "<td data-value=0"+num+">"+num+"</td>";
					num++;
				} else {
					calendar += "<td data-value="+num+">"+num+"</td>";
					num++;
				}
				
			}           
		}
		calendar += "</tr>";
	}
	calendar += "</table>";
	$("#calendar").html(calendar);
} 

function prevMonth(){//한달 전
	//today.setMonth(today.getMonth() - 1);
	displayCaldendar(today.setMonth(today.getMonth() - 1));
}

function nextMonth(){//한달 후
	//today.setMonth(today.getMonth() + 1);   
	displayCaldendar(today.setMonth(today.getMonth() + 1));
}
