package com.sgh.community.domain;

import java.sql.Timestamp;

public class BoardFileVo {
	private String file_code;
	private int board_num;
	private String file_name;
	private String file_original_name;
	private Timestamp file_reg_t;
	private int file_down_count;
	private String file_extension;
	private String file_state;
	private Timestamp file_del_t;
	public BoardFileVo() {
		super();
	}
	public String getFile_code() {
		return file_code;
	}
	public void setFile_code(String file_code) {
		this.file_code = file_code;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_original_name() {
		return file_original_name;
	}
	public void setFile_original_name(String file_original_name) {
		this.file_original_name = file_original_name;
	}
	public Timestamp getFile_reg_t() {
		return file_reg_t;
	}
	public void setFile_reg_t(Timestamp file_reg_t) {
		this.file_reg_t = file_reg_t;
	}
	public int getFile_down_count() {
		return file_down_count;
	}
	public void setFile_down_count(int file_down_count) {
		this.file_down_count = file_down_count;
	}
	public String getFile_extension() {
		return file_extension;
	}
	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}
	public String getFile_state() {
		return file_state;
	}
	public void setFile_state(String file_state) {
		this.file_state = file_state;
	}
	public Timestamp getFile_del_t() {
		return file_del_t;
	}
	public void setFile_del_t(Timestamp file_del_t) {
		this.file_del_t = file_del_t;
	}
	@Override
	public String toString() {
		return "BoardFileVo [file_code=" + file_code + ", board_num=" + board_num + ", file_name=" + file_name
				+ ", file_original_name=" + file_original_name + ", file_reg_t=" + file_reg_t + ", file_down_count="
				+ file_down_count + ", file_extension=" + file_extension + ", file_state=" + file_state
				+ ", file_del_t=" + file_del_t + "]";
	}
}
