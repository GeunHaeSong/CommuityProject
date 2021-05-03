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
	.modify_message {
		color: red;
	}
</style>
<script>
//주소 api 받기
function jusoCallBack(roadFullAddr){
	$("#member_address").val(roadFullAddr);
}
// 읽어온 생년월일을 생년, 월, 일 나눠서 할당시키기
function birthday() {
	var birthday = "${memberVo.member_birthday}";
	var yy = birthday.substring(0, 4);
	var mm = birthday.substring(4, 6);
	var dd = birthday.substring(6);
	$("#yy").val(yy);
	$("#mm").val(mm).attr("selected", "selected");
	$("#dd").val(dd);
}

$(function() {
	
	// 시작하자마자 날짜 변환해서 할당하기
	birthday();
	// 이메일 인증에 필요한 인증 번호
	var authentication_number;
	
	// 검색 창 띄우기
	$("#btnAddressSearch").click(function() {
		var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	});
	
	// 닉네임 확인
	$("#member_nickname").blur(function() {
		$(".nickname_clone").remove();
		var member_nickname = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("nickname_clone");
		
		var nickname_rgx = /^[가-힣a-zA-Z0-9]{1,15}$/;
		if(!nickname_rgx.test(member_nickname)) {
			var message = "닉네임은 1~15자 한글과 영문자만 가능합니다.";
			resultMessage.find("strong").text(message);
			$(this).after(resultMessage);
			$("#nickname_result").val("false");
			return false;
		}
		$("#nickname_result").val("true");
	});
	
	// 휴대전화
	$("#member_phone_number").blur(function() {
		$(".phone_clone").remove();
		var phone_number = $(this).val();
		var phone_rgx  = /^\d{3}\d{4}\d{4}$/;
		var resultMessage = $("#resultMessage").clone().addClass("phone_clone");
		if(!phone_rgx.test(phone_number)) {
			var message = "양식에 맞춰 전화번호를 입력해주세요.";
			resultMessage.find("strong").text(message);
			$(this).after(resultMessage);
			$("#phone_result").val("false");
			return false;
		}
		$("#phone_result").val("true");
	});
	
	// 생년 체크
	$("#yy").blur(function() {
		$(".birth_clone").remove();
		var yy = $(this).val();
		var yy_rgx = /^[0-9]{4}$/;
		var resultMessage = $("#resultMessage").clone().addClass("birth_clone");
		
		if(!yy_rgx.test(yy)) {
			var message = "태어난 년도는 4자 숫자만 가능합니다.";
			resultMessage.find("strong").text(message);
			$("#dd").after(resultMessage);
			$("#yy_result").val("false");
			$("#birth_result").val("false");
			return false;
		}
		var message = "생년월일을 빈칸 없이 입력해주세요.";
		resultMessage.find("strong").text(message);
		$("#dd").after(resultMessage);
		$("#yy_result").val("true");

		var yy_result = $("#yy_result").val();
		var mm_result = $("#mm_result").val();
		var dd_result = $("#dd_result").val();
		
		if(yy_result == "true" && mm_result == "true" && dd_result == "true") {
			$(".birth_clone").remove();
			$("#birth_result").val("true");
			return false;
		}
		$("#birth_result").val("false");
	});
	
	// 월 체크
	$("#mm").change(function() {
		$(".birth_clone").remove();
		var mm = $("#mm option:selected").val();
		var resultMessage = $("#resultMessage").clone().addClass("birth_clone");
		if(mm == 'not') {
			var message = "태어난 일을 선택해주세요.";
			resultMessage.find("strong").text(message);
			$("#dd").after(resultMessage);
			$("#mm_result").val("false");
			$("#birth_result").val("false");
			return false;
		}
		var message = "생년월일을 빈칸 없이 입력해주세요.";
		resultMessage.find("strong").text(message);
		$("#dd").after(resultMessage);
		$("#mm_result").val("true");
		
		var yy_result = $("#yy_result").val();
		var mm_result = $("#mm_result").val();
		var dd_result = $("#dd_result").val();
		
		if(yy_result == "true" && mm_result == "true" && dd_result == "true") {
			$(".birth_clone").remove();
			$("#birth_result").val("true");
			return false;
		}
		$("#birth_result").val("false");
	});
	
	// 일 체크
	$("#dd").blur(function() {
		$(".birth_clone").remove();
		var dd = $(this).val();
		var dd_rgx = /^[0-9]{2,2}$/;
		var resultMessage = $("#resultMessage").clone().addClass("birth_clone");
		if(!dd_rgx.test(dd)) {
			var message = "태어난 일은 2자 숫자로만 입력 가능합니다.";
			resultMessage.find("strong").text(message);
			$(this).after(resultMessage);
			$("#dd_result").val("false");
			$("#birth_result").val("false");
			return false;
		}
		var message = "생년월일을 빈칸 없이 입력해주세요.";
		resultMessage.find("strong").text(message);
		$(this).after(resultMessage);
		$("#dd_result").val("true");
		
		var yy_result = $("#yy_result").val();
		var mm_result = $("#mm_result").val();
		var dd_result = $("#dd_result").val();
		
		if(yy_result == "true" && mm_result == "true" && dd_result == "true") {
			$(".birth_clone").remove();
			$("#birth_result").val("true");
			return false;
		}
		$("#birth_result").val("false");
	});
	
	// 이메일 확인
	$("#modal_email").blur(function() {
		$(".email_clone").remove();
		var email = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("email_clone");
		$("#btnEmailSave").attr("disabled", true);
		$("#emailSender_check").attr("disabled", true);
		
		// 이메일 형식의 정규식
		var email_rgx = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if(!email_rgx.test(email)) {
			var message = "이메일 형식을 지켜주세요.";
			resultMessage.find("strong").text(message);
			$("#email_authentication").after(resultMessage);
			$("#email_result").val("false");
			return false;
		}
		
		// 이메일 중복 체크
		var url = "/member/emailDupCheck";
		var sendData = {
				"member_email" : email
		};
		
		// 에이젝스 요청해서 사용 가능한 이메일인지 체크
		$.get(url, sendData, function(rData) {
			if(rData == 'true') {
				var message = "사용 가능한 이메일 입니다.";
				resultMessage.find("strong").text(message).css("color", "blue");
				$("#email_authentication").after(resultMessage);
				$("#email_result").val("true");
				return false;
			}
			var message = "이미 존재하는 이메일 입니다.";
			resultMessage.find("strong").text(message);
			$("#email_authentication").after(resultMessage);
			$("#email_result").val("false");
		});
	});
	
	// 메일 인증 보내기
	$("#emailSender").click(function() {
		$(".email_clone").remove();
		var resultMessage = $("#resultMessage").clone().addClass("email_clone");
		var email_result = $("#email_result").val();
		
		if(email_result != "true") {
			var message = "이미 등록된 이메일이거나 사용 불가능한 이메일 입니다.";
			resultMessage.find("strong").text(message);
			$("#email_authentication").after(resultMessage);
			return;
		}
		
		$("#email_authentication").removeAttr("readonly");
		
		// 이메일 보내기 시간 차 두기
		$("#emailSender").attr("disabled", true);
		setTimeout(function() {
			$("#emailSender").attr("disabled", false);
		}, 3000);
		
		var url = "/member/emailSender";
		var to = $("#modal_email").val();
		var sendData = {
			"to" : to	
		};
		$.get(url, sendData, function(rData) {
			authentication_number = rData;
			$(".email_clone").remove();
			var message = "성공적으로 이메일을 보냈습니다.";
			resultMessage.find("strong").text(message).css("color", "blue");
			$("#emailSender_check").attr("disabled", false);
			$("#email_authentication").attr("disabled", false);
			$("#email_authentication").after(resultMessage);
		});
	});
	
	// 이메일 인증
	$("#emailSender_check").click(function() {
		$(".email_clone").remove();
		var resultMessage = $("#resultMessage").clone().addClass("email_clone");
		var email_authentication = $("#email_authentication").val();
		
		if(authentication_number != email_authentication) {
			var message = "인증 번호와 일치하지 않습니다.";
			resultMessage.find("strong").text(message);
			$("#email_authentication").after(resultMessage);
			$("#btnEmailSave").attr("disabled", true);
			$("#email_authentication_result").val("false");
		} else {
			var message = "인증되었습니다.";
			resultMessage.find("strong").text(message).css("color", "blue");
			$("#email_authentication").after(resultMessage);
			$("#btnEmailSave").attr("disabled", false);
			$("#email_authentication").attr("disabled", true);
			$("#email_authentication_result").val("true");
		}
	});
	
	// 이메일 변경을 위한 버튼 이벤트(모달 발생시킴)
	$("#btnEmailModal").click(function() {
		$("#start_modal").modal("show");	
	});
	
	// 모달에서 인증된 이메일 폼에 붙이기
	$("#btnEmailSave").click(function() {
		var result = $("#email_authentication_result").val();
		if(result == "true") {
			var confirmflag = confirm("해당 이메일로 등록하시겠습니까?");
			if(confirmflag == true) {
				var email = $("#modal_email").val();
				$("#member_email").val(email);
				$("#email_result").val("true");
				$("#start_modal").modal("hide");
			}
		} else {
			alert("인증되지 않은 이메일 입니다. 다시 확인해주세요.");
		}
	});
	
	// 모달이 닫혔을때 정보들 초기화 시키기
	$("#start_modal").on("hidden.bs.modal", function() {
		$(".email_clone").remove();
		$("#modal_email").val("");
		$("#email_authentication").val("");
		$("#email_result").val("");
		$("#email_authentication_result").val("");
		$("#btnEmailSave").attr("disabled", true);
		$("#email_authentication").attr("disabled", true);
		$("#emailSender_check").attr("disabled", true);
	});
	
	// 수정 폼 전송
	$("#btnFormRun").click(function() {
		var yy = $("#yy").val();
		var mm = $("#mm option:selected").val();
		var dd = $("#dd").val();
		var member_birthday = yy + mm + dd;
		$("#member_birthday").val(member_birthday);
		
		var nickname_result = $("#nickname_result").val();
		var birth_result = $("#birth_result").val();
		var phone_result = $("#phone_result").val();
		
		if(nickname_result == "true" && birth_result == "true" && phone_result == "true") {
			$("#infoModfiyForm").submit();
		} else {
			alert("형식에 맞지 않는 칸이 존재합니다. 다시 확인해주세요.");
		}
	});
});
</script>
<!-- 바꾼 결과에 대한 메세지 출력 -->
<div id="resultMessage"><span><strong class="modify_message"></strong></span></div>
<!-- 확인을 위한 hidden input -->
<input type="hidden" id="email_result">
<input type="hidden" id="email_authentication_result">
<input type="hidden" id="yy_result" value="true">
<input type="hidden" id="mm_result" value="true">
<input type="hidden" id="dd_result" value="true">
<input type="hidden" id="nickname_result" value="true">
<input type="hidden" id="birth_result" value="true">
<input type="hidden" id="phone_result" value="true">
<!-- 이메일 모달창 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="modal fade" id="start_modal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">
								이메일 변경
							</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<div>
								<input type="email" class="form-control" id="modal_email"/>
								<input type="text" class="form-control" id="email_authentication" placeholder="인증번호 | 메일을 보내셔야 입력 가능합니다." readonly/>
								<button id="emailSender_check" type="button" class="btn btn-sm btn-primary" disabled>인증 확인</button>
								<button id="emailSender" type="button" class="btn btn-sm btn-primary">메일 보내기</button>
							</div>	
						</div>
						<div class="modal-footer">
							<button id="btnEmailSave" type="button" class="btn btn-primary" disabled>
								저장
							</button> 
							<button type="button" class="btn btn-danger" data-dismiss="modal">
								취소
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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
						<h2>개인 정보 관리</h2>
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
										<form id="infoModfiyForm" role="form" action="/member/memberInfoModfiyRun" method="get">
											<input type="hidden" id="member_birthday" name="member_birthday">
											<div class="form-group">
												<hr/>
												<label for="member_id">아이디</label>
												<input type="text" id="exampleInputEmail1" value="${memberVo.member_id }" disabled/>
											</div>
											<div class="form-group">
												<hr/>
												<label for="member_nickname">닉네임</label>
												<input type="text" id="member_nickname" name="member_nickname"  value="${memberVo.member_nickname}"/>
											</div>
											<div>
												<hr/>
												<label>이름</label>
												<input type="text" value="${memberVo.member_name }" disabled>
											</div>
											<div>
												<hr/>
												<label for="member_phone_number">휴대전화</label>
												<input type="text" id="member_phone_number" name="member_phone_number" value="${memberVo.member_phone_number }" placeholder="01012345678"/>
											</div>
											<div>
												<hr/>
<!-- 												<label>생년월일</label> -->
<%-- 												<input type="text" value="${memberVo.member_birthday }"> --%>
												<div class="form-group">
													<label for="member_birthday">생년월일<br/></label>
													<input type="text" id="yy" placeholder="년(4자)" value="">
													<select id="mm">
														<option value="not" selected>월</option>
														<c:forEach begin="1" end="12" var="mm">
															<option value="<c:if test="${mm < 10}">0</c:if>${mm}">${mm}월</option>
														</c:forEach>
													</select>
													<input type="text" id="dd" placeholder="일 ex:02, 11">
												</div>
											</div>
											<div>
												<hr/>
												<label>이메일</label>
												<input id="member_email" name="member_email" type="text" value="${memberVo.member_email }" readonly>
												<button id="btnEmailModal" type="button" class="btn btn-success">이메일 변경</button>
											</div>
											<div>
												<hr/>
												<label for="member_adress">주소</label>
												<input type="text" id="member_address" name="member_address" placeholder="주소 검색을 통해 입력해주세요." value="${memberVo.member_address}" style="width:300px;" readonly/>
												<button id="btnAddressSearch" type="button" class="btn btn-primary">주소 검색</button>
											</div>
											<hr/>
											<button id="btnFormRun" type="button" class="btn btn-primary">
												저장
											</button>
											<a type="button" class="btn btn-danger" href="/member/myPage?clickCategory=myPage">취소</a>
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