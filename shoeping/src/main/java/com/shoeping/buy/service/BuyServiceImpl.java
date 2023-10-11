package com.shoeping.buy.service;

import java.util.List;

import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.buy.mapper.BuyMapper;
import com.shoeping.buy.vo.BuyVO;
import com.shoeping.buy.vo.OrderVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("buyServiceImpl")
@Data
public class BuyServiceImpl implements BuyService {
	
	@Inject
	private BuyMapper mapper;

	@Override
	public List<OrderVO> list(PageObject pageObject, String memberId) {
		System.out.println("BuyServiceImpl.list()- vo.memberId : " + memberId);
		pageObject.setTotalRow(mapper.getTotalRow(memberId));
		return mapper.list(pageObject, memberId);
	}

	@Override
	public Integer buy(BuyVO vo) {
		System.out.println("BuyServiceImpl.buy()");
		mapper.buy(vo);
		mapper.cartOrder(vo);
		
		return mapper.deleteCart(vo);
	}
	
	@Override
	public Integer buyDirect(BuyVO vo) {
		System.out.println("BuyServiceImpl.buyDirect()");
		mapper.buyDirect(vo);
		mapper.order(vo);
		
		
		return 1;
	}

	@Override
	public List<BuyVO> buyList(PageObject pageObject) {
		return mapper.buyList(pageObject);
	}

	@Override
	public Integer update(BuyVO vo) {
		return mapper.update(vo);
	}

}
