<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header 스크립트 설정 부분 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<style>
	.modalForm {
		text-align: center;
		line-height: 10px;
		margin-bottom: 20px;
	}
	
	<!-- 모달 창 스크롤 바 추가 -->
	.modal-dialog{
    overflow-y: initial !important
	}
	.sizeModal{
	    height: 400px;
	    overflow-y: auto;
	}
</style>
<script src="/resources/js/timeChange.js"></script>
<script src="/resources/js/paginationMaker.js"></script>
<script>
$(function() {
	
	// 정지 결과
	var suspensionResult = "${suspensionResult}";
	if(suspensionResult == "success") {
		alert("해당 이용자를 정지시켰습니다.");
	} else if(suspensionResult == "fail") {
		alert("정지에 실패하였습니다.");
	}
	// 게시글
	$(".showBoard").click(function(e) {
		e.preventDefault();
		var member_id = $(this).attr("data-memberId");
		
		$("#hiddenBoardKeyword").val(member_id);
		$("#showMemberBoardList").submit();
	});
	
	// 댓글
	$(".showComment").click(function(e) {
		e.preventDefault();
		var member_id = $(this).attr("data-memberId");
		
		$("#hiddenCommentKeyword").val(member_id);
		$("#showMemberCommentList").submit();
	});
	
	// 상태 클릭시 해당에 맞는 모달 출력
	$("#memberTable").on("click", ".accessSet", function(e) {
		e.preventDefault();
		var member_id = $(this).parent().parent().find(".mId").text();
		var member_state = $(this).parent().attr("data-state");
		$("#mIdStrong").text(member_id);
		$("input:radio[name='member_state']").filter("[value=" + member_state + "]").prop("checked", "true");
		$("#accessModalBtn").trigger("click");
	});
	
	// 상태 변경시키기
	$("#stateChangeBtn").click(function() {
		var member_id = $("#mIdStrong").text();
		var member_state = $("input[name='member_state']:checked").val();
		
		$("#hiddenId").val(member_id);
		$("#hiddenState").val(member_state);
		
		$("#changeState").submit();
	});
	
	// 정지 내역 보여주기
	$(".showSuspensionRecord").click(function(e) {
		e.preventDefault();
		$(".noneModalForm").remove();
		$("#endDateChangeBtn").remove();
		$(".pagination").remove();
		// 정지 변경 버튼 초기화
		endType = 1;
		var member_id = $(this).attr("data-memberId");
		var url = "/admin/showSuspensionRecord";
		var sendData = {
				"member_id" : member_id
		};
		
		$.get(url, sendData, function(rDate) {
			$.each(rDate, function() {
				var modalClone = $("#noneModalForm").clone();
				var suspensionNo = this.suspension_no;
				var suspensionReason = this.suspension_reason;
				var suspensionStartDate = seconds(this.suspension_start_date);
				var suspensionEndDate =  seconds(this.suspension_end_date);
				var suspensionState =  this.suspension_state;
				
				// 다음 실행때 삭제를 위해 클래스 부여
				modalClone.addClass("noneModalForm");
				modalClone.css("display", "");
				
				modalClone.find("#suspensionReason").text(suspensionReason);
				modalClone.find("#suspensionStartDate").text(suspensionStartDate);
				modalClone.find("#suspensionEndDate").text(suspensionEndDate);
				
				// 정지 일자가 오늘 날보다 예전일 경우 변경 해제 버튼을 생성하기
				var result = dateCompare(suspensionEndDate);
				if(result != 'true' && suspensionState == 'Y') {
					var btnChangeHtml = "<button type='button' class='btn btn-sm btn-danger btnChange' data-no='" + suspensionNo + "' data-memberId='" + member_id + "'>변경</button>";
					modalClone.find("#suspensionBtn").append(btnChangeHtml);
					var btnReleaseHtml = "<button type='button' class='btn btn-sm btn-success btnRelease' data-no='" + suspensionNo + "' data-memberId='" + member_id + "'>해제</button>";
					modalClone.find("#suspensionBtn").append(btnReleaseHtml);
				} else {
					var suspensionMessageHtml = "<span style='color : blue;'>정지해제</span>";
					modalClone.find("#suspensionBtn").append(suspensionMessageHtml);
				}
				
				$("#showContent").append(modalClone);
			});
		});
		
		$("#showSuspensionBtn").modal("show");
	});
	
	// 정지 버튼 클릭 이벤트
	$(".memberSuspension").click(function(e) {
		e.preventDefault();
		var member_id = $(this).attr("data-memberId");
		var suspension = $(this).attr("data-suspension");
		$("#btnSuspension").attr("data-memberId", member_id);
		$("#btnSuspension").attr("data-suspension", suspension);
		$("#suspensionStartBtn").modal("show");
	});
	
	// 정지 시키기
	$("#btnSuspension").click(function() {
		var suspension = $(this).attr("data-suspension");
		if(suspension == 'Y') {
			alert("이미 정지 중인 사용자 입니다.");
			return;
		}
		var member_id = $(this).attr("data-memberId");
		var suspensionReasonInput = $("#suspensionReasonInput").val();
		var endDateInput = $("#endDateInput").val();
		var endTimeInput = $("#endTimeInput").val();
		
		// 입력된 날짜가 없으면 중지하고 알람창, 시간이 없다면 00:00:00으로 고정시키기
		if(endDateInput.length == 0) {
			alert("날짜를 선택해주세요.");
			return;
		}
		if(endTimeInput.length == 0) {
			time = "00:00";
		}
		
		insertSuspensionSubmit(member_id, suspensionReasonInput, endDateInput, endTimeInput);
	});
	
	// 정지 종료일 변경
	// 정지 종료일을 변경하면 정지 종료일의 state를 N으로 업데이트 시키고 새로 종료일을 insert 시킴
	// 해당 버튼과 상관없는 데이터가 필요하기 때문에 전역변수 선언
	var oriEndDateHtml = "";
	var endType = 1;
	var targetId = "";
	$("#modalConent").on("click", ".btnChange", function() {
		// 필요한 데이터와 위치를 지역 변수에 저장
		var btnChagneDiv = $(this).parent();
		var cloneDiv = $(this).parent().parent();
		var endDate = cloneDiv.find("#suspensionEndDate");
		targetId = cloneDiv;
		var suspensionNo = $(this).attr("data-no");
		var member_id = $(this).attr("data-memberId");
		// 변경 버튼을 처음 누르면 종료일을 설정할 수 있는 칸으로 종료일을 변경 및 저장 버튼 생성
		// 다시 누르면 원래대로 돌려놓음.
		if(endType == 1) {
			// 종료일을 html으로 직접 적어서 입력, 버튼을 변경
			oriEndDateHtml = endDate.text();
			var newEndDateHtml = "<input type='date' id='endDateInput'>";
			newEndDateHtml += "<input type='time' id='endTimeInput'>";
			endDate.html(newEndDateHtml);
			var btnDiv = $(this).closest("#modal").find("#btnEndDiv");
			var btnHtml = "<button id='endDateChangeBtn' class='btn btn-success' data-no='" + suspensionNo + "' data-memberId='" + member_id + "'>저장</button>";
			btnDiv.prepend(btnHtml);
			// 변경 버튼 지우고 취소 버튼 생성
			$(this).remove();
			var btnCancleHtml = "<button type='button' class='btn btn-sm btn-secondary btnChange'>취소</button>";
			btnChagneDiv.prepend(btnCancleHtml);
			// 끝나면 타입을 다음 번호로 변경해둠
			endType = 2;
		} else {
			// 기존에 저장해둔 종료일을 다시 입력하고 취소 버튼을 지우고 변경 버튼 생성
			endDate.text(oriEndDateHtml);
			$(this).remove();
			var btnChagneHtml = "<button type='button' class='btn btn-sm btn-danger btnChange' data-no='" + suspensionNo + "' data-memberId='" + member_id + "'>변경</button>";
			btnChagneDiv.prepend(btnChagneHtml);
			$("#endDateChangeBtn").remove();
			// 끝나면 타입 1로 되돌리기
			endType = 1;
		}
	});
	
	// 정지 해제
	$("#modalConent").on("click", ".btnRelease", function() {
		// 해당 정지 내역을 업데이트 시켜서 비활성화 시키기
		var member_id = $(this).attr("data-memberId");
		var dataNo = $(this).attr("data-no");
		var url = "/admin/updateSuspension";
		var sendData = {
			"member_id" : member_id,
			"suspension_no" : dataNo
		};
		
		$.get(url, sendData, function(rDate) {
			if(rDate == "success") {
				location.reload();
				$("#modalConent").hide();
			} else {
				alert("시간 설정이 잘못되었습니다. 다시 한번 확인해주세요.");
			}
		});
	});
	
	// 정지 종료일 변경
	$("#modal").on("click", "#endDateChangeBtn", function() {
		var reason = targetId.find("#suspensionReason").text();
		var date = targetId.find("#endDateInput").val();
		var time = targetId.find("#endTimeInput").val();
		// 입력된 날짜가 없으면 중지하고 알람창, 시간이 없다면 00:00:00으로 고정시키기
		if(date.length == 0) {
			alert("날짜를 선택해주세요.");
			return;
		}
		if(time.length == 0) {
			time = "00:00";
		}
		
		// 해당 정지 내역을 업데이트 시켜서 비활성화 시키기
		var member_id = $(this).attr("data-memberId");
		var dataNo = $(this).attr("data-no");
		var url = "/admin/updateSuspension";
		var sendData = {
			"member_id" : member_id,
			"suspension_no" : dataNo
		};
		
		$.get(url, sendData, function(rDate) {
			if(rDate == "success") {
				// 정지 할려는 영역의 번호를 확인하고 해당 번호를 비활성화 하고 새로 정지 인설트 시키기
				insertSuspensionSubmit(member_id, reason, date, time);
			} else {
				alert("시간 설정이 잘못되었습니다. 다시 한번 확인해주세요.");
			}
		});
	});
	
	// 검색
	$("#searchBtn").click(function() {
		var chocieState = $("#chocieState option:selected").val();
		var keyword = $("#keyword").val();
		
		$("#hiddenStateTpye").val(chocieState);
		$("#hiddenKeyword").val(keyword);
		
		$("#memberSearchForm").submit();
	});
	
	// 페이징 이벤트 달아서 검색 조건도 같이 보내기
	$("#pagination").on("click", ".pagingBtn", function(e) {
		e.preventDefault();
		var page = $(this).text();
		$("#hiddenPage").val(page);
		$("#pagingForm").submit();
	});
	
	function insertSuspensionSubmit(member_id, suspensionReason, endDate, endTime) {
		var suspensionEndDate = endDate + " " + endTime + ":00";
		
		$("#member_id").val(member_id);
		$("#suspension_reason").val(suspensionReason);
		$("#suspension_end_date").val(suspensionEndDate);
		
		$("#insertSuspension").submit();
	};
});
	
</script>

<!-- 검색할 경우 보낼 폼 -->
<form id="memberSearchForm" action="/admin/memberMngForm" method="get">
	<input type="hidden" id="hiddenStateTpye" name="stateType">
	<input type="hidden" id="hiddenKeyword" name="keyword">
</form>
<!-- 페이징 버튼 폼 -->
<form id="pagingForm" action="/admin/memberMngForm" method="get">
	<input type="hidden" id="hiddenPage" name="page">
	<input type="hidden" name="stateType" value="${pagingDto.stateType}">
	<input type="hidden" name="keyword" value="${pagingDto.keyword}">
</form>
<!-- 게시글 수 클릭 시 게시글 화면으로 이동시킬 폼 -->
<form id="showMemberBoardList" action="/admin/boardMngForm" method="get">
	<input type="hidden" name="keywordType" value="typeId"> 
	<input type="hidden" id="hiddenBoardKeyword" name="keyword"> 
</form>
<!-- 댓글 수 클릭 시 게시글 화면으로 이동시킬 폼 -->
<form id="showMemberCommentList" action="/admin/commentMngForm" method="get">
	<input type="hidden" name="keywordType" value="typeId"> 
	<input type="hidden" id="hiddenCommentKeyword" name="keyword"> 
</form>
<!-- 상태 변경 폼 -->
<form id="changeState" action="/admin/changeStateRun" method="post">
	<input type="hidden" id="hiddenId" name="member_id">
	<input type="hidden" id="hiddenState" name="member_state">
	<input type="hidden" name="page" value="${pagingDto.page }">
	<input type="hidden" name="stateType" value="${pagingDto.stateType}">
	<input type="hidden" name="keyword" value="${pagingDto.keyword}">
</form>
<!-- 정지 시킬때 사용할 폼 -->
<form id="insertSuspension" action="/admin/insertSuspension" method="post">
	<input type="hidden" name="page" value="${pagingDto.page }">
	<input type="hidden" id="member_id" name="member_id">
	<input type="hidden" id="suspension_reason" name="suspension_reason">
	<input type="hidden" id="suspension_end_date" name="suspension_end_date">
</form>
<!-- 보여주지 않을 정지 모달 양식 -->
<div id="noneModalForm" style="display:none;" class="row" style="line-height:11px; margin-bottom: 20px;">
	<div id="suspensionReason" class="col-md-4 modalForm"></div>
	<div id="suspensionStartDate" class="col-md-3 modalForm"></div>
	<div id="suspensionEndDate"class="col-md-3 modalForm"></div>
	<div id="suspensionBtn"class="col-md-2 modalForm"></div>
</div>

<!-- 정지내역에 사용할 모달 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<a id="modal-778343" style="display:none;" href="#modal-container-778343" role="button" class="btn" data-toggle="modal">Launch demo modal</a>
			<div class="modal fade" id="showSuspensionBtn" data-remote="false" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div id="modal" class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalTitle">정지내역</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div id="modalConent" class="modal-body modal-lg sizeModal">
							<div id="showContent" class="container-fluid">
								<div class="row" style="margin-bottom: 20px; text-align: center;">
									<div class="col-md-4"><span>정지사유</span></div>
									<div class="col-md-3"><span>시작일</span></div>
									<div class="col-md-3"><span>종료일</span></div>
									<div class="col-md-2"></div>
								</div>
							</div>
						</div>
						<div id="btnEndDiv" class="modal-footer">
							<button id="btnCancle" type="button" class="btn btn-secondary" data-dismiss="modal">
								취소
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 정지 시키는 쪽에 쓸 모달 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<a id="modal-778343" style="display:none;" href="#modal-container-778343" role="button" class="btn" data-toggle="modal">Launch demo modal</a>
			<div class="modal fade" id="suspensionStartBtn" data-remote="false" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div id="modal" class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalTitle"></h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div id="modalConent" class="modal-body modal-lg sizeModal">
							<div id="suspensionContent" class="container-fluid">
								<div class="row" style="margin-bottom: 20px; text-align: center;">
									<div class="col-md-5"><span>정지사유</span></div>
									<div class="col-md-5"><span>종료일</span></div>
									<div class="col-md-2"><span></span></div>
								</div>
								<div>
									<input type="text" id="suspensionReasonInput"class="col-md-5" maxlength="20" placeholder="정지 사유를 입력해주세요.">
									<input type="date" id="endDateInput" class="col-md-3">
									<input type="time" id="endTimeInput" class="col-md-3">
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button id="btnSuspension" type="button" class="btn btn-danger" data-dismiss="modal">
								정지
							</button>
							<button id="btnCancle" type="button" class="btn btn-secondary" data-dismiss="modal">
								취소
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 상태 모달 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			 <a id="accessModalBtn" href="#modal-container-30914" style="display:none;" role="button" class="btn" data-toggle="modal">Launch demo modal</a>
			<div class="modal fade" id="modal-container-30914" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">
								상태 변경
							</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body" style="height: 100px;">
							<div>
								<strong>아이디 : </strong>
								<strong id="mIdStrong"></strong>
							</div>
							<input type="radio" name="member_state" value="A">관리자
							<input type="radio" name="member_state" value="Y">활동 유저
							<input type="radio" name="member_state" value="N">탈퇴
						</div>
						<div class="modal-footer">
							<button id="stateChangeBtn" type="button" class="btn btn-success">
								확인
							</button> 
							<button type="button" class="btn btn-secondary" data-dismiss="modal">
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
<%@ include file="/WEB-INF/views/include/aside.jsp"%>
<!-- 어드민 페이지 상단 메뉴 -->
<%@ include file="../adminInclude/adminMenuHeader.jsp" %>

<!-- 검색 기능 -->
<div id="selectDiv" style="text-align: right;" class="col-md-10">
	<select id="chocieState">
		<option value="">전체</option>
		<option value="N"
		<c:if test="${pagingDto.stateType eq 'N'}">
		selected
		</c:if>
		>탈퇴</option>
		<option value="A"
		<c:if test="${pagingDto.stateType eq 'Y'}">
		selected
		</c:if>
		>관리자</option>
		<option value="Y"
		<c:if test="${pagingDto.stateType eq 'Y'}">
		selected
		</c:if>
		>활동</option>
	</select>
	<span>
		<input type="text" id="keyword" placeholder="검색어를 입력해주세요." value="${pagingDto.keyword }">
	</span>
	<button id="searchBtn" type="button" class="btn btn-sm btn-success">검색</button>
</div>
<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-9">
			<table class="table">
				<thead>
					<tr style="text-align: center;">
						<th>아이디</th>
						<th>닉네임</th>
						<th>게시글 수</th>
						<th>댓글 수</th>
						<th>상태</th>
						<th>제제</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="memberTable">
					<c:forEach items="${memberMngList}" var="MemberMngVo">
						<tr style="text-align: center;">
							<td class="mId">${MemberMngVo.member_id}</td>
							<td>${MemberMngVo.member_nickname }</td>
							<td>
								<a href="/#" class="showBoard" data-memberId="${MemberMngVo.member_id}">${MemberMngVo.board_num }</a>
							<td>
								<a href="/#" class="showComment" data-memberId="${MemberMngVo.member_id}">${MemberMngVo.comment_num }</a>
							</td>
							<!-- 상태 -->
							<td data-state="${MemberMngVo.member_state }">
							<c:choose>
								<c:when test="${MemberMngVo.member_state == 'Y'}">
								<a href="/#" class="accessSet" style="color:green;">활동</a>
								</c:when>
								<c:when test="${MemberMngVo.member_state == 'A'}">
								<a href="/#" class="accessSet" style="color:#ff7f00;">관리자</a>
								</c:when>
								<c:otherwise>
								<a href="/#" class="accessSet" style="color:red;">탈퇴</a>
								</c:otherwise>
							</c:choose>
							</td>
							<!-- 제제 -->
							<c:choose>
								<c:when test="${MemberMngVo.suspension == 'Y'}">
								<td>
									<a href="/#" class="showSuspensionRecord" style="color: red;" data-memberId="${MemberMngVo.member_id}">정지중</a>
								</td>
								</c:when>
								<c:otherwise>
								<td>
									<a href="/#" class="showSuspensionRecord" data-memberId="${MemberMngVo.member_id}">정상활동</a>
								</td>
								</c:otherwise>
							</c:choose>
							<!-- 정지시키기 -->
							<td style="text-align: left;">
								<a href="/#" class="btn btn-sm btn-danger memberSuspension" data-memberId="${MemberMngVo.member_id}" data-suspension="${MemberMngVo.suspension }">정지</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 페이징 작업 하기 -->
			<div class="row">
	          <div class="col text-center text-md-left">
	            <div class="block-27" id="pagination">
	              <ul style="text-align: center;">
	              	<!-- 페이징 화살표 처리 확인 필요 -->
	              	<!-- 왼쪽 화살표 -->
	              	<c:if test="${pagingDto.startPage != 1 }">
	                <li><a href="#">&lt;</a></li>
	              	</c:if>
	                <!-- 페이징 넘버링 -->
	                <c:forEach var="paging" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
	                <li
	                <c:if test="${pagingDto.page == paging}">
	                class="active"
	                </c:if>
	                ><a href="/#"class="pagingBtn">${paging}</a>
	                </c:forEach>
	                <!-- 오른쪽 화살표 -->
	                <c:if test="${pagingDto.endPage < pagingDto.totalPage}">
	                <li><a href="#">&gt;</a></li>
	                </c:if>
	              </ul>
	            </div>
	          </div>
	        </div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
<!-- 어드민 페이지 메뉴 -->
<%@ include file="../adminInclude/adminMenuFooter.jsp" %>

<!-- footer 링크 설정 부분 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
