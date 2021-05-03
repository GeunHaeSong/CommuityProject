/**
 * 
 */

// 페이징 버튼 만들기
function paginationMaker(modalPagingDto, pagination) {
	var startPage = modalPagingDto.startPage;
	var endPage = modalPagingDto.endPage;
	var page = modalPagingDto.page;
	var totalPage = modalPagingDto.totalPage;
	
	var html = "<ul class='pagination'>";
	if(startPage != 1) {
		html += "<li><a href='#' class='page-link pageStart'>&lt;</a></li>";
	}
	for(var i = startPage; i <= endPage; i++) {
		html += "<li class='page-item";
		if(page == i) {
			html += " active";
		}
		html += "'><a href='#' class='page-link pageBtn'>" + i + " </a></li>";
	}
	if(endPage < totalPage) {
		html += "<li><a href='#' class='page-link pageEnd'>&gt;</a></li>";
	}
	html += '</ul>';
	
	$(pagination).append(html);
}