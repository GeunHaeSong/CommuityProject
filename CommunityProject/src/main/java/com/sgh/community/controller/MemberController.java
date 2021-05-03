package com.sgh.community.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.EmailDto;
import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.ModalPagingDto;
import com.sgh.community.service.MemberService;
import com.sgh.community.util.EmailUtil;
import com.sgh.community.util.MyUtill;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;
	// 메일 보낼때 사용할 mailSender
	@Inject
	private JavaMailSender mailSender;
	@Autowired
	BCryptPasswordEncoder passEncoder;
	
	// 로그인 폼
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String boardPageLoginForm(String clickCategory, Model model) throws Exception {
		model.addAttribute("clickCategory", clickCategory);
		return "member/loginForm";
	}
	
	// 로그인 처리(
	@RequestMapping(value="/loginRun", method=RequestMethod.POST)
	public String boardPageLoginRun(String clickCategory, String member_id, String member_pw, HttpSession session, RedirectAttributes rttr) {
		try {
			// 정지 됐는지 확인하기
			String suspensionEndDate = memberService.selectSuspension(member_id);
			if(suspensionEndDate != null) {
				rttr.addFlashAttribute("suspensionEndDate", suspensionEndDate);
				rttr.addFlashAttribute("loginResult", "suspension");
				return "redirect:/member/loginForm?clickCategory=login";
			}
			// 로그인 작업
			MemberLoginVo memberLoginVo = memberService.selectMember(member_id);
			// 암호화 된 비밀번호 비교
			String encoderPw = memberLoginVo.getMember_pw();
			boolean encoderBool = passEncoder.matches(member_pw, encoderPw);
			if(encoderBool == true) {
				// 정상적으로 수행됐다면
				String member_state = memberLoginVo.getMember_state();
				session.setAttribute("member_id", member_id);
				session.setAttribute("member_state", member_state);
				return "redirect:/board/mainView";
			}
			rttr.addFlashAttribute("loginResult", "false");
			return "redirect:/member/loginForm?clickCategory=login";
		} catch(Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("loginResult", "false");
		return "redirect:/member/loginForm?clickCategory=login";
	}
	
	// 로그아웃 처리(저장된 세션 전부 삭제)
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String boardPageLogoutRun(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/member/loginForm?clickCategory=login";
	}
	
	// 회원가입 폼
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String boardPageJoinForm(String clickCategory, Model model) throws Exception {
		model.addAttribute("clickCategory", clickCategory);
		return "member/joinForm";
	}
	
	// 회원가입 처리
//	@Autowired
	@RequestMapping(value="/joinRun", method=RequestMethod.POST)
	public String boardPageJoinRun(MemberVo memberVo, RedirectAttributes rttr) {
		try {
			String pw = memberVo.getMember_pw();
			// 암호화
			String encoderPw = passEncoder.encode(pw);
			memberVo.setMember_pw(encoderPw);
			memberService.insertMember(memberVo);
			rttr.addFlashAttribute("joinResult", "success");
			return "redirect:/member/loginForm?clickCategory=login";
		} catch(Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("joinResult", "fail");
		return "redirect:/member/joinForm?clickCategory=join";
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
	public String memberMyPage(HttpSession session, String clickCategory, String result, Model model) throws Exception {
		String member_id = (String)session.getAttribute("member_id");
		MemberVo memberVo = memberService.memberInfo(member_id);
		Map<String, Integer> boardCommentCountMap = memberService.memberBoardCommentCount(member_id);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("boardCommentCountMap", boardCommentCountMap);
		model.addAttribute("clickCategory", clickCategory);
		model.addAttribute("result", result);
		
		return "member/myPage";
	}
	
	// 해당 멤버의 게시글 보기
	@ResponseBody
	@RequestMapping(value="/myPageShowBoard", method=RequestMethod.GET)
	public ModalPagingDto myPageShowBoard(String member_id, int board_count, ModalPagingDto modalPagingDto) throws Exception {
		modalPagingDto.setPageInfo();
		modalPagingDto.setTotalCount(board_count);
		List<BoardVo> boardList = memberService.myPageShowBoard(member_id, modalPagingDto);
		modalPagingDto.setBoardList(boardList);
		
		return modalPagingDto;
	}
	
	// 해당 멤버의 댓글 보기
	@ResponseBody
	@RequestMapping(value="/myPageShowComment", method=RequestMethod.GET)
	public ModalPagingDto myPageShowComment(String member_id, int comment_count, ModalPagingDto modalPagingDto) throws Exception {
		modalPagingDto.setPageInfo();
		modalPagingDto.setTotalCount(comment_count);
		List<CommentVo> commentList = memberService.myPageShowComment(member_id, modalPagingDto);
		modalPagingDto.setCommentList(commentList);
		return modalPagingDto;
	}
	
	// 개인 정보 수정 페이지로 이동
	@RequestMapping(value="/memberInfoModfiyForm", method=RequestMethod.POST)
	public String memberInfoModifyForm(HttpSession session, String clickCategory, Model model) throws Exception {
		String member_id = (String)session.getAttribute("member_id");
		MemberVo memberVo = memberService.memberInfo(member_id);
		model.addAttribute("clickCategory", clickCategory);
		model.addAttribute("memberVo", memberVo);
		return "member/memberInfoModify";
	}
	
	// 개인 정보 수정 실행
	@RequestMapping(value="/memberInfoModfiyRun", method=RequestMethod.GET)
	public String memberInfoModifyRun(HttpSession session, MemberVo memberVo, HttpServletRequest request) throws Exception {
		try {
			String member_id = (String)session.getAttribute("member_id");
			memberVo.setMember_id(member_id);
			memberService.memberInfoModify(memberVo);
			return "redirect:/member/myPage?clickCategory=myPage";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String url = MyUtill.refererUrlReturn(request);
		return "redirect:" + url;
	}
	
	
	// 회원 탈퇴 폼
	@RequestMapping(value="/memberWthdrForm", method=RequestMethod.GET)
	public String memberWthdrForm(String clickCategory, Model model) throws Exception {
		model.addAttribute("clickCategory", clickCategory);
		return "member/memberWthdrForm";
	}
	
	// 회원 탈퇴 실행
	@RequestMapping(value="/memberWthdrRun", method=RequestMethod.POST)
	public String memberWthdrRun(String member_id, String member_pw, HttpServletRequest request, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		// 현재 로그인된 아이디와 입력된 아이디를 비교해서 다르면 원래 페이지로 돌려 보내기. 실패 문구 출력
		String login_id = (String)session.getAttribute("member_id");
		String url = MyUtill.refererUrlReturn(request);
		if(!login_id.equals(member_id)) {
			rttr.addFlashAttribute("fail", "notMemberId");
			return "redirect:/member/memberWthdrForm?clickCategory=myPage";
		}
		
		// 로그인 작업
		MemberLoginVo memberLoginVo = memberService.selectMember(member_id);
		// 암호화 된 비밀번호 비교
		String encoderPw = memberLoginVo.getMember_pw();
		boolean encoderBool = passEncoder.matches(member_pw, encoderPw);
		if(encoderBool == true) {
			// 검색된 결과가 있다면 성공으로
			int wthdrResult = memberService.memberWthdr(member_id);
			if(wthdrResult == 1) {
				// 세션 비우기
				session.invalidate();
				rttr.addFlashAttribute("success", "wthdr");
				return "redirect:/member/loginForm";
			}
		}
		
		// 아니면 실패
		rttr.addFlashAttribute("fail", "notMemberPw");
		return "redirect:" + url;
	}
}
