package com.sgh.community.domain;

import java.sql.Timestamp;

public class SuspensionVo {
	private String suspension_no;
	private String member_id;
	private String suspension_reason;
	private Timestamp suspension_start_date;
	private Timestamp suspension_end_date;
	private String suspension_state;
	public SuspensionVo() {
		super();
	}
	public String getSuspension_no() {
		return suspension_no;
	}
	public void setSuspension_no(String suspension_no) {
		this.suspension_no = suspension_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getSuspension_reason() {
		return suspension_reason;
	}
	public void setSuspension_reason(String suspension_reason) {
		this.suspension_reason = suspension_reason;
	}
	public Timestamp getSuspension_start_date() {
		return suspension_start_date;
	}
	public void setSuspension_start_date(Timestamp suspension_start_date) {
		this.suspension_start_date = suspension_start_date;
	}
	public Timestamp getSuspension_end_date() {
		return suspension_end_date;
	}
	public void setSuspension_end_date(Timestamp suspension_end_date) {
		this.suspension_end_date = suspension_end_date;
	}
	public String getSuspension_state() {
		return suspension_state;
	}
	public void setSuspension_state(String suspension_state) {
		this.suspension_state = suspension_state;
	}
	@Override
	public String toString() {
		return "SuspensionVo [suspension_no=" + suspension_no + ", member_id=" + member_id + ", suspension_reason="
				+ suspension_reason + ", suspension_start_date=" + suspension_start_date + ", suspension_end_date="
				+ suspension_end_date + ", suspension_state=" + suspension_state + "]";
	}
}
