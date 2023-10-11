package com.shoeping.cart.service;

import java.util.List;

import com.shoeping.cart.vo.CartVO;

public interface CartService {
	
	
	// 카트 리스트
	public List<CartVO> list(String id);
	
	// 아작스 카트리스트 삭제 
	public Integer delete(Long cartNo);

	public Integer quantityPlus(Long cartNo);

	public Integer quantityMinus(Long cartNo);

	public Integer insertCart(String color,String size, Long itemNo, Long imageNo, Long quantity, String id);

}
