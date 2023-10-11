package com.shoeping.buy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.buy.service.BuyService;
import com.shoeping.buy.vo.BuyVO;
import com.shoeping.cart.service.CartService;
import com.shoeping.item.service.ItemService;
import com.shoeping.member.service.MemberService;
import com.shoeping.member.vo.LoginVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Controller
@RequestMapping("/buy")
@Data
public class BuyController {

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	@Autowired
	@Qualifier("itemServiceImpl")
	private ItemService itemService;
	
	@Autowired
	@Qualifier("buyServiceImpl")
	private BuyService buyService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	

	// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 카트 구매 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
	@GetMapping("list.do")
	public String list(Model model , @ModelAttribute PageObject pageObject, HttpSession session,String memberId, HttpServletRequest request) {
		System.out.println("BuyController.list()");
		memberId=(((LoginVO) session.getAttribute("login")).getId());
		model.addAttribute("list", buyService.list(pageObject, memberId));
		
	return "buy/list";
	}
	
	@GetMapping("buyCart.do")
	public String buyCartFrom(Model model, HttpSession session) {
		System.out.println("BuyController.buyCartFrom()");
		String id = (((LoginVO) session.getAttribute("login")).getId());
		model.addAttribute("list", cartService.list(id));
		model.addAttribute("member", memberService.view(id));
		
		return "buy/buy";
	}
	
	@PostMapping("buy.do")
	public String buy(BuyVO vo, HttpSession session, String count , RedirectAttributes rttr) {
		System.out.println("BuyController.cartList()");
		String id = (((LoginVO) session.getAttribute("login")).getId());
		vo.setMemberId(id);
		buyService.buy(vo);
		System.out.println("buyVO : " + vo.getMemberId());
		rttr.addFlashAttribute("msg", "결제가 완료 되었습니다.");
		
		return "redirect:/buy/list.do";
	}
	
	// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 바로 구매 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
	@GetMapping("buyDirect.do")
	public String buyDirectFrom(Long itemNo, Model model, HttpSession session) {
		System.out.println("BuyController.buyDirectFrom()");
		String id = (((LoginVO) session.getAttribute("login")).getId());
		model.addAttribute("vo", itemService.view(itemNo));
		model.addAttribute("member", memberService.view(id));
		
		return "buy/buyDirect";
	}
	
	@PostMapping("buyDirect.do")
	public String buyDirect(BuyVO vo, HttpSession session, String count, RedirectAttributes rttr,
			Long itemNo, String color, String size, int quantity) {
		System.out.println("BuyController.buyDirect()");
		String id = (((LoginVO) session.getAttribute("login")).getId());
		vo.setMemberId(id);
		buyService.buyDirect(vo);
		System.out.println("BuyController.buyDirect() - BuyVO :" + vo);
		rttr.addFlashAttribute("msg", "결제가 완료 되었습니다.");
		
		return "redirect:/buy/list.do";
	}
	
	@GetMapping("buyList.do")
	public String buyList(Model model, @ModelAttribute PageObject pageObject) {
		model.addAttribute("list", buyService.buyList(pageObject));
		
		return "buy/list";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
