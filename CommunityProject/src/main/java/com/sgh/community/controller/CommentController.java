package com.sgh.community.controller;

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
	
	@RequestMapping(value="/commentList", method=RequestMethod.GET)
	public List<CommentVo> commentList(String board_num) throws Exception {
		System.out.println("board_num :" + board_num);
		
		List<CommentVo> commentList = commentService.commentList(board_num);
		System.out.println("commentList :" + commentList);
		return commentList;
	}
	
	@RequestMapping(value="/writeComment", method=RequestMethod.POST)
	public String writeComment(@RequestBody Map<String, Object> insertCommentMap, HttpSession session) throws Exception {
		String member_id = (String)session.getAttribute("member_id");
		insertCommentMap.put("member_id", member_id);
		commentService.insertComment(insertCommentMap);
		return "success";
	}
}
