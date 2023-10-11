package com.shoeping.cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.cart.service.CartService;
import com.shoeping.member.vo.LoginVO;

import lombok.Data;


@Controller
@RequestMapping("/cart")
@Data
public class CartController {
	
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService service;
	
	
	@GetMapping("list.do")
	public String list(Model model,HttpSession session) {
		String id = (((LoginVO) session.getAttribute("login")).getId());
		System.out.println("CartController.list() - 실행  id = " + id);
		model.addAttribute("list",service.list(id));
		return "cart/list";
	}
	@GetMapping("insertCart.do")
	public String insertCart(String color,String size,Long itemNo,Long imageNo,Long quantity,HttpSession session, Model model) {
		String id = (((LoginVO) session.getAttribute("login")).getId());
		System.out.println("color : " + color);
		Integer result = service.insertCart(color,size,itemNo,imageNo,quantity,id);
		System.out.println("인서트카트 결과값 : " + result);
		return "redirect:/item/view.do?itemNo="+itemNo;
	}
	
	

	


}
