<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
<style>
	.atc_input {
		cursor : pointer;
		color : blue;
		text-size : 15px;
		margin-left: 15px;
		padding-left: 5px;
		padding-right: 5px;
		background-color : #ccc;
	}
</style>
<body>

<!-- 첨부파일 -->
<input type="file" class="form-control-file" id="image" style="display: none"/>
<input type="file" class="form-control-file" id="file" style="display: none"/>
<input type="file" class="form-control-file" id="movie" style="display: none"/>

	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		<!-- aside.jsp 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		
		<div id="colorlib-main">
			<section class="ftco-section contact-section px-md-4">
	      <div class="container">
	        <div class="row d-flex mb-5 contact-info">
	          <div class="col-md-12 mb-4">
	            <h2 class="h3">게시글 작성하기</h2>
	          </div>
	          <div class="w-100"></div>
	          <div class="col-lg-6 col-xl-3 d-flex mb-4">
	          	<div class="info bg-light p-4">
		            <p><span>Address:</span> 198 West 21th Street, Suite 721 New York NY 10016</p>
		          </div>
	          </div>
	          <div class="col-lg-6 col-xl-3 d-flex mb-4">
	          	<div class="info bg-light p-4">
		            <p><span>Phone:</span> <a href="tel://1234567920">+ 1235 2355 98</a></p>
		          </div>
	          </div>
	          <div class="col-lg-6 col-xl-3 d-flex mb-4">
	          	<div class="info bg-light p-4">
		            <p><span>Email:</span> <a href="mailto:info@yoursite.com">info@yoursite.com</a></p>
		          </div>
	          </div>
	          <div class="col-lg-6 col-xl-3 d-flex mb-4">
	          	<div class="info bg-light p-4">
		            <p><span>Website</span> <a href="#">yoursite.com</a></p>
		          </div>
	          </div>
	        </div>
	        <div class="row block-9">
	          <div class="col-lg-9 d-flex">
	            <form action="#" class="bg-light p-5 contact-form">
	              <div class="form-group">
	                <select>
	                	<option>카테고리 종류 넣을 셀렉트 박스</option>
	                </select>
	              </div>
	              <div class="form-group">
	              	<label class="atc_input" for="image">사진</label>
	              	<label class="atc_input" for="file">파일</label>
	              	<label class="atc_input" for="movie">동영상</label>
	              </div>
	              <div class="form-group">
	                <input type="text" class="form-control" name="board_title" placeholder="제목">
	              </div>
	              <div class="form-group">
	                <textarea name="board_content" cols="100" rows="15" placeholder="내용을 입력해주세요."></textarea>
	              </div>
	              <div class="form-group">
	                <input type="submit" value="작성하기" class="btn btn-primary py-3 px-5">
	                <input type="button" value="취소하기" class="btn btn-primary py-3 px-5">
	              </div>
	            </form>
	          
	          </div>
	        </div>
	      </div>
	    </section>
		</div><!-- END COLORLIB-MAIN -->
	</div><!-- END COLORLIB-PAGE -->


<!-- 지도 api인듯? -->
<!--   <!-- loader -->
<!--   <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div> -->


<!-- footer.jsp 인크루드 -->
<%@ include file="../include/footer.jsp" %>
    
  </body>
</html>