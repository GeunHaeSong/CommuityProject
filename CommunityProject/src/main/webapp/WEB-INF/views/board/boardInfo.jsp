<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<style>
	.content {
		font-size: 25px;
	}
	.subSpan {
		font-size: 15px;
	}
	.up {
		color: red;
		font-size: 25px;
	}
	.imageFile {
		width: 100%;
		height: auto;
	}
</style>
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
<script src="/resources/js/timeChange.js"></script>
<script>
$(function() {
	
	// 밀리초 단위를 초단위로 바꾸기
	var registTime = $("#registTime").text();
	var timeSeconds = seconds(registTime);
	$("#registTime").text(timeSeconds);
	
	// 첨부파일 앞에 붙는 uuid 부분 지우고 원래의 이름으로 만들기
	$(".appendingFile").each(function() {
		var fileName = $(this).text();
		var doubleUnderbarIndex = fileName.lastIndexOf("__") + 2;
		var originalFileName = fileName.substring(doubleUnderbarIndex);
		$(this).text(originalFileName);
	});
	
	// 게시글의 댓글 수 가져오기
	$("#btnTotalComment").click(function() {
		var url = "/comment/totalComment";
		var sendData = {
			"board_num" : "${BoardVo.board_num}"
		};
		
		$.get(url, sendData, function(rData) {
			$("#totalComment").text(rData + " 댓글");
		});
	});
	
	// 게시글 삭제
	$("#spanDeleteBoard").click(function(e) {
		e.preventDefault();
		$("#deleteBoardForm").submit();
	});
	
	// 댓글 목록 가져오기
	$("#showComments").click(function() {
		var url = "/comment/commentList";
		var sendData = {
			"board_num" : "${BoardVo.board_num}"
		};
		
		$.get(url, sendData, function(rData) {
			$(".comment-list").remove();
			$.each(rData, function() {
				var comment_num = (this).comment_num;
				var member_id = (this).member_id;
				var comment_content = (this).comment_content;
				var comment_reg_t = (this).comment_reg_t;
				var comment_modi_t = (this).comment_modi_t;
				
				var commentForm = $("#commentForm").clone();
				commentForm.css("display", "block");
				commentForm.addClass("comment-list");
				commentForm.find("#cl_id").text(member_id);
				commentForm.find("#cl_content").parent().addClass("cl_content" + comment_num);
				commentForm.find("#cl_content").text(comment_content);
				// 댓글이 수정 됐으면 수정된 시간으로, 아니면 원래 작성 시간으로
				if(comment_modi_t == null) {
					commentForm.find("#cl_date").text(seconds(comment_reg_t));
				} else {
					commentForm.find("#cl_date").text(seconds(comment_reg_t) + "(수정)");
				}
				commentForm.find("#comment_modify").parent().attr("data-commentNum", comment_num);
				
				$("#showCommentList").append(commentForm);
			});
		});
	});
	
	// 댓글 작성
	$("#writeComment").click(function() { 
		var comment_content = $("#comment_content").val();
		var board_num = "${BoardVo.board_num}";
		
		var url = "/comment/writeComment";
		var sendData = {
			"comment_content" : comment_content,
			"board_num" : board_num
		};
		
		$.ajax({
			"type" : "post",
			"url" : url,
			"dataType" : "text",
			"data" : JSON.stringify(sendData),
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "post"
			},
			"success" : function(rData) {
				$("#showComments").trigger("click");
				$("#btnTotalComment").trigger("click");
			}
		});
	});
	
	// 댓글 수정을 누르고 다른 댓글에 수정을 눌렀을때 기존의 댓글 내용 복원 시키기 위한 변수
	var originalComment;
	var previousCommentClass;
	// 댓글 수정
	$("#showCommentList").on("click", "#comment_modify", function(e) {
		e.preventDefault();
		// 아이디 확인
		var commentId = $(this).parent().parent().find("#cl_id").text();
		var loginId = "${sessionScope.member_id}";
		if(commentId != loginId) {
			alert("로그인 정보와 댓글 작성자가 일치하지 않습니다. 다시 확인해주세요.");
			return "false";
		}

		// 기존의 폼 다시 붙이기
		$("." + previousCommentClass).append(originalComment);
		// 댓글 수정 폼 만들기(중복 방지)
		$(".modifyContent").remove();
		var input = "<div class='modifyForm'><input type='text' id='modifyContent' class='modifyContent' placeholder='댓글을 입력해주세요.'>";
		input += "<button type='button' id='btnModifyOk' class='modifyContent'>수정</button>";
		input += "<button type='button' id='btnModifyCancle' class='modifyContent'>취소</button></div>";
		var cl_content = $(this).parent().parent();
		
		// 기존의 폼 저장해두기
		originalComment = cl_content.find("#cl_content").clone();
		previousCommentClass = cl_content.find("#cl_content").parent().attr("class");
		
		// 댓글 수정 폼 붙이기
		cl_content.find("#cl_content").remove();
		cl_content.find("#divContent").append(input);
	});
	
	// 댓글 수정 완료
	$("#showCommentList").on("click", "#btnModifyOk", function() {
		// 내용 빈칸 확인
		var modifyContent = $("#modifyContent").val();
		var modifyContentLength = modifyContent.length;
		if(modifyContent == 0) {
			alert("내용을 입력해주세요.");
			return;
		}
		
		// btn 만든 곳에 댓글 번호 저장해둔거 찾음
		var comment_num = $(this).parent().parent().parent().find("#divBtnComment").attr("data-commentNum");
		var url = "/comment/modifyComment";
		var sendData = {
				"comment_content" : modifyContent,
				"comment_num" : comment_num
		};
		$.ajax({
			"type" : "put",
			"url" : url,
			"dataType" : "text",
			"data" : JSON.stringify(sendData),
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "put"
			},
			"success" : function(rData) {
				if(rData == "success") {
					$("#showComments").trigger("click");
				} else {
					alert("로그인 정보와 댓글 작성자가 일치하지 않습니다.");
				}
			}
		});
	});
	
	// 댓글 수정 취소, 원 상태로 복원
	$("#showCommentList").on("click", "#btnModifyCancle", function() {
		$(".modifyForm").remove();
		$("." + previousCommentClass).append(originalComment);
	});
	
	// 댓글 삭제
	$("#showCommentList").on("click", "#comment_delete", function(e) {
		e.preventDefault();
		// 아이디 확인
		var commentId = $(this).parent().parent().find("#cl_id").text();
		var loginId = "${sessionScope.member_id}";
		if(commentId != loginId) {
			alert("로그인 정보와 댓글 작성자가 일치하지 않습니다. 다시 확인해주세요.");
			return "false";
		}
		
		// 에이잭스에 사용할 데이터
		var commentNum = $(this).parent().attr("data-commentNum");
		var board_num = "${BoardVo.board_num}";
		var url = "/comment/deleteComment";
		var sendData = {
				"comment_num" : commentNum,
				"board_num" : board_num
		};
		
		// 삭제 확인 창
		if(confirm("정말로 해당 댓글을 삭제하시겠습니까?") == true) {
			$.get(url, sendData, function(rData) {
				if(rData == "success")  {
					$("#showComments").trigger("click");
					$("#btnTotalComment").trigger("click");
				} else {
					alert("현재 로그인 정보와 댓글 작성자가 일치하지 않습니다.");
				}
			});
		}
	});
	
	// 게시글 좋아요 이미지 변경
	$("#btnUpCheck").click(function() {
		var url = "/freeBoard/boardUpCheck";
		var sendData = {
				"board_num" : "${BoardVo.board_num}"
		};
		
		$.get(url, sendData, function(rData) {
			if(rData ==  0) {
				$("#UpImg").attr("src", "/resources/images/up_original.png");
			} else if(rData = 1) {
				$("#UpImg").attr("src", "/resources/images/up_check.png");
			}
		});
	});
	
	// 게시글 좋아요
	$("#boardUp").click(function(e) {
		e.preventDefault();
		var url = "/freeBoard/boardUp";
		var sendData = {
			"board_num" : "${BoardVo.board_num}"
		};
		$.get(url, sendData, function(rData) {
			$("#boardUpCount").text(rData);
			$("#btnUpCheck").trigger("click");
		});
	});
	
	// 적힌 이벤트를 읽고 페이지 로드 될 때 시작
	$("#showComments").trigger("click");
	
	// 로그인이 되어 있으면 trigger 사용
	var login_check = "${not empty sessionScope.member_id}";
	if(login_check == "true") {
		$("#btnUpCheck").trigger("click");
	}
});
</script>
<body>
	<!-- 사용자에게 보여주지 않을 것 -->
	<div>
		<button type="button" id="btnTotalComment" style="display: none;">댓글 수</button>
		<button type="button" id="btnUpCheck" style="display: none;">좋아요 이미지 변경</button>
		<div id="commentForm" style="display: none;">
			<div style="float: left; width: 15%">
				<span id="cl_id"></span>
			</div>
			<div style="float: left; width: 45%" id="divContent">
				<span id="cl_content"></span>
			</div>
			<div style="float: left; width: 30%">
				<span id="cl_date"></span>
			</div>
			<div id="divBtnComment">
				<a href="/#" id="comment_modify"><span style="color: green;">수정</span></a>
				<a href="/#" id="comment_delete"><span style="color: red;">삭제</span></a>
			</div>
			<hr>
		</div>
	</div>
	<!-- 삭제 처리 -->
	<form id="deleteBoardForm" action="/freeBoard/deleteBoardRun" method="get">
		<input type="hidden" name="category_code" value="${BoardVo.category_code}">
		<input type="hidden" name="board_num" value="${BoardVo.board_num}">
	</form> 
	
	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		
		<!-- aside.jsp 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		
		<div id="colorlib-main">
			<section class="ftco-section ftco-no-pt ftco-no-pb">
	    	<div class="container">
	    		<div class="row d-flex">
	    			<div class="col-lg-14 px-md-5 py-5">
	    				<div class="pt-md-4">
    						<a href="/freeBoard/boardList?category_code=${BoardVo.category_code}">${BoardVo.category_name}</a>
	    					<!-- 게시글 제목 부분 -->
	    					<h1><span>${BoardVo.board_title}</span></h1>
	    					<span class="subSpan">${BoardVo.member_id} |</span>
	    					<!-- 게시글 수정 이력이 없다면 등록 시간으로, 수정 이력이 있으면 수정 시간으로 -->
	    					<c:choose>
		    					<c:when test="${empty BoardVo.board_modi_t}">
		    						<span class="subSpan" id="registTime">${BoardVo.board_reg_t}</span>
		    					</c:when>
		    					<c:otherwise>
		    						<span class="subSpan" id="registTime">${BoardVo.board_modi_t}</span>
		    						<span>(수정)</span>
		    					</c:otherwise>
	    					</c:choose>
	    					<!-- 조회 세션 걸어서 조회수 올려야함 -->
	    					<span class="subSpan"> | 조회 : ${BoardVo.board_view}</span>
		            		<hr>
		            		<!-- 게시글 이미지 부분 -->
		            		<c:if test="${!empty BoardFileList}">
            					<c:forEach items="${BoardFileList}" var="BoardFileVo">
		            				<c:choose>
			            				<c:when test="${BoardFileVo.file_extension == 'jpg' || BoardFileVo.file_extension == 'png' || BoardFileVo.file_extension == 'gif'}">
			            					<p><img src="/freeBoard/displayImage?fileName=${BoardFileVo.file_name}" alt="${BoardFileVo.file_name}" class="imageFile"/></p>
			            				</c:when>
		            				</c:choose>
	            				</c:forEach>
		            		</c:if>
		            		<!-- 게시글 내용 부분 -->
	    					<div class="pt-3 mt-3">
		            			<p class="content">${BoardVo.board_content}</p>
		            		</div>
		            		
		            		<!-- 수정/삭제 -->
		            		<c:if test="${BoardVo.member_id == sessionScope.member_id }">
			            		<div style="text-align: right;">
			            			<a href="/freeBoard/updateBoard?board_num=${BoardVo.board_num}"><span style="color: green;">수정</span></a>
			            			<a href="/freeBoard/deleteBoardRun?category_code='${BoardVo.category_code}'" id="spanDeleteBoard"><span style="color: red;">삭제</span></a>
			            		</div>
		            		</c:if>
		            		
		            		<!-- 좋아요 싫어요 구현하기 / 로그인 해야 좋아요 이미지 보임 -->
		            		<div class="pt-3 mt-3" style="text-align: center;">
		            			<c:if test="${not empty sessionScope.member_id }">
		            				<a href="/#" id="boardUp"><img id="UpImg" alt="up" width="35px;" height="35px;"></a>
		            			</c:if>
		            			<span><strong>좋아요</strong></span>
		            			<span class="up" id="boardUpCount">${BoardVo.board_up}</span>
		            		</div>
		            		
		            		<!-- 첨부파일 -->
	    					<div class="mt-5" style="border: 1px solid; border-color: gray;">
	    						<strong>첨부파일</strong>
	    						<ul>
	    						<c:forEach items="${BoardFileList}" var="BoardFileVo">
		            				<li><a href="/freeBoard/fileDown?file_code=${BoardFileVo.file_code}" class="appendingFile">${BoardFileVo.file_name}</a></li>
	    						</c:forEach>
	    						</ul>
		            		</div>
		            		<hr>
<!-- 	            			네모난 박스 뜨는데 난중에 보고 활용할거 있으면 활용하기 -->
<!-- 				            <div class="tag-widget post-tag-container mb-5 mt-5"> -->
<!-- 				              <div class="tagcloud"> -->
<!-- 				                <a href="#" class="tag-cloud-link">Life</a> -->
<!-- 				                <a href="#" class="tag-cloud-link">Sport</a> -->
<!-- 				                <a href="#" class="tag-cloud-link">Tech</a> -->
<!-- 				                <a href="#" class="tag-cloud-link">Travel</a> -->
<!-- 				              </div> -->
<!-- 				            </div> -->

					<!-- 댓글 부분 -->
		            <div>
		              <span><strong class="mb-5 font-weight-bold" id="totalComment" style="font-size: 25px;">${BoardVo.comment_count} 댓글</strong></span>
		              <span><button type="button" id="showComments" class="btn py-2 px-3 btn-primary">댓글 목록</button></span>
		              <hr>
		              <div id="showCommentList"></div>
		              
		              <!-- 댓글다는 부분 / 로그인 해야 사용 가능 -->
		              <c:if test="${not empty sessionScope.member_id }">
			              <div class="comment-form-wrap pt-5">
			                <form action="#" class="p-3 p-md-5 bg-light">
			                  <div class="form-group">
			                    <label for="message">댓글 내용</label>
			                    <textarea id="comment_content" maxlength="200" class="form-control"></textarea>
			                  </div>
			                  <div class="form-group">
			                    <button type="button" id="writeComment" class="btn py-3 px-4 btn-primary">댓글 작성</button>
			                  </div>
			                </form>
			              </div>
		              </c:if>
		            </div>
			    		</div><!-- END-->
			    	</div>
		    	<!-- 오른쪽 사이드 부분, 검색 부분 나중에 재활용 -->
<!--     			<div class="col-lg-4 sidebar ftco-animate bg-light pt-5"> -->
<!-- 	            <div class="sidebar-box pt-md-4"> -->
<!-- 	              <form action="#" class="search-form"> -->
<!-- 	                <div class="form-group"> -->
<!-- 	                  <span class="icon icon-search"></span> -->
<!-- 	                  <input type="text" class="form-control" placeholder="검색어를 입력해주세요."> -->
<!-- 	                </div> -->
<!-- 	              </form> -->
<!-- 	            </div> -->
	    		</div>
	    	</div>
	    </section>
		</div><!-- END COLORLIB-MAIN -->
	</div><!-- END COLORLIB-PAGE -->

<!-- footer.jsp 인크루드 -->
<%@ include file="../include/footer.jsp" %>
    
  </body>
</html>