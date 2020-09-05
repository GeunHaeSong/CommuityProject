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

}
