package com.sgh.community.domain;

public class MemberMngVo {
	private String member_id;
	private String member_nickname;
	private String member_state;
	private int board_num;
	private int comment_num;
	private String suspension;
	
	public MemberMngVo() {
		super();
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMember_state() {
		return member_state;
	}
	public void setMember_state(String member_state) {
		this.member_state = member_state;
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
	public String getSuspension() {
		return suspension;
	}
	public void setSuspension(String suspension) {
		this.suspension = suspension;
	}
	@Override
	public String toString() {
		return "MemberMngVo [member_id=" + member_id + ", member_nickname=" + member_nickname + ", member_state="
				+ member_state + ", board_num=" + board_num + ", comment_num=" + comment_num + ", suspension="
				+ suspension + "]";
	}
}
