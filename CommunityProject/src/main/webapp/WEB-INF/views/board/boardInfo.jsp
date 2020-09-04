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
</style>
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
<script>
$(function() {
	$(".appendingFile").each(function() {
		var fileName = $(this).text();
		var doubleUnderbarIndex = fileName.lastIndexOf("__") + 2;
		var originalFileName = fileName.substring(doubleUnderbarIndex);
		$(this).text(originalFileName);
	});
});
</script>
  <body>
	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		
		<!-- aside.jsp 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		
		<div id="colorlib-main">
			<section class="ftco-section ftco-no-pt ftco-no-pb">
	    	<div class="container">
	    		<div class="row d-flex">
	    			<div class="col-lg-8 px-md-5 py-5">
	    				<div class="pt-md-4">
	    					<h1><span>${BoardVo.board_title}</span></h1>
	    					<span class="subSpan">${BoardVo.member_id} |</span>
	    					<span class="subSpan">${BoardVo.board_reg_t} |</span>
	    					<span class="subSpan">조회 : ${BoardVo.board_view}</span>
		            		<hr>
	    					<div class="pt-3 mt-3">
		            			<p class="content">${BoardVo.board_content}</p>
		            		</div>
		            		
		            		<!-- 좋아요 싫어요 구현하기 -->
		            		<div class="pt-3 mt-3" style="text-align: center;">
		            			<span class="up">${BoardVo.board_up}</span>
		            			<img alt="up" src="/resources/images/up.png" width="50px;" height="50px;">
		            		</div>
		            		<!-- 첨부파일 -->
	    					<div class="mt-5" style="border: 1px solid; border-color: gray;">
	    						<strong>첨부파일</strong>
	    						<c:forEach items="${BoardFileList}" var="BoardFileVo">
		            				<p class="appendingFile">${BoardFileVo.file_name}</p>
	    						</c:forEach>
		            		</div>
<!-- 	            			네모난 박스 뜨는데 난중에 보고 활용할거 있으면 활용하기 -->
<!-- 				            <div class="tag-widget post-tag-container mb-5 mt-5"> -->
<!-- 				              <div class="tagcloud"> -->
<!-- 				                <a href="#" class="tag-cloud-link">Life</a> -->
<!-- 				                <a href="#" class="tag-cloud-link">Sport</a> -->
<!-- 				                <a href="#" class="tag-cloud-link">Tech</a> -->
<!-- 				                <a href="#" class="tag-cloud-link">Travel</a> -->
<!-- 				              </div> -->
<!-- 				            </div> -->

		            	<!-- 명언 상자 같은데 개인 정보 넣는 걸로 활용 가능할듯 -->
<!-- 		            <div class="about-author d-flex p-4 bg-light"> -->
<!-- 		              <div class="bio mr-5"> -->
<!-- 		                <img src="images/person_1.jpg" alt="Image placeholder" class="img-fluid mb-4"> -->
<!-- 		              </div> -->
<!-- 		              <div class="desc"> -->
<!-- 		                <h3>George Washington</h3> -->
<!-- 		                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus itaque, autem necessitatibus voluptate quod mollitia delectus aut, sunt placeat nam vero culpa sapiente consectetur similique, inventore eos fugit cupiditate numquam!</p> -->
<!-- 		              </div> -->
<!-- 		            </div> -->


					<!-- 댓글 부분 -->
		            <div class="pt-5 mt-5">
		              <h3 class="mb-5 font-weight-bold">6 Comments</h3>
		              <ul class="comment-list">

		                <li class="comment">
		                  <div class="vcard bio">
		                    <img src="images/person_1.jpg" alt="Image placeholder">
		                  </div>
		                  <div class="comment-body">
		                    <h3>John Doe</h3>
		                    <div class="meta">October 03, 2018 at 2:21pm</div>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem laborum necessitatibus, ipsam impedit vitae autem, eum officia, fugiat saepe enim sapiente iste iure! Quam voluptas earum impedit necessitatibus, nihil?</p>
		                    <p><a href="#" class="reply">Reply</a></p>
		                  </div>
		                </li>
		              </ul>
		              <!-- END comment-list -->
		              
		              <!-- 댓글다는 부분 -->
		              <div class="comment-form-wrap pt-5">
		                <h3 class="mb-5">Leave a comment</h3>
		                <form action="#" class="p-3 p-md-5 bg-light">
		                  <div class="form-group">
		                    <label for="name">Name *</label>
		                    <input type="text" class="form-control" id="name">
		                  </div>
		                  <div class="form-group">
		                    <label for="email">Email *</label>
		                    <input type="email" class="form-control" id="email">
		                  </div>
		                  <div class="form-group">
		                    <label for="website">Website</label>
		                    <input type="url" class="form-control" id="website">
		                  </div>

		                  <div class="form-group">
		                    <label for="message">Message</label>
		                    <textarea name="" id="message" cols="30" rows="10" class="form-control"></textarea>
		                  </div>
		                  <div class="form-group">
		                    <input type="submit" value="Post Comment" class="btn py-3 px-4 btn-primary">
		                  </div>

		                </form>
		              </div>
		            </div>
			    		</div><!-- END-->
			    	</div>
		    	<!-- 오른쪽 사이드 부분 -->
    			<div class="col-lg-4 sidebar ftco-animate bg-light pt-5">
	            <div class="sidebar-box pt-md-4">
	              <form action="#" class="search-form">
	                <div class="form-group">
	                  <span class="icon icon-search"></span>
	                  <input type="text" class="form-control" placeholder="Type a keyword and hit enter">
	                </div>
	              </form>
	            </div>
	            <div class="sidebar-box ftco-animate">
	            	<h3 class="sidebar-heading">Categories</h3>
	              <ul class="categories">
	                <li><a href="#">Fashion <span>(6)</span></a></li>
	                <li><a href="#">Technology <span>(8)</span></a></li>
	                <li><a href="#">Travel <span>(2)</span></a></li>
	                <li><a href="#">Food <span>(2)</span></a></li>
	                <li><a href="#">Photography <span>(7)</span></a></li>
	              </ul>
	            </div>

	            <div class="sidebar-box ftco-animate">
	              <h3 class="sidebar-heading">Popular Articles</h3>
	              <div class="block-21 mb-4 d-flex">
	                <a class="blog-img mr-4" style="background-image: url(images/image_1.jpg);"></a>
	                <div class="text">
	                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control</a></h3>
	                  <div class="meta">
	                    <div><a href="#"><span class="icon-calendar"></span> June 28, 2019</a></div>
	                    <div><a href="#"><span class="icon-person"></span> Dave Lewis</a></div>
	                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
	                  </div>
	                </div>
	              </div>
	              <div class="block-21 mb-4 d-flex">
	                <a class="blog-img mr-4" style="background-image: url(images/image_2.jpg);"></a>
	                <div class="text">
	                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control</a></h3>
	                  <div class="meta">
	                    <div><a href="#"><span class="icon-calendar"></span> June 28, 2019</a></div>
	                    <div><a href="#"><span class="icon-person"></span> Dave Lewis</a></div>
	                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
	                  </div>
	                </div>
	              </div>
	              <div class="block-21 mb-4 d-flex">
	                <a class="blog-img mr-4" style="background-image: url(images/image_3.jpg);"></a>
	                <div class="text">
	                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control</a></h3>
	                  <div class="meta">
	                    <div><a href="#"><span class="icon-calendar"></span> June 28, 2019</a></div>
	                    <div><a href="#"><span class="icon-person"></span> Dave Lewis</a></div>
	                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
	                  </div>
	                </div>
	              </div>
	            </div>

				<!-- 오른쪽에 있는 태그들 -->
<!-- 	            <div class="sidebar-box ftco-animate"> -->
<!-- 	              <h3 class="sidebar-heading">Tag Cloud</h3> -->
<!-- 	              <ul class="tagcloud"> -->
<!-- 	                <a href="#" class="tag-cloud-link">animals</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">human</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">people</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">cat</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">dog</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">nature</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">leaves</a> -->
<!-- 	                <a href="#" class="tag-cloud-link">food</a> -->
<!-- 	              </ul> -->
<!-- 	            </div> -->

							<div class="sidebar-box subs-wrap img" style="background-image: url(images/bg_1.jpg);">
								<div class="overlay"></div>
								<h3 class="mb-4 sidebar-heading">Newsletter</h3>
								<p class="mb-4">Far far away, behind the word mountains, far from the countries Vokalia</p>
	              <form action="#" class="subscribe-form">
	                <div class="form-group">
	                  <input type="text" class="form-control" placeholder="Email Address">
	                  <input type="submit" value="Subscribe" class="mt-2 btn btn-white submit">
	                </div>
	              </form>
	            </div>

	            <div class="sidebar-box ftco-animate">
	            	<h3 class="sidebar-heading">Archives</h3>
	              <ul class="categories">
	              	<li><a href="#">December 2018 <span>(10)</span></a></li>
	                <li><a href="#">September 2018 <span>(6)</span></a></li>
	                <li><a href="#">August 2018 <span>(8)</span></a></li>
	                <li><a href="#">July 2018 <span>(2)</span></a></li>
	                <li><a href="#">June 2018 <span>(7)</span></a></li>
	                <li><a href="#">May 2018 <span>(5)</span></a></li>
	              </ul>
	            </div>


	            <div class="sidebar-box ftco-animate">
	              <h3 class="sidebar-heading">Paragraph</h3>
	              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus itaque, autem necessitatibus voluptate quod mollitia delectus aut.</p>
	            </div>
	          </div><!-- END COL -->
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