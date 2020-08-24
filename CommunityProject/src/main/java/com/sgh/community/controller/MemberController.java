package com.sgh.community.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sgh.community.domain.EmailDto;
import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.service.MemberService;
import com.sgh.community.util.EmailUtil;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;
	// 메일 보낼때 사용할 mailSender
	@Inject
	private JavaMailSender mailSender;
	
	// 로그인 폼
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String boardPageLoginForm() throws Exception {
		return "member/loginForm";
	}
	
	// 로그인 처리(
	@RequestMapping(value="/loginRun", method=RequestMethod.POST)
	public String boardPageLoginRun(String member_id, String member_pw, HttpSession session, RedirectAttributes rttr) {
		try {
			MemberLoginVo memberLoginVo = memberService.selectMember(member_id, member_pw);
			String member_state = memberLoginVo.getMember_state();
			String rating_name = memberLoginVo.getRating_name();
			session.setAttribute("member_id", member_id);
			session.setAttribute("member_state", member_state);
			session.setAttribute("rating_name", rating_name);
			return "redirect:/boardPage/mainView";
		} catch(Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("loginResult", "false");
		return "redirect:/member/loginForm";
	}
	
	// 로그아웃 처리(저장된 세션 전부 삭제)
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String boardPageLogoutRun(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/member/loginForm";
	}
	
	// 회원가입 폼
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String boardPageJoinForm() throws Exception {
		return "member/joinForm";
	}
	
	// 회원가입 처리
	@RequestMapping(value="/joinRun", method=RequestMethod.POST)
	public String boardPageJoinRun(MemberVo memberVo, RedirectAttributes rttr) {
		try {
			memberService.insertMember(memberVo);
			return "redirect:/member/loginForm";
		} catch(Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("false", "result");
		return "redirect:/member/joinForm";
	}
	
	// 아이디 중복 체크 에이잭스 요청
	@ResponseBody
	@RequestMapping(value="/idDupCheck", method=RequestMethod.GET)
	public String idDupCheck(String member_id) throws Exception {
		// 아이디 조회 결과 없으면 0, 아이디 존재하면 1 반환
		int result = memberService.idDupCheck(member_id);
		if(result == 0) {
			return "true";
		}
		return "false";
	}
	
	// 이메일 중복 체크 에이잭스 요청
	@ResponseBody
	@RequestMapping(value="/emailDupCheck", method=RequestMethod.GET)
	public String emailDupCheck(String member_email) throws Exception {
		int result = memberService.emailDupCheck(member_email);
		// 이메일 조회 결과 없으면 0, 아이디 존재하면 1 반환
		if(result == 0) {
			return "true";
		}
		return "false";
	}
	
	// 이메일 전송
	@ResponseBody
	@RequestMapping(value="/emailSender", method=RequestMethod.GET)
	public int emailSender(String to) throws Exception {
		EmailDto emailDto = EmailUtil.joinEmailForm(to);
		EmailUtil.emailSubmit(emailDto, mailSender);
		
		int authentication_number = emailDto.getAuthentication_number();
		return authentication_number;
	}
	
	// 마이페이지 폼
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public String memberMyPage() throws Exception {
		return "member/memberInfo";
	}
	
	// 로그인 관련 인터셉터 처리
	@RequestMapping(value="/loginInterceptor", method=RequestMethod.GET)
	public String loginInterceptor(HttpSession session, RedirectAttributes rttr) throws Exception {
		String sessionResult = (String)session.getAttribute("sessionResult");
		rttr.addFlashAttribute("sessionResult", sessionResult);
		session.removeAttribute("sessionResult");
		return "redirect:/member/loginForm";
	}
}
