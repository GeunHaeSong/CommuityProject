<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!-- 부트 스트랩 추가 -->
<%@ include file="../include/bootstrap.jsp" %>

<script>
$(function() {
	var interResult = "${interResult}";
	if(interResult == "false") {
		alert("관리자 권한이 필요한 페이지 입니다.");
	}
});
</script>
 
<html lang="en">
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
  <body>
	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		<!-- aside 부분 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		<div id="colorlib-main">
			<section class="ftco-section ftco-no-pt ftco-no-pb">
	    	<div class="container">
	    		<div class="row d-flex">
	    			<img alt="mainViewImage" src="/resources/images/mainViewImage.png" style="display: block; margin-left: auto; margin-right: auto; margin-top: 250px;">
	    		</div>
	    	</div>
	    </section>
		</div><!-- END COLORLIB-MAIN -->
	</div><!-- END COLORLIB-PAGE -->

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<!-- footer 부분 include -->
<%@ include file="../include/footer.jsp" %>

  </body>
</html>