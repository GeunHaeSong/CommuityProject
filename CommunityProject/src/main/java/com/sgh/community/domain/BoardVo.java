package com.sgh.community.domain;

import java.sql.Timestamp;

public class BoardVo {
	private int board_num;
	private String category_code;
	private String member_id;
	private String board_title;
	private String board_content;
	private Timestamp board_reg_t;
	private Timestamp board_modi_t;
	private Timestamp board_delete_t;
	private int board_view;
	private int board_up;
	private String board_state;
	private String board_main_image;
	public BoardVo() {
		super();
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
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
	public Timestamp getBoard_reg_t() {
		return board_reg_t;
	}
	public void setBoard_reg_t(Timestamp board_reg_t) {
		this.board_reg_t = board_reg_t;
	}
	public Timestamp getBoard_modi_t() {
		return board_modi_t;
	}
	public void setBoard_modi_t(Timestamp board_modi_t) {
		this.board_modi_t = board_modi_t;
	}
	public Timestamp getBoard_delete_t() {
		return board_delete_t;
	}
	public void setBoard_delete_t(Timestamp board_delete_t) {
		this.board_delete_t = board_delete_t;
	}
	public int getBoard_view() {
		return board_view;
	}
	public void setBoard_view(int board_view) {
		this.board_view = board_view;
	}
	public int getBoard_up() {
		return board_up;
	}
	public void setBoard_up(int board_up) {
		this.board_up = board_up;
	}
	public String getBoard_state() {
		return board_state;
	}
	public void setBoard_state(String board_state) {
		this.board_state = board_state;
	}
	public String getBoard_main_image() {
		return board_main_image;
	}
	public void setBoard_main_image(String board_main_image) {
		this.board_main_image = board_main_image;
	}
	@Override
	public String toString() {
		return "BoardVo [board_num=" + board_num + ", category_code=" + category_code + ", member_id=" + member_id
				+ ", board_title=" + board_title + ", board_content=" + board_content + ", board_reg_t=" + board_reg_t
				+ ", board_modi_t=" + board_modi_t + ", board_delete_t=" + board_delete_t + ", board_view=" + board_view
				+ ", board_up=" + board_up + ", board_state=" + board_state + ", board_main_image=" + board_main_image
				+ "]";
	}
}
