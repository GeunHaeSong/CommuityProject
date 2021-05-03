package com.sgh.community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/interceptor")
public class InterceptorController {

	// 어드민 접속 페이지 인터셉터 처리
	@RequestMapping(value="/adminRun", method=RequestMethod.GET)
	public String interceptorRun(HttpSession session, RedirectAttributes rttr) throws Exception {
		String sessionResult = (String)session.getAttribute("interResult");
		rttr.addFlashAttribute("interResult", sessionResult);
		session.removeAttribute("interResult");
		return "redirect:/board/mainView";
	}
	
	// 로그인 관련 인터셉터 처리
	@RequestMapping(value="/loginInterceptor", method=RequestMethod.GET)
	public String loginInterceptor(HttpSession session, RedirectAttributes rttr) throws Exception {
		String sessionResult = (String)session.getAttribute("sessionResult");
		rttr.addFlashAttribute("sessionResult", sessionResult);
		session.removeAttribute("sessionResult");
		return "redirect:/member/loginForm";
	}
	
	// 멤버 관련 인터셉터 처리
}
