package com.shoeping.menu.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.item.vo.ItemVO;
import com.webjjang.util.page.PageObject;

public interface MenuService {

	public List<ItemVO> list(@Param("pageObject") PageObject pageObject, @Param("category") String category,@Param("brand") String brand);
	
}
