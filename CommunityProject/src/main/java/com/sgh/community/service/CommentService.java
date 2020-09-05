package com.sgh.community.service;

import java.util.List;
import java.util.Map;

import com.sgh.community.domain.CommentVo;

public interface CommentService {
	// 해당 게시글의 댓글 목록 가져오기
	public List<CommentVo> commentList(String board_num) throws Exception;
	// 해당 게시글에 댓글 작성하기
	public void insertComment(Map<String, Object> insertCommentMap) throws Exception;
}
