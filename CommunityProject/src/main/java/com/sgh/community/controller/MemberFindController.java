package com.sgh.community.controller;

import java.lang.ProcessBuilder.Redirect;

import javax.inject.Inject;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sgh.community.domain.EmailDto;
import com.sgh.community.domain.PwFindVo;
import com.sgh.community.service.MemberService;
import com.sgh.community.util.EmailUtil;

@Controller
@RequestMapping(value="/find")
public class MemberFindController {

	@Inject
	private MemberService memberService;
	@Inject
	private JavaMailSender mailSender;
	
	// 아이디 찾기 폼
	@RequestMapping(value="/idFindForm", method=RequestMethod.GET)
	public String idFindForm() throws Exception {
		return "member/idFindForm";
	}
	
	// 비밀번호 찾기 폼
	@RequestMapping(value="/pwFindForm", method=RequestMethod.GET)
	public String pwFindForm() throws Exception {
		return "member/pwFindForm";
	}
	
	// 아이디 찾기 처리
	@RequestMapping(value="/idFindRun", method=RequestMethod.POST)
	public String idFindRun(String member_name, String member_email, RedirectAttributes rttr) throws Exception {
		// 성공적으로 아이디를 찾았으면 해당 메일로 아이디를 보내고
		// 아이디를 찾지 못했으면 다시 아이디 찾기 폼으로
		String member_id = memberService.selectIdFind(member_name, member_email);
		if(member_id != null) {
			EmailDto emailDto = EmailUtil.idFindEmailForm(member_id, member_email);
			EmailUtil.emailSubmit(emailDto, mailSender);
			rttr.addFlashAttribute("idFindResult", "true");
			return "redirect:/member/loginForm";
		}
		rttr.addFlashAttribute("idFindResult", "false");
		return "redirect:/find/idFindForm";
	}
	
	// 비밀번호 찾기 처리(비밀번호를 변경 시킴)
	@RequestMapping(value="/pwFindRun", method=RequestMethod.POST)
	public String pwFindRun(PwFindVo pwFindVo, Model model, RedirectAttributes rttr) throws Exception {
		int selectResult = memberService.selectPwFind(pwFindVo);
		// 아이디가 존재하면 1, 그렇지 않으면 0
		if(selectResult == 1) {
			String member_id = pwFindVo.getMember_id();
			model.addAttribute("member_id", member_id);
			return "member/pwChangeForm";
		}
		
		rttr.addFlashAttribute("pwFindResult", "false");
		return "redirect:/find/pwFindForm";
	}
	
	// 비밀번호 변경
	@RequestMapping(value="/pwChangeRun", method=RequestMethod.POST)
	public String pwChangeRun(String member_id, String member_pw, RedirectAttributes rttr) {
		System.out.println("member_id :" + member_id);
		System.out.println("member_pw :" + member_pw);
		// 비밀번호 변경에 성공하면 로그인 페이지로
		try {
			memberService.pwChange(member_id, member_pw);
			rttr.addFlashAttribute("pwChangeResult", "true");
			return "redirect:/member/loginForm";
		} catch(Exception e) {
			e.printStackTrace();
		}
		// 비밀번호 변경에 실패... 경우 생각해봐야함. 일단 비밀번호 찾기 페이지로 이동
		rttr.addFlashAttribute("pwChangeResult", "false");
		return "redirect:/find/pwFindForm";
	}
}
