package com.shoeping.wishlist.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.wishlist.mapper.WishListMapper;
import com.shoeping.wishlist.vo.WishListVO;

import lombok.Data;


@Service
@Qualifier("wishListServiceImpl")
@Data
public class WishListServiceImpl implements WishListService {

	@Inject
	private WishListMapper mapper;
	
	@Override
	public List<WishListVO> list(String id) {
		// TODO Auto-generated method stub
		System.out.println("wishListServiceImpl - 실행 id = " + id );
		return mapper.list(id);
	}

	@Override
	public Integer deleteWishList(Long wishListNo) {
		// TODO Auto-generated method stub
		System.out.println("wishListServiceImpl - 실행 wishListNo = " + wishListNo );
		return mapper.deleteWishList(wishListNo);
	}

	@Override
	public Long checkWishList(Long itemNo,String id) {
		// TODO Auto-generated method stub
		System.out.println("wishListServiceImpl - 실행 itemNo = " + itemNo );
		return mapper.checkWishList(itemNo,id);
	}

	@Override
	public Integer countWishList(Long itemNo, String id) {
		System.out.println("wishListServiceImpl - 실행 itemNo = " + itemNo + "id = " + id );
		// TODO Auto-generated method stub
		return mapper.countWishList(itemNo,id);
	}

	@Override
	public Integer insertWishList(String id, Long itemNo, Long imageNo) {
		// TODO Auto-generated method stub
		return mapper.insertWishList(id,itemNo,imageNo);
	}

	@Override
	public Long findWishListNo(String id, Long itemNo) {
		// TODO Auto-generated method stub
		return mapper.findWishListNo(id,itemNo);
	}

	@Override
	public Long wishListNumber(Long itemNo) {
		// TODO Auto-generated method stub
		return mapper.wishListNumber(itemNo);
	}

}
