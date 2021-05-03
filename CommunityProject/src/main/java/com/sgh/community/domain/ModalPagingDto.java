package com.sgh.community.domain;

import java.util.List;

public class ModalPagingDto {
	// 모달에 페이징 작업할때 사용할 Dto
	private int page = 1;
	private int perPage = 5; // 한 페이지당 보여질 글의 갯수
	private int startRow = 1;
	private int endRow = 10;
	private int totalCount; // 전체 게시글 수
	private int totalPage; // 전체 페이지 수
	private int startPage; // 페이지 블럭에서 시작 페이지
	private int endPage; // 페이지 블럭에서 끝 페이지
	private final int PAGE_BLOCK = 10; // 페이지 블럭 수
	// 게시글과 댓글을 저장할 리스트, 한번에 반환하기 위해
	private List<BoardVo> boardList;
	private List<CommentVo> commentList;
	private List<SuspensionVo> suspensionList;
	
	public void setPageInfo() {
		this.endRow = page * perPage;
		this.startRow = this.endRow - this.perPage + 1;
		this.endPage = (int) (Math.ceil((double)page / PAGE_BLOCK) * PAGE_BLOCK);
		this.startPage = this.endPage - PAGE_BLOCK + 1;
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
	public int getTotalCount() {
		return totalCount;
	}
	// totalCount를 구할때 totalPage 계산하기
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		this.totalPage = (int) Math.ceil((double)totalCount / perPage);
		if(endPage > totalPage) {
			endPage = totalPage;
		}
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
	public List<BoardVo> getBoardList() {
		return boardList;
	}
	public void setBoardList(List<BoardVo> boardList) {
		this.boardList = boardList;
	}
	public int getPAGE_BLOCK() {
		return PAGE_BLOCK;
	}
	public List<CommentVo> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<CommentVo> commentList) {
		this.commentList = commentList;
	}
	public List<SuspensionVo> getSuspensionList() {
		return suspensionList;
	}
	public void setSuspensionList(List<SuspensionVo> suspensionList) {
		this.suspensionList = suspensionList;
	}
	@Override
	public String toString() {
		return "ModalPagingDto [page=" + page + ", perPage=" + perPage + ", startRow=" + startRow + ", endRow=" + endRow
				+ ", totalCount=" + totalCount + ", totalPage=" + totalPage + ", startPage=" + startPage + ", endPage="
				+ endPage + ", PAGE_BLOCK=" + PAGE_BLOCK + ", boardList=" + boardList + ", commentList=" + commentList
				+ ", suspensionList=" + suspensionList + "]";
	}
}
