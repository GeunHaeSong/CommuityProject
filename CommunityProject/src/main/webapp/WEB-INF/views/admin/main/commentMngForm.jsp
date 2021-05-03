<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header 스크립트 설정 부분 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>

<script src="/resources/js/timeChange.js"></script>
<script>
$(function() {
	
	// 삭제 성공 실패 결과
	var commentDeleteResult = "${commentDeleteResult}";
	if(commentDeleteResult == "success") {
		alert("삭제에 성공하셨습니다.");
	} else if(commentDeleteResult == "fail") {
		alert("이미 삭제된 게시글 입니다.");
	}
	// 복구 성공 실패 결과
	var commentRestoreResult = "${commentRestoreResult}";
	if(commentRestoreResult == "success") {
		alert("복구에 성공하셨습니다.");
	} else if(commentRestoreResult == "fail") {
		alert("이미 복구된 게시글 입니다.");
	}
	// 게시글 제목 7글자 넘어가면 ... 붙이기
	var commentContents = $(".commentContent");
	$.each(commentContents, function() {
		var contentText = $(this).text();
		if(contentText.length > 8) {
			var changeText = contentText.substring("0", "7");
			changeText = changeText + "...";
			$(this).text(changeText);
		}
	});
	// 시간 형식 2021-01-01 10:00:00로 변환
	var commentTime = $(".commentTime");
	$.each(commentTime, function() {
		var timeText = $(this).text();
		if(timeText.length != 0) {
			var changeText = seconds(timeText);
			$(this).text(changeText);
		}
	});
	
	// 검색 이벤트
	$("#searchBtn").click(function() {
		var choiceCategory = $("#choiceCategory option:selected").val();
		var categoryType = $("#choiceCategory option:selected").attr("data-type");
		var chocieState = $("#chocieState option:selected").val();
		var choiceKeyaordType = $("#choiceKeyaordType option:selected").val();
		var keyword = $("#keyword").val();
		
		$("#hiddenCategoryType").val(categoryType);
		$("#hiddenSelectCategory").val(choiceCategory);
		$("#hiddenStateTpye").val(chocieState);
		$("#hiddenKeywordType").val(choiceKeyaordType);
		$("#hiddenKeyword").val(keyword);
		
		$("#commentSearchForm").submit();
	});
	
	// 페이징 버튼
	$("#pagination").on("click", ".pagingBtn", function(e) {
		e.preventDefault();
		var page = $(this).text();
		$("#hiddenPage").val(page);
		$("#pagingForm").submit();
	});
	
	// 이전 버튼
	$("#pagination").on("click", ".pageStart", function(e) {
		e.preventDefault();
		var page = "${pagingDto.startPage - 1}";
		$("#hiddenPage").val(page);
		$("#pagingForm").submit();
	});
	
	// 다음 버튼
	$("#pagination").on("click", ".pageEnd", function(e) {
		e.preventDefault();
		var page = "${pagingDto.endPage + 1}";
		$("#hiddenPage").val(page);
		$("#pagingForm").submit();
	});
	
	// 댓글 복구
	$("#commentBody").on("click", ".commentRestoreBtn", function(e) {
		e.preventDefault();
		var comment_num = $(this).attr("data-num");
		$("#restoreForm").find("#comment_num").val(comment_num);
		$("#restoreForm").submit();
	});
	// 댓글 삭제
	$("#commentBody").on("click", ".commentDeleteBtn", function(e) {
		e.preventDefault();
		var comment_num = $(this).attr("data-num");
		$("#deleteForm").find("#comment_num").val(comment_num);
		$("#deleteForm").submit();
	});
}); 
</script>

<!-- 삭제 버튼 폼 -->
<form id="deleteForm" action="/admin/adminCommentDelete" method="post">
	<input type="hidden" id="comment_num" name="comment_num">
	<input type="hidden" name="page" value="${pagingDto.page}">
	<input type="hidden" name="categoryType" value="${pagingDto.categoryType}">
	<input type="hidden" name="selectCategory" value="${pagingDto.selectCategory}">
	<input type="hidden" name="stateType" value="${pagingDto.stateType}">
	<input type="hidden" name="keywordType" value="${pagingDto.keywordType}">
	<input type="hidden" name="keyword" value="${pagingDto.keyword}">
</form>
<!-- 복구 버튼 폼 -->
<form id="restoreForm" action="/admin/adminCommentRestore" method="post">
	<input type="hidden" id="comment_num" name="comment_num">
	<input type="hidden" name="page" value="${pagingDto.page}">
	<input type="hidden" name="categoryType" value="${pagingDto.categoryType}">
	<input type="hidden" name="selectCategory" value="${pagingDto.selectCategory}">
	<input type="hidden" name="stateType" value="${pagingDto.stateType}">
	<input type="hidden" name="keywordType" value="${pagingDto.keywordType}">
	<input type="hidden" name="keyword" value="${pagingDto.keyword}">
</form>
<!-- 페이징 버튼 폼 -->
<form id="pagingForm" action="/admin/commentMngForm" method="get">
	<input type="hidden" id="hiddenPage" name="page">
	<input type="hidden" name="categoryType" value="${pagingDto.categoryType}">
	<input type="hidden" name="selectCategory" value="${pagingDto.selectCategory}">
	<input type="hidden" name="stateType" value="${pagingDto.stateType}">
	<input type="hidden" name="keywordType" value="${pagingDto.keywordType}">
	<input type="hidden" name="keyword" value="${pagingDto.keyword}">
</form>
<!-- 검색할 경우 보낼 폼 -->
<form id="commentSearchForm" action="/admin/commentMngForm" method="get">
	<input type="hidden" id="hiddenCategoryType" name="categoryType">
	<input type="hidden" id="hiddenSelectCategory" name="selectCategory">
	<input type="hidden" id="hiddenStateTpye" name="stateType">
	<input type="hidden" id="hiddenKeywordType" name="keywordType">
	<input type="hidden" id="hiddenKeyword" name="keyword">
</form>
<!-- 화면 왼쪽에 aside.jsp 추가 -->
<%@ include file="/WEB-INF/views/include/aside.jsp"%>
<!-- 어드민 페이지 상단 메뉴 -->
<%@ include file="../adminInclude/adminMenuHeader.jsp" %>
<!-- 검색 기능 -->
<div id="selectDiv" style="text-align: right;" class="col-md-10">
	<select id="choiceCategory">
		<option value="" data-type="">전체</option>
		<!-- forEach 돌리기 -->
		<!-- 이전에 선택한 검색 설정으로 selected -->
		<c:forEach items="${categoryList }" var="CategoryVo">
		<option value="${CategoryVo.category_code}" data-type="catrgoryType"
		<c:if test="${pagingDto.selectCategory eq CategoryVo.category_code}">
		selected
		</c:if>
		>${CategoryVo.category_name }</option>
		</c:forEach>
	</select>
	<select id="chocieState">
		<option value="">전체</option>
		<option value="N"
		<c:if test="${pagingDto.stateType eq 'N'}">
		selected
		</c:if>
		>삭제된것</option>
		<option value="Y"
		<c:if test="${pagingDto.stateType eq 'Y'}">
		selected
		</c:if>
		>삭제되지않은것</option>
	</select>
	<select id="choiceKeyaordType">
		<option value="typeTitle"
		<c:if test="${pagingDto.keywordType eq 'typeTitle'}">
		selected
		</c:if>
		>내용</option>
		<option value="typeId"
		<c:if test="${pagingDto.keywordType eq 'typeId'}">
		selected
		</c:if>
		>아이디</option>
		<option value="typeIdTitle"
		<c:if test="${pagingDto.keywordType eq 'typeIdTitle'}">
		selected
		</c:if>
		>아이디+내용</option>
	</select>
	<span>
		<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요." value="${pagingDto.keyword }">
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
					<th>내용</th>
					<th>작성자</th>
					<th>게시판</th>
					<th>작성일</th>
					<th>삭제일</th>
					<th>상태</th>
					<th></th>
				</tr>
			</thead>
			<tbody id="commentBody">
				<c:forEach items="${commentList}" var="CommentVo">
				<tr style="text-align: center;">
					<td>
					<a href="/board/boardInfo?board_num=${CommentVo.board_num }" class="commentContent">${CommentVo.comment_content }</a>
					</td>
					<td>${CommentVo.member_id }</td>
					<td>${CommentVo.category_name }</td>
					<td class="commentTime">${CommentVo.comment_reg_t }</td>
					<td class="commentTime">${CommentVo.comment_delete_t }</td>
					<td>
						<c:if test="${CommentVo.comment_state == 'N' }">
						<span style="color:red;">삭제</span>
						</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${CommentVo.comment_state == 'N' }">
							<a href="/#" class="btn btn-sm btn-primary commentRestoreBtn" data-num="${CommentVo.comment_num }">복구</a>
							</c:when>
							<c:otherwise>
							<a href="/#" class="btn btn-sm btn-danger commentDeleteBtn" data-num="${CommentVo.comment_num }">삭제</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 페이징 작업 하기 -->
		<div class="row">
          <div class="col text-center text-md-left">
            <div class="block-27">
              <ul id="pagination" style="text-align: center;">
              	<!-- 페이징 화살표 처리 확인 필요 -->
              	<!-- 왼쪽 화살표 -->
              	<c:if test="${pagingDto.startPage > 1 }">
                <li><a href="#" class="pageStart">&lt;</a></li>
              	</c:if>
                <!-- 페이징 넘버링 -->
                <c:forEach var="paging" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
                <li
                <c:if test="${pagingDto.page == paging}">
                class="active"
                </c:if>
                ><a class="pagingBtn" href="#">${paging}</a></li>
                </c:forEach>
                <!-- 오른쪽 화살표 -->
                <c:if test="${pagingDto.endPage < pagingDto.totalPage}">
                <li><a href="#" class="pageEnd">&gt;</a></li>
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
