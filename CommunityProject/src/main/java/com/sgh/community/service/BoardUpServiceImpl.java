package com.sgh.community.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sgh.community.dao.BoardUpDao;

@Service
public class BoardUpServiceImpl implements BoardUpService {

	@Inject
	private BoardUpDao boardUpDao;
	
	// 게시글의 좋아요 수 가져오기
	@Override
	public int selectBoardUpTotal(String board_num) throws Exception {
		return boardUpDao.selectBoardUpTotal(board_num);
	}
	
	// 좋아요 눌렀는지 체크
	@Override
	public int boardUpCheck(Map<String, Object> selectBoardUpMap) throws Exception {
		return boardUpDao.boardUpCheck(selectBoardUpMap);
	}

	// 트랜잭션
	// 좋아요 처음으로 누른 경우, 좋아요 추가하고 게시글의 좋아요 수 + 1
	@Transactional
	@Override
	public void firstUp(Map<String, Object> firstUpMap) throws Exception {
		String board_num = (String)firstUpMap.get("board_num");
		boardUpDao.firstUp(firstUpMap);
		boardUpDao.boardUpPlus(board_num);
	}

	// 트랜잭션
	// 다시 좋아요 누른 경우, 좋아요 삭제하고 게시글의 좋아요 수 - 1
	@Transactional
	@Override
	public void secondUp(Map<String, Object> secondMap) throws Exception {
		String board_num = (String)secondMap.get("board_num");
		boardUpDao.secondUp(secondMap);
		boardUpDao.boardUpMinus(board_num);
	}
}
