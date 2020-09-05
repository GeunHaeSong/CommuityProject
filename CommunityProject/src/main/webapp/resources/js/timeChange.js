/**
 * 
 */

// 초단위까지 표시ex : 2020-09-05 12:00:00(밀리초X)
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

// 10을 넘어가면 숫자 앞에 0을 붙이기
function zeroPlus(num) {
	return (num < 10) ? "0" + num : num;
}