package com.shoeping.wishlist.service;

import java.util.List;
import com.shoeping.wishlist.vo.WishListVO;



public interface WishListService {
	
	public List<WishListVO> list(String id);
	
	public Integer deleteWishList(Long wishListNo);
	
	public Long checkWishList(Long itemNo, String id);
	
	public Integer countWishList(Long itemNo,String id);
	
	public Integer insertWishList(String id,Long itemNo,Long imageNo);
	
	public Long findWishListNo(String id,Long itemNo);

	public Long wishListNumber(Long itemNo);

}
