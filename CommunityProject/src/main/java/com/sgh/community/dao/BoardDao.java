package com.sgh.community.dao;

import java.util.List;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.RegistCategory;
import com.sgh.community.domain.RegistVo;

public interface BoardDao {
	// 게시글 쓸때 보여주는 카테고리 목록 가져오기
	public List<RegistCategory> getCategory() throws Exception;
	// 게시글 글쓰기
	public void insertBoard(RegistVo registVo) throws Exception;
	// 이미지 업로드(트랜잭션)
	public void insertImage(int board_num, String image_name) throws Exception;
	// 가장 최근 게시글 번호 가져오기(이미지 업로드에서 사용할 board_num)(트랜잭션)
	public int getLastBoardNum() throws Exception;
	// 게시글 가져오기(삭제되지않은거)
	public List<BoardVo> getBoardList(PagingDto pagingDto) throws Exception;
	// 게시글 전체 수 가져오기(삭제되지않은거)
	public int getBoardTotalCount() throws Exception;
}
