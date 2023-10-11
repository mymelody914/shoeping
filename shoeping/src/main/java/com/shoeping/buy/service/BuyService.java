package com.shoeping.buy.service;

import java.util.List;


import com.shoeping.buy.vo.BuyVO;
import com.shoeping.buy.vo.OrderVO;
import com.webjjang.util.page.PageObject;

public interface BuyService {
	
	public List<OrderVO> list(PageObject pageObject,String memberId);
	
	public Integer buy(BuyVO vo);
	
	public Integer buyDirect(BuyVO vo);
	
	// 관리자 주문 리스트
	public List<BuyVO> buyList(PageObject pageObject);
	
	// status 수정
	public Integer update(BuyVO vo);

}
