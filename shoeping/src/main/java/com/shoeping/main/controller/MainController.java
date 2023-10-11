package com.shoeping.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.item.service.ItemService;
import com.shoeping.review.service.ReviewService;
import com.webjjang.util.page.PageObject;


@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
    @Qualifier("itemServiceImpl")
    private ItemService service;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@GetMapping("main.do")
	public String main(Model model, PageObject pageObject) {
		
		model.addAttribute("list", service.list(pageObject));
		
		model.addAttribute("reviewList",reviewService.list(pageObject));
		
		return"main/main";
	}

}
