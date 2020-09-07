package com.sgh.community.domain;

public class BoardUpVo {
	// 게시글 좋아요 Vo
	private String board_up_no;
	private String board_num;
	private String member_id;
	private String up_date;
	public BoardUpVo() {
		super();
	}
	public String getBoard_up_no() {
		return board_up_no;
	}
	public void setBoard_up_no(String board_up_no) {
		this.board_up_no = board_up_no;
	}
	public String getBoard_num() {
		return board_num;
	}
	public void setBoard_num(String board_num) {
		this.board_num = board_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getUp_date() {
		return up_date;
	}
	public void setUp_date(String up_date) {
		this.up_date = up_date;
	}
	@Override
	public String toString() {
		return "BoardUpVo [board_up_no=" + board_up_no + ", board_num=" + board_num + ", member_id=" + member_id
				+ ", up_date=" + up_date + "]";
	}
}
