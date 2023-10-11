package com.shoeping.wishlist.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.member.vo.LoginVO;
import com.shoeping.wishlist.service.WishListService;
import com.shoeping.wishlist.vo.WishListVO;


import lombok.Data;
import lombok.extern.java.Log;

@Controller
@RequestMapping("/wishList")
@Data
@Log
public class WishListController {
	
	@Autowired
	@Qualifier("wishListServiceImpl")
	private WishListService service;
	
	
	
	@GetMapping("list.do")
	public String list(Model model, HttpSession session) {
		
		String id = (((LoginVO) session.getAttribute("login")).getId());
		model.addAttribute("list",service.list(id));
		return "wishList/list";
	}
	

}
