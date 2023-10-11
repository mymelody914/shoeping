package com.shoeping.cart.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.cart.service.CartService;
import com.shoeping.cart.vo.CartVO;

import lombok.Data;
import lombok.extern.java.Log;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/cartAjax")
@Data
@Log
public class CartAjaxController {
	
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService service;
	
	@PostMapping(value = "delete.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> delete(Long cartNo) {
		System.out.println("cartNo = " + cartNo);
		Integer result = service.delete(cartNo);
		System.out.println("cartAjaxController.delete() 실행  no = " + cartNo + "result = " + result);
		
		if(result == 1 ) return new ResponseEntity<String>("장바구니가 변경되었습니다." , HttpStatus.OK );
		else return new ResponseEntity<String>("장바구니 변경에 실패했습니다.\n 정보를 확인해주세요." , HttpStatus.INTERNAL_SERVER_ERROR);
		
		
	}
	@PostMapping(value = "quantityPlus.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> quantityPlus(Long cartNo) {
		System.out.println("cartNo = " + cartNo);
		Integer result = service.quantityPlus(cartNo);
		System.out.println("cartAjaxController.quantity() 실행  cartNo = " + cartNo + "result = " + result);
		
		if(result == 1 ) return new ResponseEntity<String>("제품 수량이 변경되었습니다." , HttpStatus.OK );
		else return new ResponseEntity<String>("제품 수량 변경에 실패 했습니다.\n 정보를 확인해주세요." , HttpStatus.INTERNAL_SERVER_ERROR);
		
		
	}
	
	@PostMapping(value = "quantityMinus.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> quantityMinus(Long cartNo) {
		System.out.println("cartNo = " + cartNo);
		Integer result = service.quantityMinus(cartNo);
		System.out.println("cartAjaxController.quantity() 실행  cartNo = " + cartNo + "result = " + result);
		
		if(result == 1 ) return new ResponseEntity<String>("제품 수량이 변경되었습니다." , HttpStatus.OK );
		else return new ResponseEntity<String>("제품 수량 변경에 실패 했습니다.\n 정보를 확인해주세요." , HttpStatus.INTERNAL_SERVER_ERROR);
		
		
	}
	
	
	@PostMapping(value = "deleteWishList.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> deleteWishList(Long wishListNo) {
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cartNo = " + wishListNo);
		Integer result = service.quantityMinus(wishListNo);
		System.out.println("cartAjaxController.quantity() 실행  cartNo = " + wishListNo + "result = " + result);
		
		if(result == 1 ) return new ResponseEntity<String>("제품 수량이 변경되었습니다." , HttpStatus.OK );
		else return new ResponseEntity<String>("제품 수량 변경에 실패 했습니다.\n 정보를 확인해주세요." , HttpStatus.INTERNAL_SERVER_ERROR);
		
		
	}

	

}
