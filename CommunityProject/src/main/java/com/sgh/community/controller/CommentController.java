package com.sgh.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.sgh.community.domain.CommentVo;
import com.sgh.community.service.CommentService;

@RestController
@RequestMapping(value="/comment")
public class CommentController {
	// 댓글 관련 작업
	// 모두 ajax로 처리하기 때문에 RestController 사용
	
	@Inject
	private CommentService commentService;
	
	// 해당 게시글의 댓글 목록 가져오기
	@RequestMapping(value="/commentList", method=RequestMethod.GET)
	public List<CommentVo> commentList(String board_num) throws Exception {
		List<CommentVo> commentList = commentService.commentList(board_num);
		return commentList;
	}
	
	// 해당 게시글의 댓글 전체 수 가져오기
	@RequestMapping(value="/totalComment", method=RequestMethod.GET)
	public int totalComment(String board_num) throws Exception {
		return commentService.totalComment(board_num);
	}
	
	// 댓글 작성
	@RequestMapping(value="/writeComment", method=RequestMethod.POST)
	public String writeComment(@RequestBody Map<String, Object> insertCommentMap, HttpSession session) throws Exception {
		String member_id = (String)session.getAttribute("member_id");
		insertCommentMap.put("member_id", member_id);
		commentService.insertComment(insertCommentMap);
		return "success";
	}
	
	// 댓글 수정
	@RequestMapping(value="/modifyComment", method=RequestMethod.PUT)
	public String modifyComment(@RequestBody Map<String, Object> modifyCommentMap, HttpSession session) {
		// 로그인을 하지 않았을 경우
		try {
			String member_id = (String)session.getAttribute("member_id");
			modifyCommentMap.put("member_id", member_id);
			commentService.modifyComment(modifyCommentMap);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}
	
	// 댓글 삭제
	@RequestMapping(value="/deleteComment", method=RequestMethod.GET)
	public String deleteComment(String comment_num, String board_num, HttpSession session) {
		// 로그인을 하지 않았을 경우
		try {
			String member_id = (String)session.getAttribute("member_id");
			Map<String, Object> deleteCommentMap = new HashMap<String, Object>();
			deleteCommentMap.put("comment_num", comment_num);
			deleteCommentMap.put("member_id", member_id);
			deleteCommentMap.put("board_num", board_num);
			commentService.deleteComment(deleteCommentMap);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}
}
