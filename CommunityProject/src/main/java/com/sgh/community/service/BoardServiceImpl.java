package com.sgh.community.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sgh.community.dao.BoardDao;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.RegistCategory;
import com.sgh.community.domain.RegistVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDao boardDao;
	
	// 글쓰기에 사용할 카테고리 목록 가져오기
	@Override
	public List<RegistCategory> getCategory() throws Exception {
		return boardDao.getCategory();
	}

	// 트랜잭션
	// 게시글 쓰기
	@Transactional
	@Override
	public void insertBoard(RegistVo registVo, String[] boardFile) throws Exception {
		int board_num = boardDao.getLastBoardNum();
		int boardFileSize = boardFile.length;
		for(int i = 0; i < boardFileSize; i++) {
			String image_name = boardFile[i];
			if(i == 0) {
				registVo.setBoard_main_image(image_name);
				// 글쓰기
				boardDao.insertBoard(registVo);
			} else {
				boardDao.insertImage(board_num, image_name);
			}
		}
	}

	// 게시글 가져오기(삭제되지않은거)
	@Override
	public List<BoardVo> getBoardList(PagingDto pagingDto) throws Exception {
		return boardDao.getBoardList(pagingDto);
	}

	// 게시글 총 수 가져오기(삭제되지않은거)
	@Override
	public int getBoardTotalCount() throws Exception {
		return boardDao.getBoardTotalCount();
	}
}
