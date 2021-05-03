<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	ul ul {
		display: none;
	}
	ul li:hover > ul {
		display: block;
	}
	.mainMenu {
		font-size: 20px;
		margin-left: 20px;
		margin-right: 20px;
	}
	.categoryMenu {
		font-size: 20px;
		margin-left: 20px;
		margin-right: 20px;
	}
	.registBtn {
		padding-left: 50px;
		padding-right: 50px;
		margin-top: 20px;
		margin-bottom: 20px;
	}
	
</style>
<script>
$(function() {
	// 제이쿼리를 이용하여 aside의 카테고리 목록 불러오기
	var url = "/asideCategory/categoryList";
	var categoryList;
	
	$.get(url, function(rDate) {
		categoryList = rDate;
		// 카테고리 코드랑 이름 받아옴 이걸 이제 반복시켜 .each 제이쿼리 코드로 만들어서 집어넣으면 됌.
		$.each(rDate.reverse(), function() {
			var category_order = this.category_order;
			var category_state = this.category_state;
			if(category_state == 'Y' && category_order != null && category_order != "") {
				var category_code = this.category_code;
				var category_name = this.category_name;
				
				// 카테고리 샘플을 이용해서 클론 만들어서 카테고리 붙이기
				var category_clone = $("#category_sample").clone();
				category_clone.find(".category_name").text(category_name);
				category_clone.find(".category_name").addClass("categoryMenu");
				category_clone.find(".category_name").parent().parent().attr("id", category_code);
				category_clone.find(".category_name").parent().attr("href", "/board/boardList?clickCategory=" + category_code);
				category_clone.css("display", "");
				
				$("#listAll").after(category_clone);
			}
		});
		
		// 선택한 카테고리의 색상 변경시켜서 이용자가 보기 쉽게 만들기, 카테고리가 비어있으면 메인페이지 선택
		var select_category = "${clickCategory}";
		var category_length= select_category.length;
		$("#" + select_category).addClass("colorlib-active");
		if(category_length == 0) {
			$("#mainView").addClass("colorlib-active");
		}
	});
});
</script>
<!-- 숨겨서 복사해서 사용할 카테고리 샘플 -->
<li id="category_sample" style="display: none;">
	<!-- 대단위 카테고리 -->
	<a><strong class="category_name mainMenu"></strong></a>
</li>
<aside id="colorlib-aside" role="complementary" class="js-fullheight">
	<nav id="colorlib-main-menu" role="navigation">
	<!-- 글쓰는건 버튼으로 만들기 -->
	<c:if test="${not empty sessionScope.member_id }">
	<a class="registBtn btn btn-primary btn-lg" href="/board/registForm?clickCategory=${clickCategory}">글쓰기</a>
	</c:if>
	<ul>
		<li id="mainView"><a href="/board/mainView"><strong class="mainMenu">메인 페이지</strong></a></li>
		<li id="listAll"><a href="/board/listAll?clickCategory=listAll"><strong class="mainMenu">전체 글 보기</strong></a></li>
		<!-- 카테고리 목록 불러올 곳 -->
		<c:if test="${not empty sessionScope.member_id }">
			<li id="myPage"><a class="mainMenu" href="/member/myPage?clickCategory=myPage">${sessionScope.member_id}</a><strong>님 환영합니다.</strong></li>
		</c:if>
		<c:if test="${sessionScope.member_state == 'A'}">
			<li id="admin"><a href="/admin/adminChartForm?clickCategory=admin"><strong class="mainMenu">관리자 페이지</strong></a></li>
		</c:if>
		<c:choose>
			<c:when test="${not empty sessionScope.member_id}">
				<li><a href="/member/logout"><strong class="mainMenu">로그아웃</strong></a></li>
			</c:when>
			<c:otherwise>
				<li id="login"><a href="/member/loginForm?clickCategory=login"><strong class="mainMenu">로그인</strong></a></li>
				<li id="join"><a href="/member/joinForm?clickCategory=join"><strong class="mainMenu">회원가입</strong></a></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</nav>
	<div class="colorlib-footer">
		<h1 id="colorlib-logo" class="mb-4">
			<a href="/boardPage/mainView" style="background-image: url(/resources/images/bg_1.jpg);">Cyrus<span style="margin-bottom: 15px;">Community</span>
			</a>
		</h1>
	</div>
</aside>
<!-- END COLORLIB-ASIDE -->