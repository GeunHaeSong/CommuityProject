package com.sgh.community.domain;

public class ChartDto {
	private String chart_date;
	private int board_num;
	private int member_num;
	public ChartDto() {
		super();
	}
	public String getChart_date() {
		return chart_date;
	}
	public void setChart_date(String chart_date) {
		this.chart_date = chart_date;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	@Override
	public String toString() {
		return "ChartDto [chart_date=" + chart_date + ", board_num=" + board_num + ", member_num=" + member_num + "]";
	}
}
