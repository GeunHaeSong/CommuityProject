package com.sgh.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {

	// 관리자 메인 화면
	@RequestMapping(value="/adminMainFrom", method=RequestMethod.GET)
	public String adminMainForm() throws Exception {
		
		return "admin/main/adminMainForm";
	}
	
	// 관리자 회원 관리
	@RequestMapping(value="/memberMngForm", method=RequestMethod.GET)
	public String memberMngForm() throws Exception {
		
		return "admin/memberMng/memberMngForm";
	}
	
	// 관리자 게시글 관리
	@RequestMapping(value="/boardMngForm", method=RequestMethod.GET)
	public String boardMngForm() throws Exception {
		
		return "admin/boardMng/boardMngForm";
	}
	
	// 관리자 댓글 관리
	@RequestMapping(value="/commentMngForm", method=RequestMethod.GET)
	public String commentMngForm() throws Exception {
		
		return "admin/commentMng/commentMngForm";
	}
	// 관리자가 쓴 게시글 관리
	@RequestMapping(value="/adminBoardMngForm", method=RequestMethod.GET)
	public String adminBoardMngForm() throws Exception {
		
		return "admin/adminBoardMng/adminBoardMngForm";
	}
	
	// 관리자 재제 폼
	@RequestMapping(value="/sanctionForm", method=RequestMethod.GET)
	public String adminSanctionForm() throws Exception {
		
		return "admin/sanction/adminSanctionForm";
	}
	
	// 관리자 등급 조정 폼
	@RequestMapping(value="/ratingSetForm", method=RequestMethod.GET)
	public String ratingSetForm() throws Exception {
		
		return "admin/ratingSet/ratingSetForm";
	}
	
}
