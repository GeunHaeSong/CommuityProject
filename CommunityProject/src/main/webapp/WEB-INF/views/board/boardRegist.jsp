<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	.upload {
	  apperance: none;
	  -webkit-apperance: none;
	}
</style>
<body>
<script>
$(function() {
	
	var boardResult = "${boardResult}";
	if(boardResult == "false") {
		alert("게시글 등록에 실패하였습니다.");
	};
	
	$("#registForm").submit(function() {
		var category = $("#category option:selected").val();
		var categoryHidden = "<input type='hidden' name='category_code' value='"+category+"'>";
		$("#registForm").prepend(categoryHidden);
		
		var upDiv = $("#choiceFile > div");
		upDiv.each(function(index) {
			var fileName = $(this).attr("data-fileName");
			var hiddenInput = "<input type='hidden' name='boardFile' value='"+fileName+"'/>";
			$("#registForm").prepend(hiddenInput);
		});
	});
});

function isImage(fileName) {
	var extName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
	if(extName == "JPG" || extName == "PNG" || extName == "GIF") {
		return true;
	}
	return false;
}

var tempLength = 0;
var rearLength = 0;
//파일 데이터 미리보기 - 여러개
function loadSubImage(value) {
	console.log("subImage");
	$("#movie_sub_image_div > img").remove();
	var files = value.files;
	var filesArr = Array.prototype.slice.call(files);
	var fileIndex = 0;
	var length = filesArr.length;
	rearLength += length;
	
	filesArr.forEach(function(f) { 
		
		// 파일 추가하기
		var file = value.files[fileIndex];
		fileIndex ++;
		var formData = new FormData(); // <form> 작성
		formData.append("file", file); // <input type="file"> : 파일 선택
		var url = "/freeBoard/uploadAjax";
		$.ajax({
			"processData" : false,  // text 파일
			"contentType" : false,	// text 파일
			"type" : "post",
			"url" : url,
			"data" : formData,
			"success" : function(rData) {
				var slashIndex = rData.lastIndexOf("/");
				var front = rData.substring(0, slashIndex + 1);
				var rear = rData.substring(slashIndex + 1);
				var originalFilename = rData.substring(rData.lastIndexOf("-")+1);
				var thumbnailName = front + "sm_" + rear;
				var html = "<div data-fileName='" + rData + "'>";
				html += "<img src='/freeBoard/displayImage?fileName=" + thumbnailName + "'/><br/>";
				html += "<span>"+originalFilename+"</span>";
				html += "<a href='"+rData+"' class='attach-del1'><span class='pull-right' style='color:red;'>[삭제]</span></a>";
				html += "</div>";
				$("#choiceFile").append(html);
			}
		});	
	});
	// 이미지 지우기
	$("#colorlib-main").on("click", ".attach-del1", function(e) {
		tempLength = -1;
		e.preventDefault();
		var removeDiv = $(this).parent();
		var fileName = $(this).attr("href");
		var url = "/freeBoard/deleteImage";
		var sendData = {"fileName" : fileName};
		$.ajax({
			"type" : "get",
			"url" : url,
			"data" : sendData,
			"success" : function(rData) {
				var check = rearLength+tempLength;
				rearLength = check;
				tempLength = 0;
				removeDiv.remove();
			}
		});
	});
}
</script>

<!-- 첨부파일 -->
<input type="file" class="form-control-file upload" id="image" multiple onchange="loadSubImage(this);" style="display: none" accept="image/*"/>
<input type="file" class="form-control-file upload" id="file" style="display: none"/>
<input type="file" class="form-control-file upload" id="movie" style="display: none"/>

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
          <!-- 상단에 이미지 넣을려고 했는데 애매해서 일단 주석 처리, 나중에 여유되면 해보기 -->
<!-- 	          <div class="w-100"></div> -->
<!-- 	          <div class="col-lg-6 col-xl-3 d-flex mb-4"> -->
<!-- 	          	<div class="info bg-light p-4"> -->
<!-- 		            <p id="fileView0"></p> 파일이나 이미지 들어갈거 넣기 -->
<!-- 		          </div> -->
<!-- 	          </div> -->
<!-- 	          <div class="col-lg-6 col-xl-3 d-flex mb-4"> -->
<!-- 	          	<div class="info bg-light p-4"> -->
<!-- 		            <p id="fileView1"></p> -->
<!-- 		          </div> -->
<!-- 	          </div> -->
<!-- 	          <div class="col-lg-6 col-xl-3 d-flex mb-4"> -->
<!-- 	          	<div class="info bg-light p-4"> -->
<!-- 		            <p id="fileView2"></p> -->
<!-- 		          </div> -->
<!-- 	          </div> -->
<!-- 	          <div class="col-lg-6 col-xl-3 d-flex mb-4"> -->
<!-- 	          	<div class="info bg-light p-4"> -->
<!-- 		            <p id="fileView3"></p> -->
<!-- 		          </div> -->
<!-- 	          </div> -->
        </div>
        <div class="row block-9">
          <div class="col-lg-9 d-flex">
            <form id="registForm" action="/freeBoard/registRun" class="bg-light p-5 contact-form" method="get">
	            <div class="form-group">
	              <select id="category">
	              <c:forEach items="${categoryList}" var="RegistBoardVo">
	              	<option value="${RegistBoardVo.category_code}">${RegistBoardVo.category_name}</option>
	              </c:forEach>
	              </select>
	            </div>
	            <div class="form-group">
	            	<label class="atc_input" for="image">사진</label>
		            <label class="atc_input" for="file">파일</label>
		            <label class="atc_input" for="movie">동영상</label>
	            </div>
	            <div id="choiceFile">
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