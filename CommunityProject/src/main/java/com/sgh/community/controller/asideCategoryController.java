package com.sgh.community.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.sgh.community.domain.CategoryVo;
import com.sgh.community.service.BoardService;

@RestController
@RequestMapping(value="/asideCategory")
public class asideCategoryController {

	// aside의 카테고리 관련 작업을 하는 컨트롤러 입니다.

	@Inject
	private BoardService boardService;
	
	// aside의 카테고리 목록을 불러옵니다.
	@RequestMapping(value="/categoryList", method=RequestMethod.GET)
	public List<CategoryVo> categoryList() throws Exception {
		List<CategoryVo> categoryVoList = boardService.getCategory();
		return categoryVoList;
	}
}
