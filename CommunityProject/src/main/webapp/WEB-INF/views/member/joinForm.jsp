<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
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
						<h2>회원가입</h2>
						<p>양식에 맞춰서 입력해주세요.</p>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<form role="form" action="/member/joinRun" method="post">
						<div class="form-group">
							<label for="member_id">아이디</label>
							<input type="text" class="form-control" id="member_id" name="member_id" required/>
						</div>
						<div class="form-group">
							<label for="member_pw">비밀번호</label>
							<input type="password" class="form-control" id="member_pw" name="member_pw" required/>
						</div>
						<div class="form-group">
							<label for="member_nickname">닉네임</label>
							<input type="password" class="form-control" id="member_nickname" name="member_nickname" required/>
						</div>
						<div class="form-group">
							<label for="member_email">이메일</label>
							<input type="email" class="form-control" id="member_email" name="member_email"/>
						</div>
						<div class="form-group">
							<label for="member_birthday">생년월일<br/></label>
							<select id="member_brithday" name="member_brithday">
								<c:forEach begin="1900" end="2020" var="year">
									<option value="${year}">${year}</option>
								</c:forEach>
							</select>
							년
							<select id="member_brithday" name="member_brithday">
								<c:forEach begin="1" end="12" var="year">
									<option value="${year}">${year}</option>
								</c:forEach>
							</select>
							월
							<select id="member_brithday" name="member_brithday">
								<c:forEach begin="1" end="31" var="year">
									<option value="${year}">${year}</option>
								</c:forEach>
							</select>
							일
						</div>
						<div class="form-group">
							<label for="member_phone_number">휴대전화</label>
							<input type="password" class="form-control" id="member_phone_number" name="member_phone_number" required/>
						</div>
						<div class="form-group">
							<label for="member_adress">주소</label>
							<input type="password" class="form-control" id="member_adress" name="member_adress" required/>
						</div>
						<button id="btnSubmit" type="button" class="btn btn-primary">작성완료</button>
					</form>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
</div><!-- END COLORLIB-MAIN -->

<!-- footer 링크 설정 부분 -->
<%@ include file="../include/footer.jsp"%>