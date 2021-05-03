<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="../include/header.jsp"%>
<!-- 부트 스트랩 추가 -->
<%@ include file="../include/bootstrap.jsp" %>
<style>
	label {
		width: 200px;
	}
</style>
<script>
$(function() {
	
	var category_code = "${category_code}";
	console.log("category_code : " + category_code);
	var fail = "${fail}";
	if(fail == "notMemberId") {
		alert("로그인된 아이디와 입력하신 아이디가 일치하지 않습니다.");
	}
	
	if(fail == "notMemberPw") {
		alert("잘못된 비밀번호 입니다. 다시 입력해주세요.");
	}
	
	$("#btnFormRun").click(function() {
		var member_id = $("#member_id").val();
		var member_pw = $("#member_pw").val();
		var member_id_length = member_id.length;
		var member_pw_length = member_pw.length;
		if(member_id_length <= 0 || member_pw_length <= 0) {
			alert("빈 입력 칸이 존재합니다. 다시 확인해주세요.");
			return;
		}
		$("#memberWthdrForm").submit();
	});
});
</script>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="../include/aside.jsp"%>
<!-- 본문 -->
<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>회원탈퇴</h2>
						<h5>최종적으로 아이디와 비밀번호를 다시 입력해주세요.</h5>
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
								<div class="row">
									<div class="col-md-12">
										<form id="memberWthdrForm" role="form" action="/member/memberWthdrRun" method="post">
											<input type="hidden" id="member_birthday" name="member_birthday">
											<div class="form-group">
												<hr/>
												<label for="member_id">아이디</label>
												<input type="text" id="member_id" name="member_id"/>
											</div>
											<div class="form-group">
												<hr/>
												<label for="member_pw">비밀번호</label>
												<input type="password" id="member_pw" name="member_pw"/>
											</div>
											<hr/>
											<button id="btnFormRun" type="button" class="btn btn-danger">
												탈퇴
											</button>
											<a type="button" class="btn btn-dark" href="/member/myPage?clickCategory=myPage">취소</a>
										</form>
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