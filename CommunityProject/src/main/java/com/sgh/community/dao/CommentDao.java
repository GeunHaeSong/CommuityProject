package com.sgh.community.dao;

import java.util.List;
import java.util.Map;

import com.sgh.community.domain.CommentVo;

public interface CommentDao {
	// 해당 게시글의 댓글 목록 가져오기
	public List<CommentVo> commentList(String board_num) throws Exception;
	// 해당 게시글에 댓글 작성하기
	public void insertComment(Map<String, Object> insertCommentMap) throws Exception;
	// 해당 게시글의 댓글 수 증가 시키기
	public void updateCommentCount(String board_num) throws Exception;
}
