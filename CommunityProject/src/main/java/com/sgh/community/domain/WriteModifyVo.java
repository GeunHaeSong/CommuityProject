package com.sgh.community.domain;

public class WriteModifyVo {
	// 게시글 쓰기 및 수정에 필요한 Vo
	private String category_code;
	private String member_id;
	private String board_title;
	private String board_content;
	private String board_main_image;
	private int board_num;
	public WriteModifyVo() {
		super();
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_main_image() {
		return board_main_image;
	}
	public void setBoard_main_image(String board_main_image) {
		this.board_main_image = board_main_image;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	@Override
	public String toString() {
		return "WriteModifyVo [category_code=" + category_code + ", member_id=" + member_id + ", board_title="
				+ board_title + ", board_content=" + board_content + ", board_main_image=" + board_main_image
				+ ", board_num=" + board_num + "]";
	}
}
