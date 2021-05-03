package com.sgh.community.domain;

import java.sql.Timestamp;

public class MemberVo {
	// 회원의 정보가 담기는 Vo
	private String member_id;
	private String member_pw;
	private String member_nickname;
	private String member_email;
	private String member_birthday;
	private String member_phone_number;
	private String member_address;
	private String member_state;
	private String member_name;
	private Timestamp member_regdate;
	private Timestamp member_wthdr_date;
	private Timestamp member_login_date;
	
	public MemberVo() {
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
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_birthday() {
		return member_birthday;
	}
	public void setMember_birthday(String member_birthday) {
		this.member_birthday = member_birthday;
	}
	public String getMember_phone_number() {
		return member_phone_number;
	}
	public void setMember_phone_number(String member_phone_number) {
		this.member_phone_number = member_phone_number;
	}
	public String getMember_address() {
		return member_address;
	}
	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}
	public String getMember_state() {
		return member_state;
	}
	public void setMember_state(String member_state) {
		this.member_state = member_state;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public Timestamp getMember_regdate() {
		return member_regdate;
	}
	public void setMember_regdate(Timestamp member_regdate) {
		this.member_regdate = member_regdate;
	}
	public Timestamp getMember_wthdr_date() {
		return member_wthdr_date;
	}
	public void setMember_wthdr_date(Timestamp member_wthdr_date) {
		this.member_wthdr_date = member_wthdr_date;
	}
	public Timestamp getMember_login_date() {
		return member_login_date;
	}
	public void setMember_login_date(Timestamp member_login_date) {
		this.member_login_date = member_login_date;
	}
	@Override
	public String toString() {
		return "MemberVo [member_id=" + member_id + ", member_pw=" + member_pw + ", member_nickname=" + member_nickname
				+ ", member_email=" + member_email + ", member_birthday=" + member_birthday + ", member_phone_number="
				+ member_phone_number + ", member_address=" + member_address + ", member_state=" + member_state
				+ ", member_name=" + member_name + ", member_regdate=" + member_regdate + ", member_wthdr_date="
				+ member_wthdr_date + ", member_login_date=" + member_login_date + "]";
	}
}
