<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="../include/header.jsp"%>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="../include/aside.jsp"%>
<!-- 부트 스트랩 추가 -->
<%@ include file="../include/bootstrap.jsp" %>

<style>
	.join_message {
		color: red;
	}
</style>

<script>
// 주소 api 받기
function jusoCallBack(roadFullAddr){
	$("#member_address").val(roadFullAddr);
	$("#address_result").val("true");
}

$(function() {
	
	// 이메일 인증에 필요한 인증 번호
	var authentication_number;
	
	// 회원가입에 실패했다면
	var joinResult = "${joinResult}";
	if(joinResult == "false") {
		alert("회원가입에 실패하셨습니다.");
	}
	
	// 아이디 포커스 벗어날때 이벤트 확인
	$("#member_id").blur(function() {
		$(".id_clone").remove();
		var member_id = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("id_clone");
		
		// 아이디 조건 체크
		var id_rgx = /^[a-z0-9]{5,14}/;
		if(!id_rgx.test(member_id)) {
			var message = "아이디는 5~14자, 영어 소문자와 숫자로만 구성해주세요.";
			resultMessage.find("strong").text(message);
			$(this).after(resultMessage);
			$("#id_result").val("false");
			return false;
		}
		
		var url = "/member/idDupCheck";
		var sendData = {
				"member_id" : member_id
		};
		// 에이잭스로 아이디 중복 체크 요청
		$.get(url, sendData, function(rData) {
			if(rData == "true") {
				var message = "사용 가능한 계정 입니다.";
				resultMessage.find("strong").text(message).css("color", "blue");
				$("#member_id").after(resultMessage);
				$("#id_result").val("true");
				return false;
			}
			var message = "이미 존재하거나 탈퇴한 계정 입니다.";
			resultMessage.find("strong").text(message);
			$("#member_id").after(resultMessage);
			$("#id_result").val("false");
			return false;
		});
	});
	
	// 첫번째 비밀번호 체크
	$("#member_pw").blur(function() {
		$(".pw_clone").remove();
		var member_pw = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("pw_clone");
		
		// 비밀번호 조건 체크
		var pw_rgx = /^[a-z0-9]{6,20}$/;
		if(!pw_rgx.test(member_pw)) {
			var message = "비밀번호는 6~20자 영어 소문자와 숫자로만 이루어져야합니다.";
			resultMessage.find("strong").text(message);
			$("#member_pw2").after(resultMessage);
			$("#pw_result").val("false");
			return false;
		}
	});
	
	// 비밀번호 재확인
	$("#member_pw2").blur(function() {
		$(".pw_clone").remove();
		var member_pw = $("#member_pw").val();
		var member_pw2 = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("pw_clone");
		
		if(member_pw != member_pw2) {
			var message = "비밀번호가 일치하지 않습니다. 다시 확인해주세요.";
			resultMessage.find("strong").text(message);
			$(this).after(resultMessage);
			$("#pw_result").val("false");
			return false;
		}
		$("#pw_result").val("true");
	});
	
	// 이름 확인
	$("#member_name").blur(function() {
		$(".name_clone").remove();
		var member_name = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("name_clone");
		
		var name_rgx = /^[가-힣a-zA-Z]{1,20}$/;
		if(!name_rgx.test(member_name)) {
			var message = "이름은 1~20자 한글과 영문자만 가능합니다.";
			resultMessage.find("strong").text(message);
			$(this).after(resultMessage);
			$("#name_result").val("false");
			return false;
		}
		$("#name_result").val("true");
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
	
	// 이메일 확인
	$("#member_email").blur(function() {
		$(".email_clone").remove();
		var email = $(this).val();
		var resultMessage = $("#resultMessage").clone().addClass("email_clone");
		$("#emailSender_check").attr("disabled", true);
		
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
		var to = $("#member_email").val();
		var sendData = {
			"to" : to	
		};
		$.get(url, sendData, function(rData) {
			authentication_number = rData;
			$(".email_clone").remove();
			var message = "성공적으로 이메일을 보냈습니다.";
			resultMessage.find("strong").text(message).css("color", "blue");
			$("#emailSender_check").attr("disabled", false);
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
			$("#email_authentication_result").val("false");
		} else {
			var message = "인증되었습니다.";
			resultMessage.find("strong").text(message);
			$("#email_authentication").after(resultMessage);
			$(".email_clone").find(".join_message").css("color", "blue")
			$("#emailSender").attr("disabled", "true");
			$(this).attr("disabled", "true");
			$("#email_authentication_result").val("true");
			
		}
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
	
	// 휴대전화
	$("#member_phone_number").blur(function() {
		$(".phone_clone").remove();
		var phone_number = $(this).val();
		var phone_rgx  = /^\d{3}\d{3,4}\d{4}$/;
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
	
	// 회원가입 전송이 될 때
	$("#frm_join").submit(function() {
		var member_address = $("#member_address").val();
		var address_length = member_address.length;
		if(address_length != 0) {
			$("#address_result").val("true");
		} else {
			$("#address_result").val("false");
		}
		
		var yy = $("#yy").val();
		var mm = $("#mm option:selected").val();
		var dd = $("#dd").val();
		var yymmdd = yy + mm + dd;
		$("#member_birthday").val(yymmdd);
		
		var id_result = $("#id_result").val();
		var pw_result = $("#pw_result").val();
		var name_result = $("#name_result").val();
		var nickname_result = $("#nickname_result").val();
		var email_result = $("#email_result").val();
		var email_authentication_result = $("#email_authentication_result").val();
		var birth_result = $("#birth_result").val();
		var address_result = $("#address_result").val();
		var phone_result = $("#phone_result").val();
		
		if(id_result != 'true' || pw_result != 'true' || name_result != 'true' || nickname_result != 'true' || email_result != 'true' ||
			email_authentication_result != "true" || birth_result != 'true' || address_result != 'true'|| phone_result != 'true') {
			alert("잘못된 항목이 있습니다. 다시 확인해주세요.");
			return false;
		}
	});
	
	// 취소 버튼 클릭
	$("#btnCancle").click(function() {
		location.href = "/member/loginForm";
	});
	
	// 검색 창 띄우기
	$("#btnAddressSearch").click(function() {
		var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	});
});
</script>
<input type="hidden" id="id_result">
<input type="hidden" id="pw_result">
<input type="hidden" id="name_result">
<input type="hidden" id="nickname_result">
<input type="hidden" id="email_result">
<input type="hidden" id="email_authentication_result">
<input type="hidden" id="yy_result">
<input type="hidden" id="mm_result">
<input type="hidden" id="dd_result">
<input type="hidden" id="birth_result">
<input type="hidden" id="address_result">
<input type="hidden" id="phone_result">
<div id="resultMessage"><span><strong class="join_message"></strong></span></div>
<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>회원가입</h2>
						<p>양식에 맞춰서 입력해주세요.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<form id="frm_join" role="form" action="/member/joinRun" method="post">
						<input type="hidden" id="member_birthday" name="member_birthday">
						<div class="form-group">
							<label for="member_id">아이디</label>
							<input type="text" class="form-control" id="member_id" name="member_id"/>
						</div>
						<div class="form-group">
							<label for="member_pw">비밀번호</label>
							<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="비밀번호"/>
							<input type="password" class="form-control" id="member_pw2" name="member_pw2" placeholder="비밀번호 재확인"/>
						</div>
						<div class="form-group">
							<label for="member_nickname">이름</label>
							<input type="text" class="form-control" id="member_name" name="member_name"/>
						</div>
						<div class="form-group">
							<label for="member_nickname">닉네임</label>
							<input type="text" class="form-control" id="member_nickname" name="member_nickname"/>
						</div>
						<div class="form-group">
							<label for="member_email">이메일</label>
							<input type="email" class="form-control" id="member_email" name="member_email"/>
							<input type="text" class="form-control" id="email_authentication" placeholder="인증번호 | 메일을 보내셔야 입력 가능합니다." readonly/>
							<button id="emailSender_check" type="button" class="btn btn-sm btn-primary" disabled>인증 확인</button>
							<button id="emailSender" type="button" class="btn btn-sm btn-primary">메일 보내기</button>
						</div>
						<div class="form-group">
							<label for="member_birthday">생년월일<br/></label>
							<div>
								<input type="text" id="yy" placeholder="년(4자)">
								<select id="mm">
									<option value="not" selected>월</option>
									<c:forEach begin="1" end="12" var="mm">
										<option value="<c:if test="${mm < 10}">0</c:if>${mm}">${mm}월</option>
									</c:forEach>
								</select>
								<input type="text" id="dd" placeholder="일 ex:02, 11">
							</div>
						</div>
						<div class="form-group">
							<label for="member_adress">주소</label>
							<input type="text" class="form-control" id="member_address" name="member_address" placeholder="주소 검색을 통해 입력해주세요." readonly/>
							<button id="btnAddressSearch" type="button" class="btn btn-primary">주소 검색</button>
						</div>
						<div class="form-group">
							<label for="member_phone_number">휴대전화</label>
							<input type="text" class="form-control" id="member_phone_number" name="member_phone_number" placeholder="01012345678"/>
						</div>
						<button id="btnSubmit" type="submit" class="btn btn-primary">작성완료</button>
						<button id="btnCancle" type="button" class="btn btn-primary">취소</button>
					</form>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>