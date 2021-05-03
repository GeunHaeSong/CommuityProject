/**
 * 
 */

// 초단위까지 표시 ex : 2020-09-05 12:00:00(밀리초X)
function seconds(time) {
	var d = new Date(time);
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
	var date = d.getDate();
	var hour = d.getHours() + 1;
	var minute = d.getMinutes();
	var second = d.getSeconds();
	var strDate = year + "-" + zeroPlus(month) + "-" + zeroPlus(date) + " "
	strDate += zeroPlus(hour) + ":" + zeroPlus(minute) + ":" + zeroPlus(second);
	return strDate;
}

// 일주일의 날짜 구하기 ex : 2020-09-05
function today(minus) {
	var now = new Date();
	var d = new Date(now.setDate(now.getDate() - minus));
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
	var date = d.getDate();
	var strDate = year + "-" + zeroPlus(month) + "-" + zeroPlus(date);
	return strDate;
}

// 10을 넘어가면 숫자 앞에 0을 붙이기
function zeroPlus(num) {
	return (num < 10) ? "0" + num : num;
}

// 날짜 받아와서 오늘과 비교하기
function dateCompare(date) {
	var date1 = new Date();
	var date2 = new Date(date);
	
	var result = "";
	if(date1 > date2) {
		result = "true";
	}
	return result;
}