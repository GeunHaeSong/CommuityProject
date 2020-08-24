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
	.subMenu {
		font-size: 15px;
		margin-left: 20px;
	}
</style>
<aside id="colorlib-aside" role="complementary" class="js-fullheight">
	<nav id="colorlib-main-menu" role="navigation">
	<ul>
		<li class="colorlib-active"><a href="/boardPage/mainView">메인 페이지</a></li>
		<li>
			<a href="/boardPage/about"><strong>공지사항</strong></a>
			<ul>
				<li><a class="subMenu" href="/boardPage/about">공지사항</a></li>
				<c:if test="${member_state == 'A'}">
				<li><a class="subMenu" href="/boardPage/about">글 쓰기</a></li>
				</c:if>
			</ul>
		</li>
		<li>
			<a href="/boardPage/contact"><strong>이벤트</strong></a>
			<ul>
				<li><a class="subMenu" href="/boardPage/contact">이벤트 목록</a></li>
				<li><a class="subMenu" href="/boardPage/contact">글 쓰기</a></li>
			</ul>
		</li>
		<li>
			<a href="/freeBoard/boardList"><strong>전체 게시판</strong></a>
			<ul>
				<li><a class="subMenu"  href="/freeBoard/boardList">게시판 목록</a></li>
				<li><a class="subMenu" href="/freeBoard/registForm">글 쓰기</a></li>
			</ul>
		</li>
		<li>
			<a href="/freeBoard/boardList?category_code=CG3"><strong>자유 게시판</strong></a>
			<ul>
				<li><a class="subMenu"  href="/freeBoard/boardList?category_code=CG3">게시판 목록</a></li>
				<li><a class="subMenu" href="/freeBoard/registForm">글 쓰기</a></li>
			</ul>
		</li>
		<li>
			<a href="/boardPage/single"><strong>사진 게시판</strong></a>
			<ul>
				<li><a class="subMenu" href="/boardPage/single">게시판 목록</a></li>
				<li><a class="subMenu" href="/boardPage/contact">글 쓰기</a></li>
			</ul>
		</li>
		<li>
			<a href="/boardPage/travel"><strong>가입 인사</strong></a>
			<ul>
				<li><a class="subMenu" href="/boardPage/travel">가입 인사 목록</a></li>
				<li><a class="subMenu" href="/boardPage/contact">글 쓰기</a></li>
			</ul>
		</li>
		<li><a href="/boardPage/about"><strong>출석</strong></a></li>
		<br/>
		<c:if test="${not empty sessionScope.member_id }">
			<li><a href="/member/myPage">${sessionScope.member_id}</a>님 환영합니다.</li>
		</c:if>
		<c:if test="${sessionScope.member_state == 'A'}">
			<li><a href="/admin/adminMainFrom"><strong>관리자 페이지</strong></a></li>
		</c:if>
		<c:choose>
			<c:when test="${not empty sessionScope.member_id}">
				<li><a href="/member/logout"><strong>로그아웃</strong></a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/member/loginForm"><strong>로그인</strong></a></li>
				<li><a href="/member/joinForm"><strong>회원가입</strong></a></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</nav>
	<div class="colorlib-footer">
		<h1 id="colorlib-logo" class="mb-4">
			<a href="/boardPage/mainView" style="background-image: url(/resources/images/bg_1.jpg);">Cyrus
				<span>Community</span>
			</a>
		</h1>
<!-- 		<div class="mb-4"> -->
<!-- 			<h3>Subscribe for newsletter</h3> -->
<!-- 			<form action="#" class="colorlib-subscribe-form"> -->
<!-- 				<div class="form-group d-flex"> -->
<!-- 					<div class="icon"> -->
<!-- 						<span class="icon-paper-plane"></span> -->
<!-- 					</div> -->
<!-- 					<input type="text" class="form-control" -->
<!-- 						placeholder="Enter Email Address"> -->
<!-- 				</div> -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 		<p class="pfooter"> -->
<!-- 			<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
<!-- 			Copyright &copy; -->
<!-- 			<script>document.write(new Date().getFullYear());</script> -->
<!-- 			All rights reserved | This template is made with <i -->
<!-- 				class="icon-heart" aria-hidden="true"></i> by <a -->
<!-- 				href="https://colorlib.com" target="_blank">Colorlib</a> -->
<!-- 			<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
<!-- 		</p> -->
	</div>
</aside>
<!-- END COLORLIB-ASIDE -->