package com.sgh.community.domain;

public class PagingDto {
	// Paging 작업할때 사용할 Dto
	// 검색 기능과 카테고리 별 게시판 구분을 위해 category_code, keyword 사용
	private int page = 1;
	private int perPage = 3; // 한 페이지당 보여질 글의 갯수
	private int startRow = 1;
	private int endRow = 10;
	private int totalCount; // 전체 게시글 수
	private int totalPage; // 전체 페이지 수
	private int startPage; // 페이지 블럭에서 시작 페이지
	private int endPage; // 페이지 블럭에서 끝 페이지
	private final int PAGE_BLOCK = 10; // 페이지 블럭 수
	// 검색에 필요한 데이터
	private String keyword = "";
	private String category_code = "";
	private String keywordType = "";
	private String selectCategory = "";
	private String categoryType = "";
	// 어드민 검색에 필요한 데이터
	private String stateType = "";
	
	public void setPageInfo() {
		this.endRow = page * perPage;
		this.startRow = this.endRow - this.perPage + 1;
		this.endPage = (int) (Math.ceil((double)page / PAGE_BLOCK) * PAGE_BLOCK);
		this.startPage = this.endPage - PAGE_BLOCK + 1;
		this.totalPage = (int) Math.ceil((double)totalCount / perPage);
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getKeywordType() {
		return keywordType;
	}
	public void setKeywordType(String keywordType) {
		this.keywordType = keywordType;
	}
	public String getSelectCategory() {
		return selectCategory;
	}
	public void setSelectCategory(String selectCategory) {
		this.selectCategory = selectCategory;
	}
	public String getCategoryType() {
		return categoryType;
	}
	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getStateType() {
		return stateType;
	}
	public void setStateType(String stateType) {
		this.stateType = stateType;
	}
	public int getTotalCount() {
		return totalCount;
	}
	// totalCount를 구할때 totalPage 계산하기
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	@Override
	public String toString() {
		return "PagingDto [page=" + page + ", perPage=" + perPage + ", startRow=" + startRow + ", endRow=" + endRow
				+ ", totalCount=" + totalCount + ", totalPage=" + totalPage + ", startPage=" + startPage + ", endPage="
				+ endPage + ", PAGE_BLOCK=" + PAGE_BLOCK + ", keyword=" + keyword + ", category_code=" + category_code
				+ ", keywordType=" + keywordType + ", selectCategory=" + selectCategory + ", categoryType="
				+ categoryType + ", stateType=" + stateType + "]";
	}
}
