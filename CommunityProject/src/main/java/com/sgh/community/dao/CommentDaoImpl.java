package com.sgh.community.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sgh.community.domain.CommentVo;

@Repository
public class CommentDaoImpl implements CommentDao {

	private final String NAMESPACE = "mappers.comment-mapper.";
	@Inject
	private SqlSession sqlSession;
	
	// 댓글 목록 가져오기
	@Override
	public List<CommentVo> commentList(String board_num) throws Exception {
		return sqlSession.selectList(NAMESPACE + "commentList", board_num);
	}

	// 댓글 작성하기
	@Override
	public void insertComment(Map<String, Object> insertCommentMap) throws Exception {
		sqlSession.insert(NAMESPACE + "insertComment", insertCommentMap);
	}

	// 댓글 수 증가시키기
	@Override
	public void updateCommentCount(String board_num) throws Exception {
		sqlSession.update(NAMESPACE + "updateCommentCount", board_num);
	}

	// 댓글 삭제
	@Override
	public void deleteComment(Map<String, Object> deleteCommentMap) throws Exception {
		sqlSession.update(NAMESPACE + "deleteComment", deleteCommentMap);
	}

	// 댓글 수정
	@Override
	public void modifyComment(Map<String, Object> modifyCommentMap) throws Exception {
		sqlSession.update(NAMESPACE + "modifyComment", modifyCommentMap);
	}

	// 댓글 수 감소
	@Override
	public void deleteCommentCount(String board_num) throws Exception {
		sqlSession.update(NAMESPACE + "deleteCommentCount", board_num);
	}

	// 해당 게시글의 댓글 수 가져오기
	@Override
	public int totalComment(String board_num) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "totalComment", board_num);
	}

}
