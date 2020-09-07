package com.sgh.community.dao;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardUpDaoImpl implements BoardUpDao {
	
	private final String NAMESPACE = "mappers.board-up-mapper.";
	@Inject
	private SqlSession sqlSession;

	// 게시글의 좋아요 숫자 들고오기
	@Override
	public int selectBoardUpTotal(String board_num) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "selectBoardUpTotal", board_num);
	}

	// 해당 아이디로 해당 게시글에 좋아요 눌렀는지 체크
	@Override
	public int boardUpCheck(Map<String, Object> selectBoardUpMap) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "boardUpCheck", selectBoardUpMap);
	}

	// 좋아요 처음으로 누른 경우
	@Override
	public void firstUp(Map<String, Object> firstUpMap) throws Exception {
		sqlSession.insert(NAMESPACE + "firstUp", firstUpMap);
	}

	// 게시글의 좋아요 + 1
	@Override
	public void boardUpPlus(String board_num) throws Exception {
		sqlSession.update(NAMESPACE + "boardUpPlus", board_num);
	}

	// 좋아요를 다시 누른 경우
	@Override
	public void secondUp(Map<String, Object> secondMap) throws Exception {
		sqlSession.delete(NAMESPACE + "secondUp", secondMap);
	}

	// 게시글의 좋아요 -1
	@Override
	public void boardUpMinus(String board_num) throws Exception {
		sqlSession.update(NAMESPACE + "boardUpMinus", board_num);
	}
}
