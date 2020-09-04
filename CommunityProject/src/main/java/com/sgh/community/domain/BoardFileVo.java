package com.sgh.community.domain;

public class BoardFileVo {
	private String file_code;
	private int board_num;
	private String file_name;
	private String file_extension;
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
	public String getFile_extension() {
		return file_extension;
	}
	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}
	@Override
	public String toString() {
		return "BoardFileVo [file_code=" + file_code + ", board_num=" + board_num + ", file_name=" + file_name
				+ ", file_extension=" + file_extension + "]";
	}
}
