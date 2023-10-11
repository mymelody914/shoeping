package com.shoeping.buy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.buy.vo.BuyVO;
import com.shoeping.buy.vo.OrderVO;
import com.webjjang.util.page.PageObject;

public interface BuyMapper {
	
	// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 결제 리스트 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
	public List<OrderVO> list(@Param("pageObject") PageObject pageObject,@Param("memberId") String memberId);
	public Long getTotalRow(String memberId);
	
	// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 카트 결제 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
	// buy
	public Integer buy(BuyVO vo);
	// order
	public Integer cartOrder(BuyVO vo);
	// deleteCart
	public Integer deleteCart(BuyVO vo);
	
	// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 바로 결제 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
	//buyDirect
	public Integer buyDirect(BuyVO vo);
	// order
	public Integer order(BuyVO vo);
	
	// 관리자 주문 리스트
	public List<BuyVO> buyList(PageObject pageObject);
	
	// status 수정
	public Integer update(BuyVO vo);
}
