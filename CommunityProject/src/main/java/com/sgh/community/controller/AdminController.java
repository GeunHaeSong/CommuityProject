package com.sgh.community.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.ChartDto;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberMngVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.SuspensionVo;
import com.sgh.community.service.AdminService;
import com.sgh.community.service.BoardService;
import com.sgh.community.util.MyUtill;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Inject
	private AdminService adminService;
	@Inject
	private BoardService boardService;
	
	// 관리자 차트 관리
	@RequestMapping(value="/adminChartForm", method=RequestMethod.GET)
	public String adminChartForm(String clickCategory, Model model) throws Exception {
		// 구글 차트에 넣을 정보 불러오기
		List<ChartDto> list = adminService.showChartInfo();
		
		// 구글 차트에 넣을수 있게 작성해서 보내기
		String str = "";
		for(ChartDto dto : list) {
			str += "['";
			str += dto.getChart_date();
			str += "', ";
			str += dto.getBoard_num();
			str += ", ";
			str += dto.getMember_num();
			str += "],";
		}
		str = str.substring(0, str.length() - 1);
		model.addAttribute("str", str);
		model.addAttribute("clickCategory", clickCategory);
		return "admin/main/adminChartForm";
	}
	
	// 관리자 회원 관리
	@RequestMapping(value="/memberMngForm", method=RequestMethod.GET)
	public String memberMngForm(@ModelAttribute("pagingDto") PagingDto pagingDto,
			String clickCategory, Model model) throws Exception {
		// 페이징 작업
		int memberCount = adminService.memberCount(pagingDto);
		int showPerPage = 5;
		pagingDto.setPerPage(showPerPage);
		pagingDto.setTotalCount(memberCount);
		pagingDto.setPageInfo();
		
		// 회원 정보 가져오고 보내기
		List<MemberMngVo> memberMngList = adminService.memberMngList(pagingDto);
		model.addAttribute("memberMngList", memberMngList);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		
		return "admin/main/memberMngForm";
	}
	
	// state update 시켜서 권한 변경
	@RequestMapping(value="/changeStateRun", method=RequestMethod.POST)
	public String changeStateRun(String member_id, String member_state, PagingDto pagingDto,
		RedirectAttributes rttr) throws Exception {
		adminService.updateMemberState(member_id, member_state);
		MyUtill.criteria(rttr, pagingDto);
		return "redirect:/admin/memberMngForm";
	}
	
	// 게시글 삭제
	@RequestMapping(value="/adminBoardDelete", method=RequestMethod.POST)
	public String adminBoardDelete(int board_num, PagingDto pagingDto, RedirectAttributes rttr) {
		try {
			adminService.adminBoardDelete(board_num);
			rttr.addFlashAttribute("boardDeleteResult", "success");
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/boardMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("boardDeleteResult", "fail");
		return "redirect:/admin/boardMngForm";
	}
	
	// 게시글 복구
	@RequestMapping(value="/adminBoardRestore", method=RequestMethod.POST)
	public String adminBoardRestore(int board_num, PagingDto pagingDto, RedirectAttributes rttr) throws Exception {
		try {
			adminService.adminBoardRestore(board_num);
			rttr.addFlashAttribute("boardRestoreResult", "success");
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/boardMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("boardRestoreResult", "fail");
		return "redirect:/admin/boardMngForm";
	}
	
	// 정지 시키기
	@RequestMapping(value="/insertSuspension", method=RequestMethod.POST)
	public String insertSuspension(RedirectAttributes rttr, SuspensionVo suspensionVo, PagingDto pagingDto) {
		try {
			adminService.insertSuspension(suspensionVo);
			rttr.addAttribute("page", pagingDto.getPage());
			rttr.addFlashAttribute("suspensionResult", "success");
			return "redirect:/admin/memberMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("suspensionResult", "fail");
		return "redirect:/admin/memberMngForm";
	}
	
	// 관리자 게시글 관리
	@RequestMapping(value="/boardMngForm", method=RequestMethod.GET)
	public String boardMngForm(@ModelAttribute("pagingDto") PagingDto pagingDto, 
			String clickCategory, Model model) throws Exception {
		int boardCount = adminService.adminSelectBoardCount(pagingDto);
		int showPerPage = 10;
		pagingDto.setPerPage(showPerPage);
		pagingDto.setTotalCount(boardCount);
		pagingDto.setPageInfo();
		
		List<BoardVo> boardList = adminService.adminSelectBoardList(pagingDto);
		// 카테고리 얻기
		List<CategoryVo> categoryList = boardService.getCategory();
		model.addAttribute("boardList", boardList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		return "admin/main/boardMngForm";
	}
	
	// 관리자 댓글 관리
	@RequestMapping(value="/commentMngForm", method=RequestMethod.GET)
	public String commentMngForm(@ModelAttribute("pagingDto") PagingDto pagingDto, 
			String clickCategory, Model model) throws Exception {
		int commentCount = adminService.adminCommentCount(pagingDto);
		int showPerPage = 10;
		pagingDto.setPerPage(showPerPage);
		pagingDto.setTotalCount(commentCount);
		pagingDto.setPageInfo();
		
		List<CommentVo> commentList = adminService.adminSelectCommentList(pagingDto);
		// 카테고리 얻기
		List<CategoryVo> categoryList = boardService.getCategory();
		model.addAttribute("commentList", commentList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		
		return "admin/main/commentMngForm";
	}
	
	// 관리자 댓글 삭제
	@RequestMapping(value="/adminCommentDelete", method=RequestMethod.POST)
	public String adminCommentDelete(int comment_num, PagingDto pagingDto, RedirectAttributes rttr) {
		try {
			adminService.adminCommentDelete(comment_num);
			rttr.addFlashAttribute("commentDeleteResult", "success");
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/commentMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("commentDeleteResult", "fail");
		return "redirect:/admin/commentMngForm";
	}
	
	// 관리자 댓글 복구
	@RequestMapping(value="/adminCommentRestore", method=RequestMethod.POST)
	public String adminCommentRestore(int comment_num, PagingDto pagingDto, RedirectAttributes rttr) throws Exception {
		try {
			adminService.adminCommentRestore(comment_num);
			rttr.addFlashAttribute("commentRestoreResult", "success");
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/commentMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("commentRestoreResult", "fail");
		return "redirect:/admin/commentMngForm";
	}
	
	// 사이드 메뉴
	@RequestMapping(value="/sideMenuMngForm", method=RequestMethod.GET)
	public String sideMenuMngForm(@ModelAttribute("pagingDto") PagingDto pagingDto, 
			String clickCategory, Model model) throws Exception {
		int count = adminService.adminCategoryCount(pagingDto);
		int showPerPage = 7;
		pagingDto.setPerPage(showPerPage);
		pagingDto.setTotalCount(count);
		pagingDto.setPageInfo();
		// 카테고리 얻기
		List<CategoryVo> adminCategoryList = adminService.selectCategoryList(pagingDto);
		List<CategoryVo> noamlCategoryList = boardService.getCategory();
		int liveCount = adminService.liveCategoryCount();
		model.addAttribute("adminCategoryList", adminCategoryList);
		model.addAttribute("noamlCategoryList", noamlCategoryList);
		model.addAttribute("liveCount", liveCount);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		
		return "admin/main/sideMenuMngForm";
	}
	
	// 사이드 메뉴 설정 폼
	@RequestMapping(value="/sideMenuSetForm", method=RequestMethod.GET)
	public String sideMenuSetForm(String clickCategory, PagingDto pagingDto, Model model) throws Exception {
		// 카테고리 얻기
		List<CategoryVo> categoryList = adminService.selectSetCategoryList();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		
		return "admin/main/sideMenuSetForm";
	}
	
	// 사이드 메뉴 권한 변경시키기
	@RequestMapping(value="/accessChangeRun", method=RequestMethod.POST)
	public String accessChangeRun(String category_access, PagingDto pagingDto, String category_code,
								  RedirectAttributes rttr) {
		try {
			adminService.accessChange(category_code, category_access);
			rttr.addFlashAttribute("accessResult", "success");
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/sideMenuMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("accessResult", "fail");
		return "redirect:/admin/sideMenuMngForm";
	}
	
	// 카테고리 삭제
	@RequestMapping(value="/deleteCategory", method=RequestMethod.POST)
	public String deleteCategory(String category_code, PagingDto pagingDto, 
								 RedirectAttributes rttr) {
		try {
			adminService.deleteCategory(category_code);
			rttr.addFlashAttribute("deleteResult", "success");
			// 페이징 유지
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/sideMenuMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("deleteResult", "fail");
		return "redirect:/admin/sideMenuMngForm";
	}
	
	// 카테고리 복구
	@RequestMapping(value="/restoreCategory", method=RequestMethod.POST)
	public String restoreCategory(String category_code, PagingDto pagingDto, 
								  RedirectAttributes rttr) {
		try {
			adminService.restoreCategory(category_code);
			rttr.addFlashAttribute("restoreResult", "success");
			// 페이징 유지
			MyUtill.criteria(rttr, pagingDto);
			return "redirect:/admin/sideMenuMngForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("restoreResult", "fail");
		return "redirect:/admin/sideMenuMngForm";
	}
	
	// 카테고리 생성
	@RequestMapping(value="/insertCategoryRun", method=RequestMethod.GET)
	public String insertCategoryRun(String category_name, String category_access, 
								  RedirectAttributes rttr) {
		try {
			adminService.insertCategory(category_name, category_access);
			rttr.addFlashAttribute("insertResult", "success");
			return "redirect:/admin/sideMenuSetForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("insertResult", "fail");
		return "redirect:/admin/sideMenuSetForm";
	}
	
	// 카테고리 순서 변경
	@RequestMapping(value="/changeCategoryRun", method=RequestMethod.POST)
	public String changeCategoryRun(String[] category_code_arr, String[] category_order_arr, RedirectAttributes rttr) {
		try {
			adminService.updateCategoryOrder(category_code_arr, category_order_arr);
			rttr.addFlashAttribute("changeCategoryResult", "success");
			return "redirect:/admin/sideMenuSetForm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("changeCategoryResult", "fail");
		return "redirect:/admin/sideMenuSetForm";
	}
	
	// 에이잭스
	// 탈퇴 시간 보여주기
	@ResponseBody
	@RequestMapping(value="/showWthrdDate", method=RequestMethod.GET)
	public String showWthrdDate(String member_id) throws Exception {
		return adminService.showWthdrDate(member_id);
	}
	
	// 정지 내역 보여주기
	@ResponseBody
	@RequestMapping(value="/showSuspensionRecord", method=RequestMethod.GET)
	public List<SuspensionVo> showSuspensionRecord(String member_id) throws Exception {
		return adminService.showSuspensionRecord(member_id);
	}
	
	// 정지 풀기
	@ResponseBody
	@RequestMapping(value="/updateSuspension", method=RequestMethod.GET)
	public String updateSuspension(int suspension_no, String member_id) {
		// 업데이트 시킬거 리턴 만들고 반환값도 하기
		try {
			adminService.updateSuspension(suspension_no, member_id);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}
}
