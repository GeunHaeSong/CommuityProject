package com.sgh.community.domain;

public class MemberLoginVo {
	// 로그인 과정에서 사용되는 Vo
	private String member_id;
	private String member_state;
	private String rating_name;
	public MemberLoginVo() {
		super();
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_state() {
		return member_state;
	}
	public void setMember_state(String member_state) {
		this.member_state = member_state;
	}
	public String getRating_name() {
		return rating_name;
	}
	public void setRating_name(String rating_name) {
		this.rating_name = rating_name;
	}
	@Override
	public String toString() {
		return "MemberLoginVo [member_id=" + member_id + ", member_state=" + member_state + ", rating_name="
				+ rating_name + "]";
	}
	
}
