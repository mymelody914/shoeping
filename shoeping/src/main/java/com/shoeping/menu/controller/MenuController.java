package com.shoeping.menu.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.item.vo.ItemVO;
import com.shoeping.member.vo.LoginVO;
import com.shoeping.menu.service.MenuService;
import com.shoeping.wishlist.service.WishListService;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Controller
@Data
@RequestMapping("/menu")
public class MenuController {
	
	@Autowired
	@Qualifier("menuServiceImpl")
	private MenuService service;
	
	@Autowired
	@Qualifier("wishListServiceImpl")
	private WishListService wishListService;
	
	@GetMapping("/list.do")
	public String list(Model model,PageObject pageObject,HttpSession session,String category,String brand) {
		System.out.println("ItemController.list()");
		List<ItemVO> list = service.list(pageObject,category,brand);
		model.addAttribute("list", list);
		List<Long> wishlist = new ArrayList<>();
		if (((LoginVO) session.getAttribute("login")) != null) {

			for (int i = 0; i < list.size(); i++) {
				wishlist.add(wishListService.checkWishList(list.get(i).getItemNo(),
						(((LoginVO) session.getAttribute("login")).getId())));
			}
			System.out.println(wishlist);
			model.addAttribute("wishlist", wishlist);
		}
		

		return "menu/list";
	}

}
