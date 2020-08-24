package com.sgh.community.domain;

public class PwFindVo {
	// 비밀번호 찾기에 사용되는 Vo
	private String member_id;
	private String member_name;
	private String member_email;
	public PwFindVo() {
		super();
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	@Override
	public String toString() {
		return "PwFindVo [member_id=" + member_id + ", member_name=" + member_name + ", member_email=" + member_email
				+ "]";
	}
}
