package com.shoeping.wishlist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.wishlist.vo.WishListVO;

public interface WishListMapper {
	
	public List<WishListVO> list(String id);
	
	public Integer deleteWishList(Long wishListNo);
	
	public Long checkWishList(@Param("itemNo") Long itemNo,@Param("id")String id);
	
	public Integer countWishList(@Param("itemNo") Long itemNo,@Param("id")String id);

	public Integer insertWishList(@Param("id")String id, @Param("itemNo")Long itemNo, @Param("imageNo")Long imageNo);

	public Long findWishListNo(@Param("id")String id,@Param("itemNo")Long itmeNo);

	public Long wishListNumber(Long itemNo);
}
