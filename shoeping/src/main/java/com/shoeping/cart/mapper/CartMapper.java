package com.shoeping.cart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.cart.vo.CartVO;

public interface CartMapper {
	
	public List<CartVO> list(String id);
	
	public Integer delete(Long cartNo);

	public Integer quantityPlus(Long cartNo);

	public Integer quantityMinus(Long cartNo);

	public Integer insertCart(@Param("color") String color, @Param("size") String size, @Param("itemNo") Long itemNo, @Param("imageNo") Long imageNo,@Param("quantity") Long quantity, @Param("id") String id);

}
