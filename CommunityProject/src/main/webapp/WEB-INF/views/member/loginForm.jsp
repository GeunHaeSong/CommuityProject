<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="../include/header.jsp"%>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="../include/aside.jsp"%>

<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>로그인</h2>
						<p>로그인을 하셔야 소통이 가능합니다.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<form role="form">
						<div class="form-group">
							<label for="user_id">아이디</label> <input
								type="text" class="form-control" id="user_id" name="user_pw" required/>
						</div>
						<div class="form-group">

							<label for="user_pw">비밀번호</label> <input
								type="password" class="form-control" id="user_pw" name="user_pw" required/>
						</div>
						<button type="submit" class="btn btn-primary">로그인</button>
						<a href="#" style="margin-left: 10px;">아이디 찾기</a>
						<a href="#" style="margin-left: 10px;">비밀번호 찾기</a>
						<a href="#" style="margin-left: 10px;">회원가입</a>
					</form>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>