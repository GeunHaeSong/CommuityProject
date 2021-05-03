package com.sgh.community.domain;

import java.sql.Timestamp;

public class CommentVo {
	private int comment_num;
	private int board_num;
	private String member_id;
	private String comment_content;
	private Timestamp comment_reg_t;
	private Timestamp comment_modi_t;
	private Timestamp comment_delete_t;
	private String comment_state;
	// 댓글 불러오기 할 때 board가 삭제되있는지 아닌지 상태 확인 하기 위한 변수
	private String board_state;
	// 카테고리 이름을 표시하기 위해 추가
	private String category_name;
	public CommentVo() {
		super();
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public Timestamp getComment_reg_t() {
		return comment_reg_t;
	}
	public void setComment_reg_t(Timestamp comment_reg_t) {
		this.comment_reg_t = comment_reg_t;
	}
	public Timestamp getComment_modi_t() {
		return comment_modi_t;
	}
	public void setComment_modi_t(Timestamp comment_modi_t) {
		this.comment_modi_t = comment_modi_t;
	}
	public Timestamp getComment_delete_t() {
		return comment_delete_t;
	}
	public void setComment_delete_t(Timestamp comment_delete_t) {
		this.comment_delete_t = comment_delete_t;
	}
	public String getComment_state() {
		return comment_state;
	}
	public void setComment_state(String comment_state) {
		this.comment_state = comment_state;
	}
	public String getBoard_state() {
		return board_state;
	}
	public void setBoard_state(String board_state) {
		this.board_state = board_state;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	@Override
	public String toString() {
		return "CommentVo [comment_num=" + comment_num + ", board_num=" + board_num + ", member_id=" + member_id
				+ ", comment_content=" + comment_content + ", comment_reg_t=" + comment_reg_t + ", comment_modi_t="
				+ comment_modi_t + ", comment_delete_t=" + comment_delete_t + ", comment_state=" + comment_state
				+ ", board_state=" + board_state + ", category_name=" + category_name + "]";
	}
}
