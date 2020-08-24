package com.sgh.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/boardPage")
public class BoardPageController {

	// 기본 페이지로 이동시키는 작업 입니다.
	// 현재 페이지는 mainView, about, contact, fashion, single, travel 있습니다.
	
	@RequestMapping(value="/mainView", method=RequestMethod.GET)
	public String boardPageMainView() throws Exception {
		return "mainView/mainView";
	}
	
	@RequestMapping(value="/about", method=RequestMethod.GET)
	public String boardPageAbout() throws Exception {
		return "about/about";
	}
	
	@RequestMapping(value="/contact", method=RequestMethod.GET)
	public String boardPageContact() throws Exception {
		return "contact/contact";
	}
	
	@RequestMapping(value="/fashion", method=RequestMethod.GET)
	public String boardPageFashion() throws Exception {
		return "fashion/fashion";
	}
	
	@RequestMapping(value="/single", method=RequestMethod.GET)
	public String boardPageSingle() throws Exception {
		return "single/single";
	}
	
	@RequestMapping(value="/travel", method=RequestMethod.GET)
	public String boardPageTravel() throws Exception {
		return "travel/travel";
	}
}
