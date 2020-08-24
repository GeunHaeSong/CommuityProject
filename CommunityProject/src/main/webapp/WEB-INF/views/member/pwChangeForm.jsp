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
	// 비밀번호와 비밀번호 확인이 다르게 입력되었을 경우
	$("#pwChangeForm").submit(function() {
		var pw = $("#member_pw").val();
		var pw2 = $("#member_pw2").val();
		
		if(pw != pw2) {
			alert("비밀번호가 서로 다릅니다. 다시 확인해주세요");
			return false;
		}
	});
});
</script>

<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>비밀번호 찾기</h2>
						<p>아이디 이름과 이메일을 정확히 입력해주세요.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<form id="pwChangeForm" role="form" action="/find/pwChangeRun" method="post">
						<input type="hidden" name="member_id" value="${member_id}">
						<div class="form-group">
							<label for="member_id">아이디 : </label>
							<strong style="color : green;">${member_id}</strong>
						</div>
						<div class="form-group">
							<label for="member_id">새 비밀번호</label>
							<input type="password" class="form-control" id="member_pw" name="member_pw" required/>
						</div>
						<div class="form-group">
							<label for="member_pw">새 비밀번호 확인</label>
							<input type="password" class="form-control" id="member_pw2" required/>
						</div>
						<button type="submit" class="btn btn-primary">확인</button>
					</form>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>