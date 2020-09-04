package com.sgh.community.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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
import com.sgh.community.domain.RegistCategory;
import com.sgh.community.domain.RegistVo;
import com.sgh.community.service.BoardService;
import com.sgh.community.util.UploadFileUtil;

@Controller
@RequestMapping(value="/freeBoard")
public class FreeBoardController {

	@Inject
	private BoardService boardService;
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
		List<RegistCategory> categoryList =  boardService.getCategory();
		model.addAttribute("categoryList", categoryList);
		return "board/boardRegist";
	}
	
	// 자유게시판 글쓰기 처리
	@RequestMapping(value="registRun", method=RequestMethod.GET)
	public String registRun(RegistVo registVo, String[] boardFile, RedirectAttributes rttr, HttpSession session) {
		try {
			String category_code = registVo.getCategory_code();
			String member_id = (String)session.getAttribute("member_id");
			registVo.setMember_id(member_id);
			boardService.insertBoard(registVo, boardFile);
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
	@RequestMapping(value = "/uploadAjax", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String upload(MultipartFile file) throws Exception {
		String fileName = file.getOriginalFilename();
		String fileString = UploadFileUtil.fileCopy(fileName, uploadPath, file.getBytes());
		String fileReplaceChangeName = fileString.replace("\\", "/");
		return fileReplaceChangeName;
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
}
