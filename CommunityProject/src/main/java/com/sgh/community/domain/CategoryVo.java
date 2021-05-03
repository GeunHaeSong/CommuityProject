package com.sgh.community.domain;

public class CategoryVo {
	// 글쓰기에서 보여주는 카테고리 메뉴 목록 가져오기
	private String category_code;
	private String category_name;
	private String category_state;
	private String category_reg_t;
	private String category_delete_t;
	private String category_access;
	private String category_order;
	// 게시글과 댓글 수 확인해야할 때 쓸 변수
	private int board_num;
	private int comment_num;
	public CategoryVo() {
		super();
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getCategory_state() {
		return category_state;
	}
	public void setCategory_state(String category_state) {
		this.category_state = category_state;
	}
	public String getCategory_reg_t() {
		return category_reg_t;
	}
	public void setCategory_reg_t(String category_reg_t) {
		this.category_reg_t = category_reg_t;
	}
	public String getCategory_delete_t() {
		return category_delete_t;
	}
	public void setCategory_delete_t(String category_delete_t) {
		this.category_delete_t = category_delete_t;
	}
	public String getCategory_access() {
		return category_access;
	}
	public void setCategory_access(String category_access) {
		this.category_access = category_access;
	}
	public String getCategory_order() {
		return category_order;
	}
	public void setCategory_order(String category_order) {
		this.category_order = category_order;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	@Override
	public String toString() {
		return "CategoryVo [category_code=" + category_code + ", category_name=" + category_name + ", category_state="
				+ category_state + ", category_reg_t=" + category_reg_t + ", category_delete_t=" + category_delete_t
				+ ", category_access=" + category_access + ", category_order=" + category_order + ", board_num="
				+ board_num + ", comment_num=" + comment_num + "]";
	}
}
