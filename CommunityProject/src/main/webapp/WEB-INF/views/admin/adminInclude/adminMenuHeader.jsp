<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="/WEB-INF/views/include/aside.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<script>
</script>
<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>관리자 메인 페이지</h2>
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
										<a class="nav-link" href="/admin/adminMainForm">오늘의 정보</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="/admin/memberMngForm">회원 관리</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="/admin/boardMngForm">게시글 관리</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="/admin/commentMngForm">댓글 관리</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="/admin/adminBoardMngForm">관리자 글 관리</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="/admin/sanctionForm">재제 가하기</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="/admin/ratingSetForm">등급 조정하기</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>