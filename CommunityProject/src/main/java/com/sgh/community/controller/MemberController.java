package com.sgh.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/member")
public class MemberController {

	// 로그인 폼
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String boardPageLoginForm() throws Exception {
		return "member/loginForm";
	}
	
	// 로그인 처리
	@RequestMapping(value="/loginRun", method=RequestMethod.POST)
	public String boardPageLoginRun() throws Exception {
		return "member/loginForm";
	}
	
	// 회원가입 폼
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String boardPageJoinForm() throws Exception {
		return "member/joinForm";
	}
	
	// 회원가입 처리
	@RequestMapping(value="/joinRun", method=RequestMethod.POST)
	public String boardPageJoinRun() throws Exception {
		return "member/joinRun";
	}
}
