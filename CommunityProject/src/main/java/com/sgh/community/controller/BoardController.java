package com.sgh.community.controller;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sgh.community.domain.BoardFileVo;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.WriteModifyVo;
import com.sgh.community.service.BoardService;
import com.sgh.community.service.BoardUpService;
import com.sgh.community.util.MyUtill;
import com.sgh.community.util.UploadFileUtil;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	@Inject
	private BoardService boardService;
	@Inject
	private BoardUpService boardUpService;
	@Resource
	String uploadPath;

	// 기본 페이지로 이동시키는 작업 입니다.
	@RequestMapping(value="/mainView", method=RequestMethod.GET)
	public String boardPageMainView(Model model) throws Exception {
		return "mainView/mainView";
	}
	
	// 게시판 목록(전체 게시판 제외)
	@RequestMapping(value="/boardList", method=RequestMethod.GET)
	public String freeBoardList(PagingDto pagingDto, @RequestParam("clickCategory") String clickCategory, Model model) throws Exception {
		pagingDto.setCategory_code(clickCategory);
		// 페이징 작업하고 난 후에 그 정보로 게시글 불러오기
		int totalCount = boardService.getCategoryBoardTotalCount(pagingDto);
		pagingDto.setTotalCount(totalCount);
		pagingDto.setPageInfo();

		// 게시글 정보 가져오기
		List<BoardVo> boardList = boardService.getBoardList(pagingDto);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		
		return "board/boardList";
	}
	
	// 전체 게시판 글 목록
	@RequestMapping(value="/listAll", method=RequestMethod.GET)
	public String listAll(PagingDto pagingDto, @RequestParam("clickCategory") String clickCategory, Model model) throws Exception {
		int listAllCount = boardService.getBoardAllCount(pagingDto);
		pagingDto.setTotalCount(listAllCount);
		pagingDto.setPageInfo();
		List<BoardVo> boardList = boardService.getBoardListAll(pagingDto);
		
		if(clickCategory == "" || clickCategory == null) {
			clickCategory = "mainView";
		}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("clickCategory", clickCategory);
		
		return "board/boardListAll";
	}
	
	// 게시판 글쓰기 폼
	@RequestMapping(value="/registForm", method=RequestMethod.GET)
	public String registForm(String clickCategory, Model model) throws Exception {
		List<CategoryVo> categoryList =  boardService.getCategory();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("clickCategory", clickCategory);
		return "board/boardRegist";
	}
	
	// 게시판 글쓰기 처리
	@RequestMapping(value="/registRun", method=RequestMethod.GET)
	public String registRun(WriteModifyVo writeModifyVo, String[] boardFile, RedirectAttributes rttr, HttpSession session) {
		String category_code = writeModifyVo.getCategory_code();
		try {
			String member_id = (String)session.getAttribute("member_id");
			writeModifyVo.setMember_id(member_id);
			boardService.insertBoard(writeModifyVo, boardFile);
			rttr.addFlashAttribute("boardResult", "true");
			rttr.addAttribute("clickCategory", category_code);
			return "redirect:/board/boardList";
		} catch(Exception e) {
			e.printStackTrace();
		}
		rttr.addAttribute("clickCategory", category_code);
		rttr.addFlashAttribute("boardResult", "false");
		return "redirect:/board/registForm";
	}
	
	// 글쓰기 취소 처리
	@RequestMapping(value="/cancelRun", method=RequestMethod.GET)
	public String cancelRun(HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		// 이전 url을 구해서 category_code를 뽑은 다음 그에 걸맞는 페이지로 이동 시키기
		String url = request.getHeader("referer");
		int codeIndex = url.indexOf("=") + 1;
		String clickCategory = url.substring(codeIndex);
		int categoryLength = clickCategory.length();
		if(categoryLength == 0) {
			clickCategory = "mainView";
		}
		// listAll이면 전체 페이지, 0이면 메인 페이지, 그 외에는 boardList로 제어하는 페이지들
		if(clickCategory.equals("listAll")) {
			rttr.addAttribute("clickCategory", clickCategory);
			return "redirect:/board/listAll";
		} else if(categoryLength == 0) {
			return "redirect:/board/mainView";
		}
		rttr.addAttribute("clickCategory", clickCategory);
		return "redirect:/board/boardList";
	}
	
	
	// 파일 업로드
	@ResponseBody
	@RequestMapping(value="/uploadAjax", produces="application/text; charset=utf8", method=RequestMethod.POST)
	public String upload(MultipartFile file) throws Exception {
		String fileName = file.getOriginalFilename();
		String fileString = UploadFileUtil.fileCopy(fileName, uploadPath, file.getBytes());
		String fileReplaceChangeName = fileString.replace("\\", "/");
		return fileReplaceChangeName;
	}
	
	// 파일 다운로드
	@RequestMapping(value="/fileDown", method=RequestMethod.GET)
	public void fileDown(String file_code, HttpServletResponse response) throws Exception {
		try {
			Map<String, Object> resultMap = boardService.fileDown(file_code);
			// DB에 저장된 파일 이름
			String storedFileName = (String)resultMap.get("FILE_NAME");
			// 원본 이름
			int uuidIndex = storedFileName.lastIndexOf("__") + 2;
			String originalFileName = storedFileName.substring(uuidIndex);
			String filePath = uploadPath + "/" + storedFileName;
			
			// 다운로드
			byte[] fileByte = FileUtils.readFileToByteArray(new File(filePath));
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 이미지 미리보기
	@ResponseBody
	@RequestMapping(value="/displayImage", method=RequestMethod.GET)
	public byte[] displayImage(@RequestParam("fileName") String fileName) throws Exception {
		String filePath = uploadPath + File.separator + fileName;
		String fileReplaceChangeName = filePath.replace("/", "\\");
		FileInputStream fis = new FileInputStream(fileReplaceChangeName);
		byte[] byteImage = IOUtils.toByteArray(fis);
		fis.close();
		return byteImage;
	}
	
	// 이미지 삭제
	@ResponseBody
	@RequestMapping(value="/deleteImage", method=RequestMethod.GET)
	public String deleteImage(String fileName) throws Exception {
		String serverPath = uploadPath + File.separator + fileName;
		int SlashLastIndex = fileName.lastIndexOf("/") + 1;
		String front = fileName.substring(0, SlashLastIndex);
		String rear = fileName.substring(SlashLastIndex);
		String smServerPath = uploadPath + File.separator + front + "sm_" + rear;
		File f = new File(serverPath);
		f.delete();
		boolean result = UploadFileUtil.isImage(fileName);
		if(result == true) {
			File f2 = new File(smServerPath);
			f2.delete();
		}
		return "success";
	}
	
	// 게시글 보기
	@RequestMapping(value="/boardInfo", method=RequestMethod.GET)
	public String boardInfo(HttpServletRequest request, String board_num, Model model,
				HttpServletResponse response, RedirectAttributes rttr) throws Exception {
		
		// 쿠키 불러오기
		Cookie[] cookies = request.getCookies();
		boolean cookieBool = false;
		// 쿠키의 내용을 확인해서 board의 항목에 값이 있다면 쿠키가 있다는 걸로 설정해주고
		// 쿠키의 값과 지금 접속한 페이지의 값을 확인해서 없다면 조회수 올려주기
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("board")) {
				cookieBool = true;
				if(!(cookie.getValue().contains(board_num))) {
					//쿠키 시간 60분으로 설정
					cookie.setMaxAge(60 * 60);
					cookie.setValue(cookie.getValue() + "_" + board_num);
					response.addCookie(cookie);
					boardService.openBoardViewUp(board_num);
				}
			}
		}		
		
		// 쿠키가 없다면 쿠키 생성해주고 조회수 올리기
		if(cookieBool == false) {
			// 쿠키 등록
			Cookie saveCookie = new Cookie("board", board_num);
			saveCookie.setMaxAge(60 * 60);
			response.addCookie(saveCookie);
			// 조회수 증가
			boardService.openBoardViewUp(board_num);
		}
		
		// Board 내용 불러오기
		BoardVo boardVo = boardService.openOneBoard(board_num);
		// board의 정보가 없을 경우 이전 url로 이동시키기
		if(boardVo == null) {
			String redirectUrl = MyUtill.refererUrlReturn(request);
			return "redirect:" + redirectUrl;
		}
		// 파일 정보
		List<BoardFileVo> boardFileList = boardService.getOpenBoardFile(board_num);
		String clickCategory = boardVo.getCategory_code();
		model.addAttribute("BoardVo", boardVo);
		model.addAttribute("BoardFileList", boardFileList);
		model.addAttribute("clickCategory", clickCategory);
		return "board/boardInfo";
	}
	
	// 게시글 수정
	@RequestMapping(value="/updateBoard", method=RequestMethod.GET)
	public String modifyForm(String board_num, Model model) throws Exception {
		List<CategoryVo> categoryList =  boardService.getCategory();
		BoardVo boardVo = boardService.openOneBoard(board_num);
		List<BoardFileVo> boardFileList = boardService.getOpenBoardFile(board_num);
		String clickCategory = boardVo.getCategory_code();
		
		model.addAttribute("BoardVo", boardVo);
		model.addAttribute("boardFileList", boardFileList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("clickCategory", clickCategory);
		return "board/updateBoard";
	}
	
	// 게시글 수정 처리
	@RequestMapping(value="/updateBoardRun", method=RequestMethod.POST)
	public String updateBoardRun(WriteModifyVo writeModifyVo, String[] boardFile, String[] delFileCode, RedirectAttributes rttr, HttpSession session) throws Exception {
		String member_id = (String)session.getAttribute("member_id");
		writeModifyVo.setMember_id(member_id);
		int board_num = writeModifyVo.getBoard_num();
		boardService.updateBoard(writeModifyVo, boardFile, delFileCode);
		return "redirect:/board/boardInfo?board_num=" + board_num;
	}
	
	
	// 게시글 삭제(일괄 삭제도 가능)
	@RequestMapping(value="/deleteBoardRun", method=RequestMethod.POST)
	public String deleteBoardRun(String clickCategory, int[] board_num, HttpServletRequest request,
										HttpSession session) throws Exception {
		
		Map<String, Object> deleteBoardMap = new HashMap<String, Object>();
		String member_id = (String)session.getAttribute("member_id");
		
		// 일괄 삭제 가능 가능
		for(int i = 0; i < board_num.length; i++) {
			deleteBoardMap.put("member_id", member_id);
			deleteBoardMap.put("board_num", board_num[i]);
			boardService.deleteBoard(deleteBoardMap);
		}
		
		// 카테고리 코드가 없이 넘어오는 myPage의 경우
		if(clickCategory == "" || clickCategory == null) {
			String redirectUrl = MyUtill.refererUrlReturn(request);
			return "redirect:" + redirectUrl;
		}
		// 카테고리 코드가 넘어오면 해당 코드의 페이지로 이동
		return "redirect:/board/boardList?clickCategory=" + clickCategory;
	}
	
	// ------------ 게시글 좋아요 관련 ----------------
	
	@ResponseBody
	@RequestMapping(value="/boardUp", method=RequestMethod.GET)
	public int boardUp(String board_num, HttpSession session) throws Exception {
		Map<String, Object> boardUpMap = new HashMap<String, Object>();
		String member_id = (String)session.getAttribute("member_id");
		boardUpMap.put("board_num", board_num);
		boardUpMap.put("member_id", member_id);
		
		int checkResult = boardUpService.boardUpCheck(boardUpMap);
		if(checkResult == 0) {
			boardUpService.firstUp(boardUpMap);
		} else {
			boardUpService.secondUp(boardUpMap);
		}
		
		return boardUpService.selectBoardUpTotal(board_num);
	}
	
	@ResponseBody
	@RequestMapping(value="/boardUpCheck", method=RequestMethod.GET)
	public int boardUpCheck(String board_num, HttpSession session) {
		// return 값이 0이면 좋아요 클릭 안함, 1이면 좋아요 클릭함, 2면 로그인을 하지 않은 상태
		try {
			Map<String, Object> boardUpMap = new HashMap<String, Object>();
			String member_id = (String)session.getAttribute("member_id");
			boardUpMap.put("board_num", board_num);
			boardUpMap.put("member_id", member_id);
			return boardUpService.boardUpCheck(boardUpMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 2;
	}
}
