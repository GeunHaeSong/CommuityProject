<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="/WEB-INF/views/include/aside.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="/resources/js/timeChange.js"></script>
<script type="text/javascript">
$(function() {
	// 구글 api 차트 사용
	google.charts.load('current', {'packages':['bar']});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		 var data = google.visualization.arrayToDataTable([
	          ['날짜', '게시글', '방문자'], ${str}
	        ]);
		
		var options = {
			chart: {
				title: '최근 등록된 게시글과 방문자 수',
				subtitle: '일주일 간의 기록',
			}
		};

		var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
});
</script>

<!-- 어드민 페이지 메뉴 -->
<%@ include file="../adminInclude/adminMenuHeader.jsp" %>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-1">
				</div>
				<div class="col-md-9" style="margin-top: 30px;">
					<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
				</div>
				<div class="col-md-2">
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 어드민 페이지 메뉴 -->
<%@ include file="../adminInclude/adminMenuFooter.jsp" %>



<!-- footer 링크 설정 부분 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>