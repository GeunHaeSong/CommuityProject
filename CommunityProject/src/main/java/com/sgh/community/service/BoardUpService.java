package com.sgh.community.service;

import java.util.Map;

public interface BoardUpService {
	// 게시글 좋아요 숫자 들고오기
	public int selectBoardUpTotal(String board_num) throws Exception;
	// 게시글 좋아요 숫자 들고오기
	public int boardUpCheck(Map<String, Object> selectBoardUpMap) throws Exception;
	// 게시글 좋아요 처음 눌렀을 경우
	public void firstUp(Map<String, Object> firstUpMap) throws Exception;
	// 게시글 좋아요 다시 눌렀을 경우
	public void secondUp(Map<String, Object> secondMap) throws Exception;
}
