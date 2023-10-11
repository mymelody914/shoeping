package com.shoeping.wishlist.ajax.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.member.vo.LoginVO;
import com.shoeping.wishlist.service.WishListService;

import lombok.Data;
import lombok.extern.java.Log;

@Controller
@RequestMapping("/wishListAjax")
@Data
@Log
public class WishListAjaxController {
	
	
	@Autowired
	@Qualifier("wishListServiceImpl")
	private WishListService service;
	
	@PostMapping(value = "deleteWishList.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> deleteWishList(Long wishListNo) {
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cartNo = " + wishListNo);
		Integer result = service.deleteWishList(wishListNo);
		System.out.println("cartAjaxController.quantity() 실행  cartNo = " + wishListNo + "result = " + result);
		
		if(result == 1 ) return new ResponseEntity<String>("제품 수량이 변경되었습니다." , HttpStatus.OK );
		else return new ResponseEntity<String>("제품 수량 변경에 실패 했습니다.\n 정보를 확인해주세요." , HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@PostMapping(value = "insertWishList.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> insertWishList(Long itemNo,Long imgNo,Model model,HttpSession session) {
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%itemNo = " +itemNo);
		String id = (((LoginVO) session.getAttribute("login")).getId());
	      System.out.println("daslkdnaslkdjalksjdlkasjdklajslkdjaslkdjlaskjdlksaj" +itemNo);
	      System.out.println("daslkdnaslkdjalksjdlkasjdklajslkdjaslkdjlaskjdlksaj" +imgNo);
	      Integer result = service.countWishList(itemNo,id);
	      System.out.println("laksjdklasjdklasjdlkajsl;kdjsalkdjalskjdl;kasdjlkasjdlkasjd result = " + result);
	      
	      
		//if(result == 1 ) return new ResponseEntity<String>("제품 수량이 변경되었습니다." , HttpStatus.OK );
		//else return new ResponseEntity<String>("제품 수량 변경에 실패 했습니다.\n 정보를 확인해주세요." , HttpStatus.INTERNAL_SERVER_ERROR);
		if(result==0 ) {
			  service.insertWishList(id,itemNo,imgNo);
			return new ResponseEntity<String>("위시리스트에 추가되었습니다." , HttpStatus.OK );
			}
		
		else {
			Long findWishListNo = service.findWishListNo(id,itemNo);
			System.out.println("여긴가>>?>?????????????????????????????" + findWishListNo);
			System.out.println("------------------------------------------------ findWishListNo = " + findWishListNo);
			service.deleteWishList(findWishListNo);
			return new ResponseEntity<String>("위시리스트에 삭제되었습니다." , HttpStatus.OK);
	}
	}

}
