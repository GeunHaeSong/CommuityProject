package com.sgh.community.domain;

public class SuspensionCheckVo {
	private int suspension_no;
	private String suspension_end_date;
	public SuspensionCheckVo() {
		super();
	}
	public int getSuspension_no() {
		return suspension_no;
	}
	public void setSuspension_no(int suspension_no) {
		this.suspension_no = suspension_no;
	}
	public String getSuspension_end_date() {
		return suspension_end_date;
	}
	public void setSuspension_end_date(String suspension_end_date) {
		this.suspension_end_date = suspension_end_date;
	}
	@Override
	public String toString() {
		return "SuspensionCheckVo [suspension_no=" + suspension_no + ", suspension_end_date=" + suspension_end_date
				+ "]";
	}
}
