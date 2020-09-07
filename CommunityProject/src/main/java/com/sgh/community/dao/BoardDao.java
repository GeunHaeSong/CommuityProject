package com.sgh.community.dao;

import java.util.List;
import java.util.Map;

import com.sgh.community.domain.BoardFileVo;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.WriteModifyVo;

public interface BoardDao {
	// 게시글 쓸때 보여주는 카테고리 목록 가져오기
	public List<CategoryVo> getCategory() throws Exception;
	// 게시글 글쓰기
	public void insertBoard(WriteModifyVo registVo) throws Exception;
	// 파일 업로드(트랜잭션)
	public void insertFile(BoardFileVo boardFileVo) throws Exception;
	// 가장 최근 게시글 번호 가져오기(이미지 업로드에서 사용할 board_num)(트랜잭션)
	public int getLastBoardNum() throws Exception;
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
	// 첨부파일 다운로드 횟수 + 1 (ajax 처리 해야하기 때문에 나중에 추가)
	public void downPlusFile(Map<String, Object> downPlusFileMap) throws Exception;
	// 첨부파일 삭제(수정할 때 트랜잭션 처리)
	public void deleteFile(String file_code) throws Exception;
	// 게시글 수정
	public void updateBoard(WriteModifyVo writeModifyVo) throws Exception;
	// 게시글 삭제
	public void deleteBoard(Map<String, Object> deleteBoardMap) throws Exception;
}
