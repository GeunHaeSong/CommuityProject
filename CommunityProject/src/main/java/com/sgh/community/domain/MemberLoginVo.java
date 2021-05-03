package com.sgh.community.domain;

public class MemberLoginVo {
	// 로그인 과정에서 사용되는 Vo
	private String member_id;
	private String member_pw;
	private String member_state;
	public MemberLoginVo() {
		super();
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_state() {
		return member_state;
	}
	public void setMember_state(String member_state) {
		this.member_state = member_state;
	}
	@Override
	public String toString() {
		return "MemberLoginVo [member_id=" + member_id + ", member_pw=" + member_pw + ", member_state=" + member_state
				+ "]";
	}
}
