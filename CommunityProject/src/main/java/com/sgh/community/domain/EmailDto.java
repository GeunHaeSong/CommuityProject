package com.sgh.community.domain;

public class EmailDto {
	// email을 보낼때 사용되는 Dto
	// 인증번호는 회원가입시 인증 번호 반환 받을때 사용됌.
	private String from = "rtg25689214@gmail.com";
	private String to;
	private String subject;
	private String contents;
	private int authentication_number;
	public EmailDto() {
		super();
	}
	public String getFrom() {
		return from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getAuthentication_number() {
		return authentication_number;
	}
	public void setAuthentication_number(int authentication_number) {
		this.authentication_number = authentication_number;
	}
	@Override
	public String toString() {
		return "EmailDto [from=" + from + ", to=" + to + ", subject=" + subject + ", contents=" + contents
				+ ", authentication_number=" + authentication_number + "]";
	}
}
