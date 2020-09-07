package com.sgh.community.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sgh.community.dao.CommentDao;
import com.sgh.community.domain.CommentVo;

@Service
public class CommentServiceImpl implements CommentService {

	@Inject
	private CommentDao commentDao;
	
	// 댓글 목록 가져오기
	@Override
	public List<CommentVo> commentList(String board_num) throws Exception {
		return commentDao.commentList(board_num);
	}

	// 트랜잭션
	// 댓글이 작성되면 댓글을 작성시키고, 게시글의 댓글 수 증가시키기
	@Transactional
	@Override
	public void insertComment(Map<String, Object> insertCommentMap) throws Exception {
		String board_num = (String)insertCommentMap.get("board_num");
		commentDao.insertComment(insertCommentMap);
		commentDao.updateCommentCount(board_num);
	}

	// 트랜잭션
	// 댓글이 삭제되면 댓글 삭제시키고, 게시글의 댓글 수 감소
	@Transactional
	@Override
	public void deleteComment(Map<String, Object> deleteCommentMap) throws Exception {
		String board_num = (String)deleteCommentMap.get("board_num");
		commentDao.deleteComment(deleteCommentMap);
		commentDao.deleteCommentCount(board_num);
	}

	// 댓글 수정
	@Override
	public void modifyComment(Map<String, Object> modifyCommentMap) throws Exception {
		commentDao.modifyComment(modifyCommentMap);
	}

	@Override
	public int totalComment(String board_num) throws Exception {
		return commentDao.totalComment(board_num);
	}
}
