<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!-- header 스크립트 설정 부분 -->
<%@ include file="../include/header.jsp"%>
<!-- 부트 스트랩 추가 -->
<%@ include file="../include/bootstrap.jsp" %>
<style>
	#info {
		display: block;
		font-weight: normal;
		font-size: 20px;
		margin-bottom: 10px;
	}
	
	.showTag {
		font-size: 20px;
	}
	
	#countDiv {
		width: 520px;
		height: 300px;
	}
	
	.text-left {
		display: block;
		text-align: right;
	}
	
	ul {
		justify-content: center;
	} 
	
	.modalForm {
		text-align: center;
		line-height: 10px;
		margin-bottom: 20px;
	}
</style>
<script src="/resources/js/timeChange.js"></script>
<script src="/resources/js/paginationMaker.js"></script>
<script>
$(function() {
	
	$(".joinDate").each(function() {
		var joinTime = $(this).text();
		var timeSeconds = seconds(joinTime);
		$(this).text(timeSeconds);
	});
	
	// 페이징 작업을 위한 인덱스
	var pageIndex = 1;
	var startIndex = 0;
	var endIndex = 0;
	// 게시판 체크인지 댓글 체크인지 구분하기 위해서 초기화
	var allCheckType = "";
	// 게시판 댓글 번호를 저장하기 위한 배열 선언
	var boardArr = new Array();
	var commentArr = new Array();
	// 페이지 버튼의 타입을 결정할 변수
	var pageBtnType = "";
	
	// 게시글 보기
	$("#showBoard").click(function(e) {
		e.preventDefault();
		$(".noneModalForm").remove();
		$(".pagination").remove();
		$("#divView").text("");
		$("#divUp").text("");
		$("#divView").text("조회수");
		$("#divUp").text("좋아요");
		allCheckType = "boardCheck";
		
		var member_id = "${memberVo.member_id}";
		var board_count = "${boardCommentCountMap['BOARD_COUNT']}";
		var page = pageIndex;
		
		// 게시글 불러오기
		var url = "/member/myPageShowBoard";
		var sendData = {
				"member_id" : member_id,
				"board_count" : board_count,
				"page" : page
		};
		$.get(url, sendData, function(rDate) {
			var list = rDate.boardList;
			// 페이징 버튼 만들기
			paginationMaker(rDate, "#pagination");
			startIndex = rDate.startPage;
			endIndex = rDate.endPage;
			$("#modalTitle").text("게시글 보기");
			$.each(list, function() {
				var board_clone = $("#noneModalForm").clone();
				var board_num = this.board_num;
				var category_code = this.category_code;
				var board_title = this.board_title;
				var board_reg_t = this.board_reg_t;
				var comment_count = this.comment_count;
				var board_view = this.board_view;
				var board_up = this.board_up;
				
				board_clone.css("display", "");
				// 다음 실행때 삭제를 위해 클래스 부여
				board_clone.addClass("noneModalForm");
				board_clone.find("#modalCheck").attr("data-boardNum", board_num);
				board_clone.find("#modalCheck").attr("class", "boardCheck");
				
				// 글자의 길이가 10이 넘어가면 뒤에부분 삭제하고 ... 붙이기
				var titleLength = board_title.length;
				if(titleLength > 10) {
					board_title = board_title.substring(0, 10);
					board_title = board_title + "...";
				}
				// 제목에 a태그 걸기
				var titleLink = "<a href='/board/boardInfo?board_num=" + board_num + "&category_code=" + 								 									
									category_code + "'>" + board_title + "</a>"
									
				board_clone.find("#modalBoardCommentTitle").html(titleLink);
				board_clone.find("#commentCount").text("  [" + comment_count + "]");
				board_clone.find("#modalView").text(board_view);
				board_clone.find("#modalUp").text(board_up);
				
				// 시간 밀리초로 변환
				var timeSeconds = seconds(board_reg_t);
				board_clone.find("#modalRegDate").text(timeSeconds);
				
				$("#showContent").append(board_clone);
			});
		});
		
		// 삭제 버튼의 타입 변경
		$(".btnDelete").attr("id", "btnBoardDelete");
		// 페이지 버튼 타입 변경
		pageBtnType = "board";
		$("#startModalBtn").modal("show");
	});
	
	// 댓글 보기
	$("#showComment").click(function(e) {
		e.preventDefault();
		$(".noneModalForm").remove();
		$(".pagination").remove();
		$("#divView").text("");
		$("#divUp").text("");
		allCheckType = "commentCheck";
		
		var member_id = "${memberVo.member_id}";
		var comment_count = "${boardCommentCountMap['COMMENT_COUNT'] }";
		var page = pageIndex;
		var url = "/member/myPageShowComment";
		var sendData = {
				"member_id" : member_id,
				"comment_count" : comment_count,
				"page" : page
		};
		$.get(url, sendData, function(rDate) {
			var list = rDate.commentList;
			paginationMaker(rDate, "#pagination");
			startIndex = rDate.startPage;
			endIndex = rDate.endPage;
			$("#modalTitle").text("댓글 보기");
			$.each(list, function() {
				var comment_clone = $("#noneModalForm").clone();
				var comment_num = this.comment_num;
				var board_num = this.board_num;
				var comment_content = this.comment_content;
				var comment_reg_t = this.comment_reg_t;
				var board_state = this.board_state;
				
				// 다음 실행때 삭제를 위해 클래스 부여
				comment_clone.css("display", "");
				comment_clone.addClass("noneModalForm");
				comment_clone.find("#modalCheck").attr("data-commentNum", comment_num);
				comment_clone.find("#modalCheck").attr("data-boardNum", board_num);
				comment_clone.find("#modalCheck").attr("class", "commentCheck");
				
				// 글자의 길이가 10이 넘어가면 뒤에부분 삭제하고 ... 붙이기
				var titleLength = comment_content.length;
				if(titleLength > 10) {
					comment_content = comment_content.substring(0, 10);
					comment_content = comment_content + "...";
				}
				
				// 제목에 a태그 걸기, 댓글을 달았던 게시글이 삭제되었는지 확인을 위해 data-boardState 속성을 추가
				var category_code = "${category_code}";
				var titleLink = "<a class='titleLink' href='/board/boardInfo?board_num=" + board_num + "&category_code=" + category_code
								+ "' data-boardState=" + board_state + ">" + comment_content + "</a>"
				comment_clone.find("#modalBoardCommentTitle").html(titleLink);
				
				// 시간 밀리초로 변환
				var timeSeconds = seconds(comment_reg_t);
				comment_clone.find("#modalRegDate").text(timeSeconds);
				
				$("#showContent").append(comment_clone);
			});
		});
		
		// 삭제 버튼의 타입 변경
		$(".btnDelete").attr("id", "btnCommentDelete");
		// 페이지 버튼 타입 변경
		pageBtnType = "comment";
		$("#startModalBtn").modal("show");
	});
	
	// 댓글을 달았던 게시글이 삭제되있다면 페이지 이동 이벤트를 막고 경고창 뛰우기
	$("#modal").on("click", ".titleLink", function(e) {
		var board_state = $(this).attr("data-boardState");
		if(board_state == 'N') {
			alert("삭제된 게시글 입니다.");		
			e.preventDefault();
		}
	});
	
	// 게시판 체크박스 선택 시 이벤트, input으로 만들어서 해당 boardDelete 컨트롤러로 전송.
	// 체크 박스 선택 시 배열에 hidden 타입의 input의 아이디를 담고
	// 체크 박스 해제 시 배열을 반복을 돌려서 해제한 값과 같은 값을 찾아 지우기
	$("#modal").on("change", ".boardCheck", function() {
		if(this.checked == true) {
			var boardNum = $(this).attr("data-boardNum");
			var hiddenBoardInput = "<input type='hidden' id='board_num" + boardNum + "' name='board_num' value='" + boardNum + "'>";
			boardArr.push("board_num" + boardNum);
			$("#boardDeleteForm").append(hiddenBoardInput);
		} else {
			var boardCheckedId = "board_num" + $(this).attr("data-boardNum");
			
			$.each(boardArr, function(index) {
				var board_checked = this;
				if(board_checked == boardCheckedId) {
					boardArr.splice(index, 1);
					$("#" + boardCheckedId).remove();
				}
			});
		}
	});
	
	// 댓글 체크박스 선택 시 이벤트, input으로 만들어서 해당 deleteComment 컨트롤러로 전송.
	// 체크 선택시 미리 만들어둔 배열에 담고, 해제시 commentNum을 찾아 지우고 그 위치의 boardArr 지우기
	// 체크 박스 해제 시 배열을 반복을 돌려서 해제한 값과 같은 값을 찾아 지우기
	$("#modalConent").on("change", ".commentCheck", function() {
		if(this.checked == true) {
			var commentNum = $(this).attr("data-commentNum");
			var boardNum = $(this).attr("data-boardNum");
			
			commentArr.push(commentNum);
			boardArr.push(boardNum);
		} else {
			var commentNum = $(this).attr("data-commentNum");
			var boardNum = $(this).attr("data-boardNum");
			
			$.each(commentArr, function(index) {
				var checkNum = this;
				if(commentNum == checkNum) {
					commentArr.splice(index, 1);
					boardArr.splice(index, 1);
				}
			});
		}
	});
	
	// 게시글 삭제 전송하기
	// board 컨트롤러에 있는 삭제 기능을 재활용하기(에이젝스X)
	$("#modal").on("click", "#btnBoardDelete", function() {
		$("#boardDeleteForm").submit();
	});
	
	// 댓글 삭제()
	// comment 컨트롤러에 있는 삭제 기능 재활용하기(에이젝스O)
	$("#modal").on("click", "#btnCommentDelete", function() {
		// ajax 배열 넘기기 위해선 설정 바꿔야함.
		jQuery.ajaxSettings.traditional = true;
		
		var url = "/comment/deleteComment";
		var sendData = {
				"comment_num" : commentArr,
				"board_num" : boardArr
		};
		
		$.get(url, sendData, function(rDate) {
			if(rDate == "success") {
				alert("성공적으로 댓글을 삭제하였습니다.");
				location.reload();
			}
		});
	});
	
	// 전체 선택/해제, 트리거를 이용해서 change 이벤트 사용
	$("#allCheckBtn").click(function() {
		if($("." + allCheckType).prop("checked")) {
			$("." + allCheckType).prop("checked", false);
			$("." + allCheckType).trigger("change");
		} else {
			$("." + allCheckType).prop("checked", true);
			$("." + allCheckType).trigger("change");
		}
	});
	
	// 게시글 페이징 버튼 이벤트
	// page의 정보를 읽어와서 저장한 후 트리거를 사용해 showBoard를 재시작하여 정보를 새로 불러옴
	$("#pagination").on("click", ".pageBtn", function(e) {
		e.preventDefault();
		reset();
		pageIndex = this.text;
		if(pageBtnType == "board") {
			$("#showBoard").trigger("click");
		} else if(pageBtnType == "comment") {
			$("#showComment").trigger("click");
		}
	});
	
	// 이전 페이지
	$("#pagination").on("click", ".pageStart", function(e) {
		e.preventDefault();
		reset();
		pageIndex = startIndex - 1;
		if(pageBtnType == "board") {
			$("#showBoard").trigger("click");
		} else if(pageBtnType == "comment") {
			$("#showComment").trigger("click");
		}
	});
	// 다음 페이지
	$("#pagination").on("click", ".pageEnd", function(e) {
		e.preventDefault();
		reset();
		pageIndex = endIndex + 1;
		if(pageBtnType == "board") {
			$("#showBoard").trigger("click");
		} else if(pageBtnType == "comment") {
			$("#showComment").trigger("click");
		}
	});
	
	// 모달이 닫혔을때 정보들 초기화 시키기
	$("#startModalBtn").on("hidden.bs.modal", function() {
		reset();
	});
	
	// 회원 탈퇴 폼으로
	$("#memberWthdr").click(function(e) {
		e.preventDefault();
		var confirmflag = confirm("정말로 탈퇴하시겠습니까?");
		if(confirmflag == true) {
			$("#memberWthdrForm").submit();
		}
	});
	
	// 개인정보 수정 폼으로 이동
	$("#memberInfoModify").click(function() {
		$("#modifyForm").submit();
	});
	
	// 게시글 댓글 배열 및 페이지 초기화, 전송을 위한 board_num 삭제
	function reset() {
		commentArr = [];
		boardArr = [];
		pageIndex = 1;
		$("input[name=board_num]").remove();
	}
});
</script>
<!-- 게시글 삭제 -->
<form id="boardDeleteForm" action="/board/deleteBoardRun" method="post"></form>
<!-- memberInfoModify 로 보낼 정보 -->
<form id="modifyForm" action="/member/memberInfoModfiyForm" method="post">
	<input type="hidden" name="clickCategory" value="myPage">
</form>
<!-- 회원 탈퇴 폼 -->
<form id="memberWthdrForm" action="/member/memberWthdrForm" method="get">
	<input type="hidden" name="clickCategory" value="myPage">
</form>
<!-- 보여주지 않을 모달 게시글 양식 -->
<div id="noneModalForm" style="display:none;" class="row" style="line-height:11px; margin-bottom: 20px;">
	<div class="col-md-1" style="float: left;">
		<input id="modalCheck" class="modalCheck" type="checkBox">
	</div>
	<div class="col-md-4 modalForm">
		<span id="modalBoardCommentTitle"></span><strong id="commentCount" style="color: red;"></strong>
	</div>
	<div id="modalView" class="col-md-2 modalForm"></div>
	<div id="modalUp" class="col-md-2 modalForm"></div>
	<div id="modalRegDate"class="col-md-3 modalForm"></div>
</div>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="../include/aside.jsp"%>
<!-- 모달 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<a id="modal-778343" style="display:none;" href="#modal-container-778343" role="button" class="btn" data-toggle="modal">Launch demo modal</a>
			<div class="modal fade" id="startModalBtn" data-remote="false" role="dialog" aria-labelledby="myModalLabel"	aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div id="modal" class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalTitle"></h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div id="modalConent" class="modal-body modal-lg">
							<div id="showContent" class="container-fluid">
								<div class="row" style="margin-bottom: 20px; text-align: center;">
									<div class="col-md-1"></div>
									<div class="col-md-4"><span>제목</span></div>
									<div class="col-md-2" id="divView"></div>
									<div class="col-md-2" id="divUp"></div>
									<div class="col-md-3">작성시간</div>
								</div>
							</div>
							<div>
								<div class="row">
									<div class="col-md-12">
										<nav id="pagination">
											<ul id="pagination" class="pagination">
											</ul>
										</nav>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button id="allCheckBtn" type="button" class="btn btn-primary">
								전체선택/해제
							</button> 
							<button type="button" class="btn btn-danger btnDelete">
								삭제
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
<!-- 본문 -->
<div id="colorlib-main">
	<section class="ftco-section ftco-no-pt ftco-no-pb">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-9">
					<div class="jumbotron">
						<h2>마이페이지</h2>
						<p>${member_id} 님의 페이지 정보 입니다.</p>
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
								<div id="countDiv" class="col-md-5">
									<span id="info">아이디 : ${memberVo.member_id }</span><br/>
									<span id="info">닉네임 : ${memberVo.member_nickname }</span><br/>
									<div style="font-size: 20px; margin-bottom: 10px;">
										<span>회원가입 날짜 : </span>
										<span class="joinDate">${memberVo.member_regdate }</span>
										<br/>
									</div>
									<div style="float: left; margin-right: 25px;">
										<a id="showBoard" class="showTag" href="#">내가 쓴 게시글 보기</a>
										<span id="info">${boardCommentCountMap['BOARD_COUNT']} 개</span><br/>
									</div>
									<div style="float: left;">
										<a id="showComment" class="showTag" href="#">내가 쓴 댓글 보기</a>
										<span id="info">${boardCommentCountMap['COMMENT_COUNT'] } 개</span><br/>
									</div>
									<div style="float: left; margin-right: 25px;">
										<a id="memberInfoModify" class="btn btn-primary btn-lg" href="#">개인 정보 수정</a>
									</div>
									<div style="float: left;">
										<a id="memberWthdr" class="btn btn-danger btn-lg" href="/#">회원 탈퇴</a>
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