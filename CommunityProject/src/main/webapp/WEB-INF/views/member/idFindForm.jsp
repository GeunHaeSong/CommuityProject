<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="../include/header.jsp"%>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="../include/aside.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="../include/bootstrap.jsp"%>

<script>
$(function() {
	// 아이디 찾기에 실패
	var idFindResult = "${idFindResult}";
	if(idFindResult == "false") {
		alert("입력하신 정보로 존재하는 사용자 정보가 존재하지 않습니다. 다시 확인해주세요.");
	}
});
</script>

<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>아이디 찾기</h2>
						<p>회원가입 시 등록했던 이름과 이메일을 정확히 입력해주세요.</p>
						<p>찾은 아이디는 입력하신 이메일로 보내지게 됩니다.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<form role="form" action="/find/idFindRun" method="post">
						<div class="form-group">
							<label for="member_id">이름</label>
							<input type="text" class="form-control" name="member_name" required/>
						</div>
						<div class="form-group">
							<label for="member_pw">이메일</label>
							<input type="email" class="form-control" name="member_email" required/>
						</div>
						<button type="submit" class="btn btn-primary">아이디 찾기</button>
					</form>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>