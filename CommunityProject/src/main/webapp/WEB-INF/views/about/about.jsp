<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<!-- header 부분 인크루드 -->
<%@ include file="../include/header.jsp" %>
  <body>

	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		
		<!-- aside.jsp 인크루드 -->
		<%@ include file="../include/aside.jsp" %>
		
		<div id="colorlib-main">
			<section class="ftco-about img ftco-section ftco-no-pt ftco-no-pb" id="about-section">
	    	<div class="container-fluid px-0">
	    		<div class="row d-flex">
	    			<div class="col-md-6 d-flex">
	    				<div class="img d-flex align-self-stretch align-items-center js-fullheight" style="background-image:url(images/about.jpg);">
	    				</div>
	    			</div>
	    			<div class="col-md-6 d-flex align-items-center">
	    				<div class="text px-4 pt-5 pt-md-0 px-md-4 pr-md-5 ftco-animate">
		            <h2 class="mb-4">I'm <span>Andrea Moore</span> a Scotish Blogger &amp; Explorer</h2>
		            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
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