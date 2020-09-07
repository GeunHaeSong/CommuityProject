package com.sgh.community.service;

import java.util.List;
import java.util.Map;

import com.sgh.community.domain.BoardFileVo;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.WriteModifyVo;

public interface BoardService {
	// 게시글 쓸때 보여주는 카테고리 목록 가져오기
	public List<CategoryVo> getCategory() throws Exception;
	// 게시글 글쓰기
	public void insertBoard(WriteModifyVo registVo, String[] boardFile) throws Exception;
	// 게시글 가져오기(삭제되지않은거)
	public List<BoardVo> getBoardList(PagingDto pagingDto) throws Exception;
	// 게시글 전체 수 가져오기(삭제되지않은거)
	public int getBoardTotalCount() throws Exception;
	// 선택한 게시글 하나 열기
	public BoardVo openOneBoard(String board_num) throws Exception;
	// 선택한 게시글의 첨부파일 가져오기
	public List<BoardFileVo> getOpenBoardFile(String board_num) throws Exception;
	// 선택한 게시글 조회수 올리기
	public void openBoardViewUp(String board_num) throws Exception;
	// 첨부파일 다운로드
	public Map<String, Object> fileDown(String file_code) throws Exception;
	// 게시글 수정
	public void updateBoard(WriteModifyVo writeModifyVo, String[] boardFile, String[] delFileCode) throws Exception;
	// 게시글 삭제
	public void deleteBoard(Map<String, Object> deleteBoardMap) throws Exception;
}
