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
	// 로그인 실패
	var loginResult = "${loginResult}";
	if(loginResult == "false") {
		alert("로그인에 실패하셨습니다. 다시 확인해주세요.");
	} else if(loginResult == "suspension"){
		var suspensionEndDate = "${suspensionEndDate}";
		alert(suspensionEndDate + "까지 정지된 아이디 입니다.");
	}
	
	// 회원가입 결과
	var joinResult = "${joinResult}";
	if(joinResult == "success") {
		alert("회원가입에 성공하셨습니다.");
	}
	
	// 로그인이 필요한 서비스에 로그인 세션이 존재하지 않을 시
	var sessionResult = "${sessionResult}";
	if(sessionResult == "false") {
		alert("로그인이 필요한 서비스 입니다.");
	}
	
	// 아이디 찾기 성공 결과
	var idFindResult = "${idFindResult}";
	if(idFindResult == "true") {
		alert("성공적으로 아이디를 찾았습니다. 입력하신 메일로 아이디를 보냈습니다.");
	}
	
	// 비밀번호 변경 성공 결과
	var pwChangeResult = "${pwChangeResult}";
	if(pwChangeResult == "true") {
		alert("비밀번호를 변경하셨습니다. 변경된 비밀번호로 로그인 해주세요.");
	}
	
	// 회원가입 및 탈퇴
	var success = "${success}";
	if(success == "wthdr") {
		alert("회원 탈퇴에 성공하셨습니다. 회원가입 해주시면 감사합니다.")
	}
	if(success == "join") {
		
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
						<h2>로그인</h2>
						<p>로그인을 하셔야 소통이 가능합니다.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<form role="form" action="/member/loginRun" method="post">
						<div class="form-group">
							<label for="member_id">아이디</label>
							<input type="text" class="form-control" id="member_id" name="member_id" required/>
						</div>
						<div class="form-group">
							<label for="member_pw">비밀번호</label>
							<input type="password" class="form-control" id="member_pw" name="member_pw" required/>
						</div>
						<button type="submit" class="btn btn-primary">로그인</button>
						<a href="/find/idFindForm?clickCategory=login" style="margin-left: 10px;">아이디 찾기</a>
						<a href="/find/pwFindForm?clickCategory=login" style="margin-left: 10px;">비밀번호 찾기</a>
						<a href="/member/joinForm?clickCategory=join" style="margin-left: 10px;">회원가입</a>
					</form>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>