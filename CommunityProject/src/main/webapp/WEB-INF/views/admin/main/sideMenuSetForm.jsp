<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header 스크립트 설정 부분 -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<!-- 부트스트랩 -->
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>

<style>
	.container-fluid {
		font-size: 18px;
	}
	
	img:hover {
    	cursor: pointer;
	}
	
	.outCategory {
		color: red;
		cursor: pointer;
	}
</style>

<script>
$(function() {
	
	var insertResult = "${insertResult}";
	if(insertResult == "success") {
		alert("메뉴 생성에 성공하였습니다.");
	} else if(insertResult == "fail") {
		alert("메뉴 생성에 실패하였습니다.");
	}
	
	var changeCategoryResult = "${changeCategoryResult}";
	if(changeCategoryResult == "success") {
		alert("순서 변경에 성공하였습니다.");
	} else if(changeCategoryResult == "fail") {
		alert("순서 변경에 실패하였습니다.");
	}
	
	// 위로 올리기 버튼
	// 해당 버튼의 input 태그의 정보를 받아서 위 쪽의 input 태그와 교환(클론 생성)
	$("#categoryOrderDiv").on("click", ".orderUp", function() {
		// 자신 구하기
		var parentDiv = $(this).parent();
		var myCategory = parentDiv.find(".setCategory");
		var myOrder = myCategory.attr("data-order");
		// 만약 첫번째의 올리기 버튼 클릭시 이벤트 중지
		if(myOrder == 1) {
			return;
		}
		// 교환할 대상 구하기
		var prevDiv = parentDiv.prev();
		var prevCategory = prevDiv.find(".setCategory");
		var prevOrder = prevCategory.attr("data-order");
		myCategory.attr("data-order", prevOrder);
		prevCategory.attr("data-order", myOrder);
		
		// 클론 생성하고 교환할 두 대상을 삭제 한 후 클론을 해당 위치에 붙이기.
		// css로 이전처럼 나오게 조율
		var myClone = myCategory.clone();
		var prevClone = prevCategory.clone();
		myCategory.remove();
		prevCategory.remove();
		parentDiv.find(".outCategory").css("margin-right", "5px");
		prevDiv.find(".outCategory").css("margin-right", "5px");
		parentDiv.find(".outCategory").after(prevClone);
		prevDiv.find(".outCategory").after(myClone);
	});
	
	// 아래로 내리기 버튼 
	// 해당 버튼의 input 태그의 정보를 받아서 아래 쪽의 input 태그와 교환(클론 생성)
	$("#categoryOrderDiv").on("click", ".orderDown", function() {
		// 자신 구하기
		var parentDiv = $(this).parent();
		var myCategory = parentDiv.find(".setCategory");
		var myOrder = myCategory.attr("data-order");
		var orderLength = $(".orderDown").length;
		// 만약 마지막 버튼의 내리기 클릭시 이벤트 중지
		if(myOrder >= orderLength) {
			return;
		}
		// 교환할 대상 구하기
		var nextDiv = parentDiv.next();
		var nextCategory = nextDiv.find(".setCategory");
		var nextOrder = nextCategory.attr("data-order");
		myCategory.attr("data-order", nextOrder);
		nextCategory.attr("data-order", myOrder);
		
		// 클론 생성하고 교환할 대상들을 삭제하고 클론을 통해 해당 위치로 교환, 이전처럼 나오게 css로 조율
		var myClone = myCategory.clone();
		var nextClone = nextCategory.clone();
		myCategory.remove();
		nextCategory.remove();
		parentDiv.find(".outCategory").css("margin-right", "5px");
		nextDiv.find(".outCategory").css("margin-right", "5px");
		parentDiv.find(".outCategory").after(nextClone);
		nextDiv.find(".outCategory").after(myClone);
	});
	
	// 카테고리 생성 모달 버튼
	$("#openModal").click(function() {
		// 카테고리의 최대 숫자 구하기
		var list = $(".setCategory");
		var listLength = 0;
		$.each(list, function() {
			listLength += 1;
		});
		listLength += 1;
		
		// 최대 9개까지 등록 가능
		if(listLength >= 10) {
			alert("사이드 메뉴 생성은 최대 9개까지 가능합니다. 사용하지 않는 메뉴는 삭제해주세요.");
			return;
		}
		
		$("#createModalBtn").trigger("click");
	});
	
	// 카테고리 생성 저장
	$("#createCategoryBtn").click(function() {
		var category_name = $("#category_name").val();
		var category_access = $("#accessSelect option:selected").val();
		$("#hiddenCategoryName").val(category_name);
		$("#hiddenCategoryAccess").val(category_access);
		
		$("#insertCategory").submit();
	});
	
	// 모달이 닫혔을때 정보들 초기화 시키기
	$("#modal-container-232265").on("hidden.bs.modal", function() {
		$("#category_name").val("");
		$("#accessSelect option:eq(0)").attr("selected", "true");
	});
	
	
	// 등록되지 않은 카테고리 등록
	$("#notCategory").on("click", ".inCategoryBtn", function() {
		// 카테고리의 최대 숫자 구하기
		var list = $(".changeCategory");
		var listLength = 0;
		$.each(list, function() {
			listLength += 1;
		});
		listLength += 1;
		
		// 최대 9개까지 등록 가능
		if(listLength >= 10) {
			alert("더이상 등록할 수 없습니다.");
			return;
		}
		
		// 카테고리 이름 구하고 html 생성
		var category_name = $(this).parent().find(".setCategory").val();
		var category_code = $(this).parent().find(".setCategory").attr("data-code");
		var newCategoryHtml = "<div><span class='outCategory' style='margin-right:5px;'>x</span>";
		newCategoryHtml += "<input type='text' value='" + category_name + "' class='setCategory changeCategory' data-order='" + listLength + "' data-code='" + category_code + "' disabled>";
		newCategoryHtml += "<img class='orderUp' src='/resources/images/upArr.png' style='width:20px; margin-left:5px;'>";
		newCategoryHtml += "<img class='orderDown' src='/resources/images/downArr.png' style='width:20px; margin-left: 5px;'></div>";
		// 붙이기
		$("#changeCategoryDiv").append(newCategoryHtml);
		// 만들었으면 다시 못붙이게 삭제하기
		$(this).parent().remove();
	});
	
	// 등록된 카테고리 빼기
	$("#changeCategoryDiv").on("click", ".outCategory", function() {
		// html 만들어서 붙이기
		var category_name = $(this).parent().find(".setCategory").val();
		var category_code = $(this).parent().find(".setCategory").attr("data-code");
		var newCategoryHtml = "<div><input type='text' value='" + category_name + "' class='setCategory' data-code='" + category_code + "' disabled>";
		newCategoryHtml += "<button type='button' class='btn btn-sm btn-success inCategoryBtn' style='margin-left:5px;'>등록</button></div>";
		$("#notCategory").append(newCategoryHtml);
		// 삭제
		$(this).parent().remove();
		
		// 삭제할때마다 카테고리 순서를 재배치
		var changeCategory = $(".changeCategory");
		var orderNum = 1;
		$.each(changeCategory, function() {
			$(this).attr("data-order", orderNum);
			orderNum++;
		});
	});
	
	// 순서 변경 저장
	$("#changeSaveBtn").click(function() {
		// input hidden 만들 데이터
		var categoryList = $(".setCategory");
		
		$.each(categoryList, function() {
			var category_code = $(this).attr("data-code");
			var category_order = $(this).attr("data-order");
			
			var hiddenCodeHtml = "<input type='hidden' name='category_code_arr' value='" + category_code + "'>";
			var hiddenOrderHtml = "<input type='hidden' name='category_order_arr' value='" + category_order + "'>";
			$("#changeSave").append(hiddenCodeHtml);
			$("#changeSave").append(hiddenOrderHtml);
		});
		// 전송
		$("#changeSave").submit();
	});
	
	// 뒤로 가기 버튼
	$("#mngMenuBtn").click(function(e) {
		e.preventDefault();
		$("#mngMenuForm").submit();
	});
});
</script>

<!-- 카테고리 생성 전송 폼 -->
<form id="insertCategory" action="/admin/insertCategoryRun" method="get">
	<input type="hidden" id="hiddenCategoryName" name="category_name">
	<input type="hidden" id="hiddenCategoryAccess" name="category_access">
</form>
<!-- 순서 변경 전송 폼 -->
<form id="changeSave" action="/admin/changeCategoryRun" method="post">
</form>
<!-- 뒤로가기 폼(검색 넘기기) -->
<form id="mngMenuForm" action="/admin/sideMenuMngForm" method="get">
	<input type="hidden" name="clickCategory" value="admin">
	<input type="hidden" name="page" value="${pagingDto.page }">
	<input type="hidden" value="${pagingDto.stateType}">
	<input type="hidden" value="${pagingDto.keywordType}">
	<input type="hidden" value="${pagingDto.keyword}">
</form>
<!-- 카테고리 생성에 쓸 모달 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<a id="createModalBtn" href="#modal-container-232265" style="display: none;" role="button" class="btn" data-toggle="modal">Launch demo modal</a>
			<div class="modal fade" id="modal-container-232265" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">
								사이드 메뉴 생성
							</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label for="category_name">이름 : </label>
								<input type="text" id="category_name" placeholder="사이드 메뉴 이름"/>
							</div>
							<div class="checkbox">
								<span>접권 권한 : </span>
								<select id="accessSelect">
									<option value="A">관리자</option>
									<option value="Y">일반유저</option>
								</select>
							</div> 
						</div>
						<div class="modal-footer">
							<button type="button" id="createCategoryBtn" class="btn btn-primary">
								생성
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

<!-- 본문 -->
<div class="container-fluid" style="margin-top: 18px;">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-3">
			<!-- 패널 타이틀2 -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">현재 등록된 사이드 메뉴</h3>
				</div>
				<!-- 사이드바 메뉴목록2 -->
				<ul class="list-group">
					<c:forEach items="${categoryList}" var="CategoryVo">
					<c:if test="${CategoryVo.category_state == 'Y' && not empty CategoryVo.category_order }">
						<li class="list-group-item" style="text-align: center;"><strong>${CategoryVo.category_name}</strong></li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="col-md-3" id="categoryOrderDiv">
			<div class="container-fluid">
				<div class="row">
					<div id="changeCategoryDiv" style="margin-left: 40px;">
						<h3>카테고리 순서 변경</h3>
						<!-- 카테고리 순서 변경 -->
						<c:forEach items="${categoryList}" var="CategoryVo">
						<c:if test="${CategoryVo.category_state == 'Y' && not empty CategoryVo.category_order }">
							<div>
								<span class="outCategory">x</span>
								<input type="text" value="${CategoryVo.category_name }" class="setCategory changeCategory" data-order="${CategoryVo.category_order }"
									    data-code="${CategoryVo.category_code}" disabled>
								<img class="orderUp" src="/resources/images/upArr.png" style="width:20px;">
								<img class="orderDown" src="/resources/images/downArr.png" style="width:20px;">
							</div>
						</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-5">
			<div class="container-fluid">
				<div class="row">
					<div  id="notCategory" style="margin-left: 40px;">
						<h3>등록되지 않은 카테고리</h3>
						<!-- 카테고리 순서 변경 -->
						<c:forEach items="${categoryList}" var="CategoryVo">
						<c:if test="${CategoryVo.category_state == 'Y' && empty CategoryVo.category_order}">
						<div>
							<input type="text" value="${CategoryVo.category_name }" class="setCategory" data-code="${CategoryVo.category_code }" disabled>
							<button type="button" class="btn btn-sm btn-success inCategoryBtn">등록</button>
						</div>
						</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div style="margin: auto; width: 30%;">
				<button id="openModal" type="button" class="btn btn-lg btn-primary">생성</button>
				<button id="changeSaveBtn" type="button" class="btn btn-lg btn-success">순서 변경</button>
				<a id="mngMenuBtn" href="#" class="btn btn-lg btn-secondary">뒤로</a>
			</div>
		</div>
	</div>
</div>

<!-- 어드민 페이지 메뉴 -->
<%@ include file="../adminInclude/adminMenuFooter.jsp" %>
<!-- footer 링크 설정 부분 -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
