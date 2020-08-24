<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="../include/header.jsp"%>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="../include/aside.jsp"%>
<!-- 부트 스트랩 추가 -->
<%@ include file="../include/bootstrap.jsp" %>

<script>
</script>
<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>마이페이지</h2>
						<p>${member_id} 님의 페이지 정보 입니다.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="row">
						<div class="col-md-12">
							<div class="tabbable" id="tabs-897062">
								<ul class="nav nav-tabs">
									<li class="nav-item">
										<a class="nav-link active show" href="#tab1" data-toggle="tab">나의 정보</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#tab2" data-toggle="tab">내가 쓴 게시글</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#tab3" data-toggle="tab">내가 달은 답글</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#tab4" data-toggle="tab">내 정보 수정</a>
									</li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active" id="tab1">
										<p>
											I'm in Section 1.
										</p>
									</div>
									<div class="tab-pane" id="tab2">
										<p>
											Howdy, I'm in Section 2.
										</p>
									</div>
									<div class="tab-pane" id="tab3">
										<p>
											Howdy, I'm in Section 2.
										</p>
									</div>
									<div class="tab-pane" id="tab4">
										<p>
											Howdy, I'm in Section 2.
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>