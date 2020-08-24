<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
<script>
$(function() {
	var boardResult = "${boardResult}";
	if(boardResult == "true") {
		alert("성공적으로 글을 작성하셨습니다.");
	}
});
</script>
  <body>
	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		<!-- aside.jsp 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		<div id="colorlib-main">
			<section class="ftco-section">
				<div class="container">
					<div class="row px-md-4">
					<!-- 여기서 부터 게시물 한개 -->
					<c:forEach items="${boardList}" var="BoardVo">
						<div class="col-md-12">
							<div class="blog-entry ftco-animate d-md-flex">
								<a href="single.html" class="img img-2" style="background-image: url(/freeBoard/displayImage?fileName=${BoardVo.board_main_image});"></a>
								<div class="text text-2 pl-md-4">
									<h3 class="mb-2"><a href="single.html">${BoardVo.board_title}</a></h3>
									<div class="meta-wrap">
										<p class="meta">
											<span><i class="icon-calendar mr-2"></i>${BoardVo.board_reg_t}</span>
											<span><a href="single.html"><i class="icon-folder-o mr-2"></i>${BoardVo.category_code}</a></span>
											<span><i class="icon-comment2 mr-2"></i>5 Comment</span>
										</p>
									</div>
									<p class="mb-4">${BoardVo.board_content}</p>
									<p><a href="#" class="btn-custom">상세 페이지로<span class="ion-ios-arrow-forward"></span></a></p>
								</div>
							</div>
						</div>
					</c:forEach>
					</div>
					<div class="row">
			          <div class="col text-center text-md-left">
			            <div class="block-27">
			              <ul>
			              	<!-- 왼쪽 화살표 -->
			                <li><a href="#">&lt;</a></li>
			                <!-- 페이징 넘버링 -->
			                <li class="active"><span>1</span></li>
			                <li><a href="#">2</a></li>
			                <li><a href="#">3</a></li>
			                <li><a href="#">4</a></li>
			                <li><a href="#">5</a></li>
			                <!-- 오른쪽 화살표 -->
			                <li><a href="#">&gt;</a></li>
			              </ul>
			            </div>
			          </div>
			        </div>
				</div>
			</section>
		</div><!-- END COLORLIB-MAIN -->
	</div><!-- END COLORLIB-PAGE -->
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
<!-- footer.jsp 인크루드 -->
<%@ include file="../include/footer.jsp" %>
  </body>
</html>