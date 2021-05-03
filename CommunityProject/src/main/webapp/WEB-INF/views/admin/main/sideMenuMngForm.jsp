<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header 스크립트 설정 부분 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>

<script src="/resources/js/timeChange.js"></script>
<script>
$(function() {
	
	// 권한 변경 메세지
	var accessResult = "${accessResult}";
	if(accessResult == "success") {
		alert("성공적으로 변경하였습니다.");
	} else if(accessResult == "fail") {
		alert("변경에 실패하였습니다.");
	}
	
	// 실패 메시지
	var deleteResult = "${deleteResult}";
	if(deleteResult == "success") {
		alert("성공적으로 삭제하였습니다.");
	} else if(deleteResult == "fail") {
		alert("삭제에 실패하였습니다.");
	}
	
	// 복구 메세지
	var restoreResult = "${restoreResult}";
	if(restoreResult == "success") {
		alert("성공적으로 복구하였습니다.");
	} else if(restoreResult == "fail") {
		alert("복구에 실패하였습니다.");
	}
	
	// 시간 초단위까지 변경
	var categoryTime = $(".categoryTime");
	$.each(categoryTime, function() {
		var text = $(this).text();
		if(text.length == 0) {
			return;
		}
		var changeTime = seconds(text);
		$(this).text(changeTime);
	});
	
	// 접근권한 클릭시 모발 이벤트 발생
	$("#categoryTable").on("click", ".setAccess", function(e) {
		e.preventDefault();
		var access = $(this).attr("data-access");
		var category_code = $(this).attr("data-code");

		$("#accessSelectBox > option[value=" + access +"]").attr("selected", true);
		$("#accessChangeBtn").attr("data-code", category_code);
		$("#startModal").trigger("click");
		
	});
	
	// 권한 변경 모달 저장 버튼
	$("#accessChangeBtn").click(function() {
		var category_code = $(this).attr("data-code");
		var selectAccessVal = $("#accessSelectBox option:selected").val();
		$("#category_code").val(category_code);
		$("#category_access").val(selectAccessVal);
		// 페이징 유지 input 클론 만들어서 붙이기
		var hiddenClone = $("#hiddenDiv").clone();
		$("#accessChange").append(hiddenClone);
		$("#accessChange").submit();
	});
	
	
	// 카테고리 삭제
	$("#categoryTable").on("click", ".deleteCategory", function() {
		// 페이징 유지 input 클론 만들어서 붙이기
		var hiddenClone = $("#hiddenDiv").clone();
		var category_code = $(this).attr("data-code");
		$("#deleteCategoryCode").val(category_code);
		$("#deleteCategory").append(hiddenClone);
		$("#deleteCategory").submit();
	});
	
	// 카테고리 복구(최대 9개까지 카테고리 존재할 수 있게 하기)
	$("#categoryTable").on("click", ".restoreCategory", function() {
		var url = "/admin/liveCategoryCount";
		var liveCount = "${liveCount}";
		if(liveCount >= 9) {
			alert("카테고리는 최대 9개까지 존재할 수 있습니다.");
			return;
		}
		var category_code = $(this).attr("data-code");
		$("#restoreCategoryCode").val(category_code);
		// 페이징 유지 input 클론 만들어서 붙이기
		var hiddenClone = $("#hiddenDiv").clone();
		$("#restoreCategory").append(hiddenClone);
		$("#restoreCategory").submit();
	});
	
	// 검색 이벤트
	$("#searchBtn").click(function() {
		var chocieState = $("#chocieState option:selected").val();
		var choiceAccess = $("#choiceAccess option:selected").val();
		var keyword = $("#keyword").val();
		
		// 페이징 유지 클론 붙이기
		var hiddenClone = $("#hiddenDiv").clone();
		hiddenClone.find("#hiddenPage").remove();
		hiddenClone.find("#hiddenStateType").val(chocieState);
		hiddenClone.find("#hiddenKeywordType").val(choiceAccess);
		hiddenClone.find("#hiddenKeyword").val(keyword);
		
		$("#categorySearchForm").append(hiddenClone);
		$("#categorySearchForm").submit();
	});
	
	// 페이징 번호 버튼 이벤트 달아서 검색 조건도 같이 보내기
	$("#pagination").on("click", ".pagingBtn", function(e) {
		e.preventDefault();
		var page = $(this).text();
		var hiddenClone = $("#hiddenDiv").clone();
		hiddenClone.find("#hiddenPage").val(page);
		$("#pagingForm").append(hiddenClone);
		$("#pagingForm").submit();
	});
	
	// 이전 버튼
	$("#pagination").on("click", ".pageStart", function(e) {
		e.preventDefault();
		var page = "${pagingDto.startPage - 1}";
		var hiddenClone = $("#hiddenDiv").clone();
		hiddenClone.find("#hiddenPage").val(page);
		$("#pagingForm").append(hiddenClone);
		$("#pagingForm").submit();
	});
	
	// 다음 버튼
	$("#pagination").on("click", ".pageEnd", function(e) {
		e.preventDefault();
		var page = "${pagingDto.endPage + 1}";
		var hiddenClone = $("#hiddenDiv").clone();
		hiddenClone.find("#hiddenPage").val(page);
		$("#pagingForm").append(hiddenClone);
		$("#pagingForm").submit();
	});
}); 
</script>
<!-- 기본이 되는 페이징 유지 input으로 안의 내용을 클론을 만들어서 재사용 -->
<div id="hiddenDiv" style="display: none;">
	<input type="hidden" id="hiddenPage" name="page" value="${pagingDto.page }">
	<input type="hidden" id="hiddenStateType" name="stateType" value="${pagingDto.stateType}">
	<input type="hidden" id="hiddenKeywordType" name="keywordType" value="${pagingDto.keywordType}">
	<input type="hidden" id="hiddenKeyword" name="keyword" value="${pagingDto.keyword}">
</div>
<!-- 권한 변경 전송 폼 -->
<form id="accessChange" action="/admin/accessChangeRun" method="post">
	<input type="hidden" id="category_code" name="category_code">
	<input type="hidden" id="category_access" name="category_access">
	<!-- hiddenDiv 클론 사용 -->
</form>
<!-- 카테고리 삭제 -->
<form id="deleteCategory" action="/admin/deleteCategory" method="post">
	<input type="hidden" id="deleteCategoryCode" name="category_code">
	<!-- hiddenDiv 클론 사용 -->
</form>
<!-- 카테고리 복구 -->
<form id="restoreCategory" action="/admin/restoreCategory" method="post">
	<input type="hidden" id="restoreCategoryCode" name="category_code">
	<!-- hiddenDiv 클론 사용 -->
</form>
<!-- 페이징 버튼 폼 -->
<form id="pagingForm" action="/admin/sideMenuMngForm" method="get">
	<!-- hiddenDiv 클론 사용 -->
</form>
<!-- 검색할 경우 보낼 폼 -->
<form id="categorySearchForm" action="/admin/sideMenuMngForm" method="get">
	<!-- hiddenDiv 클론 사용 -->
</form>
<!-- 모달 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			 <a id="startModal" href="#modal-container-997619" style="display: none;" role="button" class="btn" data-toggle="modal">모달 버튼</a>
			<div class="modal fade" id="modal-container-997619" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">
								접근 권한 설정
							</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<strong>권한</strong><span> : </span>
							<select id="accessSelectBox">
								<option value="A">관리자</option>
								<option value="Y">일반 유저</option>
							</select>
						</div>
						<div class="modal-footer">
							<button id="accessChangeBtn" type="button" class="btn btn-primary">
								저장
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
		<option value="Y"
			<c:if test="${pagingDto.stateType eq 'Y'}">
			selected
			</c:if>
		>등록됌</option>
		<option value="Z"
			<c:if test="${pagingDto.stateType eq 'Z'}">
			selected
			</c:if>
		>등록되지않음</option>
		<option value="N"
			<c:if test="${pagingDto.stateType eq 'N'}">
			selected
			</c:if>
		>삭제</option>
	</select>
	<select id="choiceAccess">
		<option value="">전체</option>
		<option value="admin"
			<c:if test="${pagingDto.keywordType eq 'admin'}">
			selected
			</c:if>
		>관리자</option>
		<option value="user"
			<c:if test="${pagingDto.keywordType eq 'user'}">
			selected
			</c:if>
		>유저</option>
	</select>
	<span>
		<input type="text" id="keyword" name="keyword" placeholder="카테고리를 입력해주세요." value="${pagingDto.keyword }">
	</span>
	<button id="searchBtn" type="button" class="btn btn-sm btn-success">검색</button>
</div>
<!-- 본문 -->
<div class="container-fluid" style="margin-top: 5px;">
	<div class="row">
		<div class="col-md-2">
			<!-- 패널 타이틀 -->
			<div class="panel panel-default" style="text-align: center;">
				<div class="panel-heading">
					<h3 class="panel-title">등록된 메뉴</h3>
				</div>
				<!-- 사이드바 메뉴목록 -->
				<ul class="list-group">
					<c:forEach items="${noamlCategoryList}" var="CategoryVo">
					<c:if test="${CategoryVo.category_state == 'Y' && not empty CategoryVo.category_order}">
						<li class="list-group-item">
							<strong>${CategoryVo.category_name}</strong>
						</li>
					</c:if>
					</c:forEach>
				</ul>
				<div>
					<a href="/admin/sideMenuSetForm?clickCategory=admin" style="margin-top: 5px;" class="btn btn-lg btn-primary">등록 및 순서 변경</a>
				</div>
			</div>
		</div>
		<div class="col-md-9" id="categoryOrderDiv">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
						<table id="categoryTable" class="table" style="text-align: center;">
							<thead>
								<tr>
									<th>이름</th>
									<th>생성일</th>
									<th>삭제일</th>
									<th>접근권한</th>
									<th>게시글 수</th>
									<th>댓글 수</th>
									<th>상태</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${adminCategoryList}" var="CategoryVo">
								<tr>
									<td>${CategoryVo.category_name }</td>
									<td class="categoryTime">${CategoryVo.category_reg_t }</td>
									<td class="categoryTime">${CategoryVo.category_delete_t }</td>
									<td>
										<c:choose>
											<c:when test="${CategoryVo.category_access == 'A'}">
											<a href="/#" class="setAccess" data-access="${CategoryVo.category_access }"
											   data-code="${CategoryVo.category_code }">
												관리자
											</a>
											</c:when>
											<c:otherwise>
											<a href="/#" class="setAccess" data-access="${CategoryVo.category_access }"
											   data-code="${CategoryVo.category_code }">
												유저
											</a>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${CategoryVo.board_num }</td>
									<td>${CategoryVo.comment_num }</td>
									<c:choose>
										<c:when test="${CategoryVo.category_state == 'Y' && not empty CategoryVo.category_order}">
										<td style="color:green;">
										등록됌
										</td>
										</c:when>
										<c:when test="${CategoryVo.category_state == 'Y' && empty CategoryVo.category_order}">
										<td style="color:#ff7f00;">
										등록안됌
										</td>
										</c:when>
										<c:when test="${CategoryVo.category_state == 'N' }">
										<td style="color:red;">
										삭제됌
										</td>
										</c:when>
									</c:choose>
									<td>
										<c:choose>
										<c:when test="${CategoryVo.category_state == 'Y' && not empty CategoryVo.category_order}">
											<button type="button" class="btn btn-sm btn-danger deleteCategory" data-code="${CategoryVo.category_code }">삭제</button>
										</c:when>
										<c:when test="${CategoryVo.category_state == 'Y' && empty CategoryVo.category_order}">
											<button type="button" class="btn btn-sm btn-danger deleteCategory" data-code="${CategoryVo.category_code }">삭제</button>
										</c:when>
										<c:when test="${CategoryVo.category_state == 'N'}">
											<button type="button" class="btn btn-sm btn-success restoreCategory" data-code="${CategoryVo.category_code }">복구</button>
										</c:when>
										</c:choose>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="col-md-12">
						<!-- 페이징 작업 하기 -->
						<div class="row">
				          <div class="col text-center text-md-left">
				            <div class="block-27">
				              <ul id="pagination" style="text-align: center;">
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
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 어드민 페이지 메뉴 -->
<%@ include file="../adminInclude/adminMenuFooter.jsp" %>
<!-- footer 링크 설정 부분 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
