package com.sgh.community.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sgh.community.dao.BoardDao;
import com.sgh.community.domain.BoardFileVo;
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
		int board_num = 0;
		int boardFileCount = boardFile.length;
		
		BoardFileVo boardFileVo = new BoardFileVo();
		
		// 게시글 쓸때 파일들 파일 테이블에 insert 하기
		for(int i = 0; i < boardFileCount; i++) {
			String file_name = boardFile[i];
			int fileExtensionIndex = file_name.lastIndexOf(".") + 1;
			String file_extension = file_name.substring(fileExtensionIndex);
			if(i == 0) {
				registVo.setBoard_main_image(file_name);
				// 글쓰기
				boardDao.insertBoard(registVo);
				board_num = boardDao.getLastBoardNum();
			}
			boardFileVo.setBoard_num(board_num);
			boardFileVo.setFile_name(file_name);
			boardFileVo.setFile_extension(file_extension);
			boardDao.insertFile(boardFileVo);
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

	// 선택한 게시글 하나 열기
	@Override
	public BoardVo openOneBoard(String board_num) throws Exception {
		return boardDao.openOneBoard(board_num);
	}

	// 선택한 게시글의 첨부파일 가져오기
	@Override
	public List<BoardFileVo> getOpenBoardFile(String board_num) throws Exception {
		return boardDao.getOpenBoardFile(board_num);
	}

	// 조회수 올리기
	@Override
	public void openBoardViewUp(String board_num) throws Exception {
		boardDao.openBoardViewUp(board_num);
	}

	// 첨부파일 다운로드
	@Override
	public Map<String, Object> fileDown(String file_code) throws Exception {
		return boardDao.fileDown(file_code);
	}
}
