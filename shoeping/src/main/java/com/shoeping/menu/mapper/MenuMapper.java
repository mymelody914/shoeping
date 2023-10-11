package com.shoeping.menu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.item.vo.ItemVO;
import com.webjjang.util.page.PageObject;

public interface MenuMapper {

	public List<ItemVO> list(@Param("pageObject")PageObject pageObject, @Param("category") String category, @Param("brand")String brand);

	public long getTotalRow(@Param("pageObject")PageObject pageObject,@Param("category") String category, @Param("brand")String brand);
}
