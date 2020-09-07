package com.sgh.community.controller;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
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
import com.sgh.community.util.UploadFileUtil;

@Controller
@RequestMapping(value="/freeBoard")
public class FreeBoardController {

	@Inject
	private BoardService boardService;
	@Inject
	private BoardUpService boardUpService;
	@Resource
	String uploadPath;

	
	// 게시판 목록
	@RequestMapping(value="/boardList", method=RequestMethod.GET)
	public String freeBoardList(PagingDto pagingDto, @RequestParam("category_code") String category_code, Model model) throws Exception {
		// 페이징 작업하고 난 후에 그 정보로 게시글 불러오기
		int totalCount = boardService.getBoardTotalCount();
		pagingDto.setTotalCount(totalCount);
		pagingDto.setPageInfo();
		if(category_code != null) {
			pagingDto.setCategory_code(category_code);
		}
		List<BoardVo> boardList = boardService.getBoardList(pagingDto);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagingDto", pagingDto);
		
		return "board/boardList";
	}
	
	// 자유게시판 글쓰기 폼
	@RequestMapping(value="/registForm", method=RequestMethod.GET)
	public String registForm(Model model) throws Exception {
		List<CategoryVo> categoryList =  boardService.getCategory();
		model.addAttribute("categoryList", categoryList);
		return "board/boardRegist";
	}
	
	// 자유게시판 글쓰기 처리
	@RequestMapping(value="registRun", method=RequestMethod.GET)
	public String registRun(WriteModifyVo writeModifyVo, String[] boardFile, RedirectAttributes rttr, HttpSession session) {
		try {
			String category_code = writeModifyVo.getCategory_code();
			String member_id = (String)session.getAttribute("member_id");
			writeModifyVo.setMember_id(member_id);
			boardService.insertBoard(writeModifyVo, boardFile);
			rttr.addFlashAttribute("boardResult", "true");
			rttr.addAttribute("category_code", category_code);
			return "redirect:/freeBoard/boardList";
		} catch(Exception e) {
			e.printStackTrace();
		}
		rttr.addFlashAttribute("boardResult", "false");
		return "redirect:/freeBoard/registForm";
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
	public String boardInfo(String board_num, Model model) throws Exception {
		boardService.openBoardViewUp(board_num);
		BoardVo boardVo = boardService.openOneBoard(board_num);
		List<BoardFileVo> boardFileList = boardService.getOpenBoardFile(board_num);
		
		model.addAttribute("BoardVo", boardVo);
		model.addAttribute("BoardFileList", boardFileList);
		return "board/boardInfo";
	}
	
	// 게시글 수정
	@RequestMapping(value="/updateBoard", method=RequestMethod.GET)
	public String modifyForm(String board_num, Model model) throws Exception {
		List<CategoryVo> categoryList =  boardService.getCategory();
		BoardVo boardVo = boardService.openOneBoard(board_num);
		List<BoardFileVo> boardFileList = boardService.getOpenBoardFile(board_num);
		
		model.addAttribute("BoardVo", boardVo);
		model.addAttribute("boardFileList", boardFileList);
		model.addAttribute("categoryList", categoryList);
		return "board/updateBoard";
	}
	
	// 게시글 수정 처리
	@RequestMapping(value="/updateBoardRun", method=RequestMethod.GET)
	public String updateBoardRun(WriteModifyVo writeModifyVo, String[] boardFile, String[] delFileCode, RedirectAttributes rttr, HttpSession session) throws Exception {
		String member_id = (String)session.getAttribute("member_id");
		writeModifyVo.setMember_id(member_id);
		int board_num = writeModifyVo.getBoard_num();
		boardService.updateBoard(writeModifyVo, boardFile, delFileCode);
		return "redirect:/freeBoard/boardInfo?board_num=" + board_num;
	}
	
	
	// 게시글 삭제
	@RequestMapping(value="/deleteBoardRun", method=RequestMethod.GET)
	public String deleteBoardRun(String category_code, int board_num, HttpSession session) throws Exception {
		Map<String, Object> deleteBoardMap = new HashMap<String, Object>();
		String member_id = (String)session.getAttribute("member_id");
		deleteBoardMap.put("member_id", member_id);
		deleteBoardMap.put("board_num", board_num);
		System.out.println("deleteBoardMap : " + deleteBoardMap);
		boardService.deleteBoard(deleteBoardMap);
		return "redirect:/freeBoard/boardList?category_code=" + category_code;
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
