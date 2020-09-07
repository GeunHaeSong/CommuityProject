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
	
	$(".displayThumbnail").each(function() {
		var fileName = $(this).parent().attr("data-fileName");
		var slashIndex = fileName.lastIndexOf("/");
		var front = fileName.substring(0, slashIndex + 1);
		var rear = fileName.substring(slashIndex + 1);
		// 원래 파일 이름 사용할 일 있으면 나중에 사용하기
		var thumbnailName = front + "sm_" + rear;
		$(this).attr("src", "/freeBoard/displayImage?fileName=" + thumbnailName);
	});
	
	// 전송하기
	$("#updateForm").submit(function() {
		var category = $("#category option:selected").val();
		var categoryHidden = "<input type='hidden' name='category_code' value='"+category+"'>";
		$("#updateForm").prepend(categoryHidden);
		
		var upDiv = $("#choiceFile > div");
		upDiv.each(function(index) {
			var fileName = $(this).attr("data-fileName");
			var hiddenInput = "<input type='hidden' name='boardFile' value='"+fileName+"'/>";
			$("#updateForm").prepend(hiddenInput);
		});
	});
	
	// 새로 추가한 이미지 지우기
	$("#choiceFile").on("click", ".attach-del", function(e) {
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
	
	// 원래 있던 이미지 지우기
	$("#originalBoardFile").on("click", ".attach-del", function(e) {
		tempLength = -1;
		e.preventDefault();
		
		var fileCode = $(this).attr("data-fileCode");
		var fileCodeHidden = "<input type='hidden' name='delFileCode' value='"+fileCode+"'/>";
		$("#updateForm").prepend(fileCodeHidden);
		
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
		var url = "/freeBoard/uploadAjax";
		$.ajax({
			"processData" : false,  // text 파일
			"contentType" : false,	// text 파일
			"type" : "post",
			"url" : url,
			"data" : formData,
			"success" : function(rData) {
				// 만든 썸네일 구분하기
				console.log("rData :" + rData);
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
					html += "<img src='/freeBoard/displayImage?fileName=" + thumbnailName + "'/><br/>";
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
            <h2 class="h3">게시글 수정하기</h2>
          </div>
        </div>
        <div class="row block-9">
          <div class="col-lg-9 d-flex">
            <form id="updateForm" action="/freeBoard/updateBoardRun" class="bg-light p-5 contact-form" method="get">
            	<input type="hidden" name="board_num" value="${BoardVo.board_num}"/>
	            <div class="form-group">
	              <select id="category">
	              <c:forEach items="${categoryList}" var="CategoryVo">
	              	<option value="${CategoryVo.category_code}"
	              	<c:if test="${BoardVo.category_code == CategoryVo.category_code}">
	              		selected
	              	</c:if>
	              	>${CategoryVo.category_name}</option>
	              </c:forEach>
	              </select>
	            </div>
	            <div class="form-group">
	            	<label class="atc_input" for="image">사진</label>
		            <label class="atc_input" for="file">파일</label>
		            <label class="atc_input" for="movie">동영상</label>
	            </div>
	            <!-- 원래 글에 있는 파일 -->
	            <div id="originalBoardFile">
	            	<c:forEach items="${boardFileList}" var="BoardFileVo">
	            		<div data-fileName="${BoardFileVo.file_name}">
	            			<c:choose>
		            			<c:when test="${BoardFileVo.file_extension == 'jpg' || BoardFileVo.file_extension == 'png' || BoardFileVo.file_extension == 'gif'}">
									<img src="/freeBoard/displayImage?fileName=${BoardFileVo.file_name}" class="displayThumbnail"/>
								</c:when>
								<c:otherwise>
									<img src="/resources/images/fileImage.png" width='50' height='50'/>
								</c:otherwise>
							</c:choose>
							<br>
							<span>${BoardFileVo.file_name}</span>
							<a href="/#" class="attach-del" data-fileCode="${BoardFileVo.file_code}">
								<span class="pull-right" style="color:red;">[삭제]</span>
							</a>
						</div>
	            	</c:forEach>
	            </div>
	            <!-- 새로 추가한 파일 -->
	            <div id="choiceFile">
	            </div>
	            <div class="form-group">
	            	<input type="text" class="form-control" name="board_title" placeholder="제목" value="${BoardVo.board_title}">
	            </div>
	            <div class="form-group">
	            	<textarea name="board_content" cols="100" rows="15" placeholder="내용을 입력해주세요.">${BoardVo.board_content }</textarea>
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