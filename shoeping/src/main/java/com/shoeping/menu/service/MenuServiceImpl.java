package com.shoeping.menu.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import com.shoeping.item.vo.ItemVO;
import com.shoeping.menu.mapper.MenuMapper;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("menuServiceImpl")
@Data
public class MenuServiceImpl implements MenuService{
	
	
	@Inject
	private MenuMapper mapper;

	@Override
	public List<ItemVO> list(PageObject pageObject,String category,String brand) {
		// TODO Auto-generated method stub
		System.out.println("sdadasdsadasdsadasdadasd");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject,category,brand));
		System.out.println(pageObject);
		return mapper.list(pageObject,category,brand);
	}

}
