package com.sgh.community.domain;

public class RegistCategory {
	// 글쓰기에서 보여주는 카테고리 메뉴 목록 가져오기
	private String category_code;
	private String category_name;
	public RegistCategory() {
		super();
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	@Override
	public String toString() {
		return "RegistCategory [category_code=" + category_code + ", category_name=" + category_name + "]";
	}
}
