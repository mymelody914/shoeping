package com.shoeping.cart.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.cart.mapper.CartMapper;
import com.shoeping.cart.vo.CartVO;

import lombok.Data;
import lombok.extern.java.Log;


@Service
@Qualifier("cartServiceImpl")
@Data
@Log
public class CartServiceImpl implements CartService {
	
	
	@Inject
	private CartMapper mapper;

	@Override
	public List<CartVO> list(String id) {
		// TODO Auto-generated method stub
		log.info("CartServiceImpl.list() - 리스트 실행 : id =  " +id);
		return mapper.list(id);
	}

	@Override
	public Integer delete(Long cartNo) {
		System.out.println("CartServiceImpl.delete() - 삭제 실행 no = " + cartNo);
		return mapper.delete(cartNo);
	}

	@Override
	public Integer quantityPlus(Long cartNo) {
		// TODO Auto-generated method stub
		System.out.println("CartServiceImpl.quantity() - 수량 추가 실행 CartNo = " + cartNo);
		return mapper.quantityPlus(cartNo);
	}

	@Override
	public Integer quantityMinus(Long cartNo) {
		// TODO Auto-generated method stub
		return mapper.quantityMinus(cartNo);
	}

	@Override
	public Integer insertCart(String color, String size, Long itemNo, Long imageNo,Long quantity, String id) {
		return mapper.insertCart(color,size,itemNo,imageNo,quantity,id);
		// TODO Auto-generated method stub
		
	}
	
	

}
