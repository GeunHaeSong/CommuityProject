package com.sgh.community.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sgh.community.domain.BoardFileVo;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.WriteModifyVo;

@Repository
public class BoardDaoImpl implements BoardDao {

	private final String NAMESPACE = "mappers.board-mapper.";
	@Inject
	private SqlSession sqlSession;
	
	// 글쓸때 보여주는 카테고리 목록 가져오기
	@Override
	public List<CategoryVo> getCategory() throws Exception {
		return sqlSession.selectList(NAMESPACE + "getCategory");
	}

	// 게시글 쓰기
	@Override
	public void insertBoard(WriteModifyVo registVo) throws Exception {
		sqlSession.insert(NAMESPACE + "insertBoard", registVo);
	}

	// 이미지 업로드
	@Override
	public void insertFile(BoardFileVo boardFileVo) throws Exception {
		sqlSession.insert(NAMESPACE + "insertFile", boardFileVo);
	}

	// 가장 최근에 쓴 게시글 번호 들고오기(이미지 업로드에서 사용할 board_num)
	@Override
	public int getLastBoardNum() throws Exception {
		return sqlSession.selectOne(NAMESPACE + "getLastBoardNum");
	}

	// 게시글 가져오기(삭제X)
	@Override
	public List<BoardVo> getBoardList(PagingDto pagingDto) throws Exception {
		return sqlSession.selectList(NAMESPACE + "getBoardList", pagingDto);
	}

	// 전체 글 가져오기(삭제X)
	@Override
	public List<BoardVo> getBoardListAll(PagingDto pagingDto) throws Exception {
		return sqlSession.selectList(NAMESPACE + "getBoardListAll", pagingDto);
	}

	// 카테고리 별 게시글 수 가져오기(삭제X)
	@Override
	public int getCategoryBoardTotalCount(PagingDto pagingDto) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "getCategoryBoardTotalCount", pagingDto);
	}
	
	// 전체 게시글 수 가져오기(삭제X)
	@Override
	public int getBoardAllCount(PagingDto pagingDto) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "getBoardAllCount", pagingDto);
	}
	
	// 선택한 게시글 하나 열기
	@Override
	public BoardVo openOneBoard(String board_num) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "openOneBoard", board_num);
	}

	// 선택한 게시글에 있는 첨부파일 가져오기
	@Override
	public List<BoardFileVo> getOpenBoardFile(String board_num) throws Exception {
		return sqlSession.selectList(NAMESPACE + "getOpenBoardFile", board_num);
	}

	// 조회수 올리기
	@Override
	public void openBoardViewUp(String board_num) throws Exception {
		sqlSession.update(NAMESPACE + "openBoardViewUp", board_num);
	}

	// 첨부파일 다운로드
	@Override
	public Map<String, Object> fileDown(String file_code) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "fileDown", file_code);
	}

	// 첨부파일 다운로드 횟수 증가
	@Override
	public void downPlusFile(String file_code) throws Exception {
		sqlSession.update(NAMESPACE + "downPlusFile", file_code);
	}

	// 첨부파일 삭제
	@Override
	public void deleteFile(String file_code) throws Exception {
		sqlSession.update(NAMESPACE + "deleteFile", file_code);
	}

	// 게시글 수정
	@Override
	public void updateBoard(WriteModifyVo writeModifyVo) throws Exception {
		sqlSession.update(NAMESPACE + "updateBoard", writeModifyVo);
	}

	// 게시글 삭제
	@Override
	public void deleteBoard(Map<String, Object> deleteBoardMap) throws Exception {
		sqlSession.update(NAMESPACE + "deleteBoard", deleteBoardMap);
	}
}
