package com.sgh.community.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sgh.community.domain.PagingDto;

public class MyUtill {

	// 이전의 url을 받아서 보낼 부분만 추리기
	public static String refererUrlReturn(HttpServletRequest request) throws Exception {
		String url = request.getHeader("referer");
		int startIndex = url.lastIndexOf(":") + 5;
		String redirectUrl = url.substring(startIndex);
		return redirectUrl;
	}
	
	// 페이징 검색 유지 시키기
	public static void criteria(RedirectAttributes rttr, PagingDto pagingDto) throws Exception {
		rttr.addAttribute("page", pagingDto.getPage());
		rttr.addAttribute("keyword", pagingDto.getKeyword());
		rttr.addAttribute("category_code", pagingDto.getCategory_code());
		rttr.addAttribute("keywordType", pagingDto.getKeywordType());
		rttr.addAttribute("selectCategory", pagingDto.getSelectCategory());
		rttr.addAttribute("categoryType", pagingDto.getCategoryType());
		rttr.addAttribute("stateType", pagingDto.getStateType());
	}
}
