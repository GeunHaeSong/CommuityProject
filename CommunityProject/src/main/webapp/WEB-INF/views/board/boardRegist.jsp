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
<meta charset="utf-8">
<body>
<script>
$(function() {
	
	var boardResult = "${boardResult}";
	if(boardResult == "false") {
		alert("게시글 등록에 실패하였습니다.");
	};
	
	$("#registForm").submit(function() {
		var category_code = $("#category option:selected").val();
		var categoryHidden = "<input type='hidden' name='category_code' value='"+category_code+"'>";
		$("#registForm").prepend(categoryHidden);
		
		var upDiv = $("#choiceFile > div");
		upDiv.each(function(index) {
			var fileName = $(this).attr("data-fileName");
			var hiddenInput = "<input type='hidden' name='boardFile' value='"+fileName+"'/>";
			$("#registForm").prepend(hiddenInput);
		});
	});
	
	// 취소하기
	$("#btn_cancel").click(function() {
		location.href = "/board/cancelRun";
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
//파일 업로드 - 여러개
function uploadFile(value) {
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
		var url = "/board/uploadAjax";
		$.ajax({
			"processData" : false,  // text 파일
			"contentType" : false,	// text 파일
			"type" : "post",
			"url" : url,
			"data" : formData,
			"success" : function(rData) {
				// 만든 썸네일 구분하기
				var slashIndex = rData.lastIndexOf("/");
				var front = rData.substring(0, slashIndex + 1);
				var rear = rData.substring(slashIndex + 1);
				var originalFilename = rData.substring(rData.lastIndexOf("__") + 2);
				var thumbnailName = front + "sm_" + rear;
				
				// 확장자 구분하기
				var extensionIndex = rData.lastIndexOf(".");
				var extension = rData.substring(extensionIndex + 1);
				
				var html = "<div data-fileName='" + rData + "'>";
				if(extension == "jpg" || extension == "png" || extension == "gif") {
					html += "<img src='/board/displayImage?fileName=" + thumbnailName + "'/><br/>";
				} else {
					html += "<img src='/resources/images/fileImage.png' width='50' height='50'/><br/>";
				}
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
		var url = "/board/deleteImage";
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
<input type="file" class="form-control-file upload" id="image" multiple onchange="uploadFile(this);" style="display: none" accept="image/*"/>
<input type="file" class="form-control-file upload" id="file" multiple onchange="uploadFile(this);" style="display: none"/>
<input type="file" class="form-control-file upload" id="movie" multiple onchange="uploadFile(this);" style="display: none" accept="video/*"/>

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
        </div>
        <div class="row block-9">
          <div class="col-lg-9 d-flex">
            <form id="registForm" action="/board/registRun" class="bg-light p-5 contact-form" method="get">
	            <div class="form-group">
	              <select id="category">
	              <!-- 이용자의 계정이 어드민이면 모든 카테고리를 보여주고, 그렇지 않으면 어드민만 이용 가능한 카테고리 제외해서 보여주기 -->
	              	<c:choose>
	              		<c:when test="${sessionScope.member_state == 'A'}">
	              			<c:forEach items="${categoryList}" var="CategoryVo">
			              		<option value="${CategoryVo.category_code}">${CategoryVo.category_name}</option>
		              		</c:forEach>
	              		</c:when>
	              		<c:otherwise>
			              <c:forEach items="${categoryList}" var="CategoryVo">
			              	<c:if test="${CategoryVo.category_access eq sessionScope.member_state}">
				              <option value="${CategoryVo.category_code}">${CategoryVo.category_name}</option>
				            </c:if>
			              </c:forEach>
		              	</c:otherwise>
		            </c:choose>
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
		            <input id="btn_cancel" type="button" value="취소하기" class="btn btn-primary py-3 px-5">
	            </div>
            </form>
          </div>
        </div>
      </div>
    </section>
	</div><!-- END COLORLIB-MAIN -->
</div><!-- END COLORLIB-PAGE -->

<!-- footer.jsp 인크루드 -->
<%@ include file="../include/footer.jsp" %>
  </body>
</html>