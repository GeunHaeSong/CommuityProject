<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
<script src="/resources/js/timeChange.js"></script>
<script>
$(function() {
	var boardResult = "${boardResult}";
	if(boardResult == "true") {
		alert("성공적으로 글을 작성하셨습니다.");
	}
	
	// 밀리초 단위를 초 단위로 변경
	$(".registTime").each(function() {
		var registTime = $(this).text();
		var timeSeconds = seconds(registTime);
		$(this).text(timeSeconds);
	});
	
	// 검색하기
	$("#searchBtn").click(function() {
		var choiceType = $("#choiceType option:selected").val();
		var keyword = $("#keyword").val();
		
		$("#hiddenKeywordType").val(choiceType);
		$("#hiddenKeyword").val(keyword);
		
		$("#boardSearchForm").submit();
	});
	
	// 페이징 이벤트 달아서 검색 조건도 같이 보내기
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
});
</script>
<!-- 페이징 버튼 폼 -->
<form id="pagingForm" action="/board/boardList" method="get">
	<input type="hidden" id="hiddenPage" name="page">
	<input type="hidden" name="keywordType" value="${pagingDto.keywordType}">
	<input type="hidden" name="keyword" value="${pagingDto.keyword}">
	<input type="hidden" name="clickCategory" value="${clickCategory}">
</form>
<!-- 검색할 경우 보낼 폼 -->
<form id="boardSearchForm" action="/board/boardList" method="get">
	<input type="hidden" id="hiddenKeywordType" name="keywordType">
	<input type="hidden" id="hiddenKeyword" name="keyword">
	<input type="hidden" name="clickCategory" value="${clickCategory}">
</form>

  <body>
	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		<!-- aside.jsp 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		<div id="colorlib-main">
			<section class="ftco-section">
				<c:if test="${empty boardList}">
				<div style="text-align: center; margin-bottom: 10px;">
					<strong style="font-size: 60px;">게시글이 존재하지 않습니다.</strong>
				</div>
				</c:if>
				<div class="container">
					<div class="row px-md-4">
					<!-- 여기서 부터 게시물 한개 -->
					<c:forEach items="${boardList}" var="BoardVo">
						<div class="col-md-12">
							<div class="blog-entry ftco-animate d-md-flex">
								<!-- 이미지가 없으면 noImage.jpg를 출력 -->
								<c:choose>
								<c:when test="${not empty BoardVo.board_main_image}">
								<a href="/board/boardInfo?board_num=${BoardVo.board_num}" class="img img-2" style="background-image: url(/board/displayImage?fileName=${BoardVo.board_main_image});"></a>
								</c:when>
								<c:otherwise>
								<a href="/board/boardInfo?board_num=${BoardVo.board_num}" class="img img-2" style="background-image: url(/resources/images/noImage.jpg);"></a>
								</c:otherwise>
								</c:choose>
								<div class="text text-2 pl-md-4">
									<h3 class="mb-2">
										<a href="/board/boardInfo?board_num=${BoardVo.board_num}" class="btn-custom">${BoardVo.board_title}</a>
									</h3>
									<div class="meta-wrap">
										<p class="meta">
											<i class="icon-calendar mr-2"></i>
											<c:choose>
												<c:when test="${not empty BoardVo.board_modi_t}">
													<span class="registTime">${BoardVo.board_modi_t}</span>
													<span>(수정)</span>
												</c:when>
												<c:otherwise>
													<span class="registTime">${BoardVo.board_reg_t}</span>
												</c:otherwise>
											</c:choose>
											<span><a href="single.html"><i class="icon-folder-o mr-2"></i>${BoardVo.category_name}</a></span>
											<span><i class="icon-comment2 mr-2"></i>${BoardVo.comment_count} 댓글</span>
											<span>${BoardVo.board_view} 조회수</span>
											<span>${BoardVo.board_up} 좋아요</span>
										</p>
									</div>
									<p class="mb-4">${BoardVo.board_content}</p>
								</div>
							</div>
						</div>
					</c:forEach>
					</div>
					<!-- 검색 기능 -->
			        <div id="selectDiv" style="text-align: center; margin-bottom: 5px;">
			        	<select id="choiceType">
			        		<option value="">전체</option>
			        		<option value="typeTitle"
			        		<c:if test="${pagingDto.keywordType eq 'typeTitle'}">
			        		selected
			        		</c:if>
			        		>제목</option>
			        		<option value="typeId"
			        		<c:if test="${pagingDto.keywordType eq 'typeId'}">
			        		selected
			        		</c:if>
			        		>아이디</option>
			        	</select>
			        	<input type="text" id="keyword" value="${pagingDto.keyword}" placeholder="검색어를 입력해주세요.">
			        	<button id="searchBtn" type="button" class="btn btn-sm btn-success">검색</button>
			        </div>
					<!-- 페이징 작업 하기 -->
					<div class="row">
			          <div class="col text-center text-md-left">
			            <div class="block-27">
			              <ul style="text-align: center;" id="pagination">
			              	<!-- 페이징 화살표 처리 확인 필요 -->
			              	<!-- 왼쪽 화살표 -->
			              	<c:if test="${pagingDto.startPage != 1 }">
			                <li><a href="#" class="pageStart">&lt;</a></li>
			              	</c:if>
			                <!-- 페이징 넘버링 -->
			                <c:forEach var="paging" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
			                <li
			                <c:if test="${pagingDto.page == paging}">
			                class="active"
			                </c:if>
			                ><a href="#" class="pagingBtn">${paging}</a></li>
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
			</section>
		</div><!-- END COLORLIB-MAIN -->
	</div><!-- END COLORLIB-PAGE -->
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
<!-- footer.jsp 인크루드 -->
<%@ include file="../include/footer.jsp" %>
  </body>
</html>