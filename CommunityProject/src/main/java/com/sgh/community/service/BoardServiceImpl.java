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
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.WriteModifyVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDao boardDao;
	
	// 글쓰기에 사용할 카테고리 목록 가져오기
	@Override
	public List<CategoryVo> getCategory() throws Exception {
		return boardDao.getCategory();
	}

	// 트랜잭션
	// 게시글 쓰기
	@Transactional
	@Override
	public void insertBoard(WriteModifyVo writeModifyVo, String[] boardFile) throws Exception {
		BoardFileVo boardFileVo = new BoardFileVo();
		
		// 글쓰기
		if(boardFile != null) {
			String file_name = boardFile[0];
			writeModifyVo.setBoard_main_image(file_name);
		}
		boardDao.insertBoard(writeModifyVo);
		int board_num = boardDao.getLastBoardNum();
		
		// 게시글 쓸때 파일들 파일 테이블에 insert 하기
		if(boardFile != null) {
			for(int i = 0; i < boardFile.length; i++) {
				String file_name = boardFile[i];
				int originalIndex = file_name.lastIndexOf("__") + 2;
				String file_original_name = file_name.substring(originalIndex);
				int fileExtensionIndex = file_name.lastIndexOf(".") + 1;
				String file_extension = file_name.substring(fileExtensionIndex);
				
				boardFileVo.setBoard_num(board_num);
				boardFileVo.setFile_name(file_name);
				boardFileVo.setFile_original_name(file_original_name);
				boardFileVo.setFile_extension(file_extension);
				boardDao.insertFile(boardFileVo);
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

	// 트랜잭션
	// 게시글 수정
	@Transactional
	@Override
	public void updateBoard(WriteModifyVo writeModifyVo, String[] boardFile, String[] delFileCode) throws Exception {
		int board_num = writeModifyVo.getBoard_num();
		
		BoardFileVo boardFileVo = new BoardFileVo();
		
		if(boardFile != null) {
			String file_name = boardFile[0];
			writeModifyVo.setBoard_main_image(file_name);
		}
		System.out.println("writeModifyVo :" + writeModifyVo);
		// 글 수정
		boardDao.updateBoard(writeModifyVo);
		// 게시글 수정할 때 새로 올린 파일들이 있다면 파일 테이블에 insert 하기
		if(boardFile != null) {
			for(int i = 0; i < boardFile.length; i++) {
				String file_name = boardFile[i];
				int originalIndex = file_name.lastIndexOf("__") + 2;
				String file_original_name = file_name.substring(originalIndex);
				int fileExtensionIndex = file_name.lastIndexOf(".") + 1;
				String file_extension = file_name.substring(fileExtensionIndex);
				
				boardFileVo.setBoard_num(board_num);
				boardFileVo.setFile_name(file_name);
				boardFileVo.setFile_original_name(file_original_name);
				boardFileVo.setFile_extension(file_extension);
				boardDao.insertFile(boardFileVo);
			}
		}
		
		// 기존의 파일을 삭제했다면 파일 삭제 처리
		if(delFileCode != null) {
			for(String file_code : delFileCode) {
				boardDao.deleteFile(file_code);
			}
		}
	}

	// 게시글 삭제
	@Override
	public void deleteBoard(Map<String, Object> deleteBoardMap) throws Exception {
		boardDao.deleteBoard(deleteBoardMap);
	}
}
