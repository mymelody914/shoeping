package com.shoeping.item.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.item.mapper.ItemMapper;
import com.shoeping.item.vo.BrandVO;
import com.shoeping.item.vo.CategoryVO;
import com.shoeping.item.vo.ImageVO;
import com.shoeping.item.vo.ItemVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("itemServiceImpl")
@Data
public class ItemServiceImpl implements ItemService {

	@Inject
	private ItemMapper mapper;

	@Override
	public List<ItemVO> list(PageObject pageObject) {
		System.out.println("ItemServiceImpl.list()");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public ItemVO view(Long itemNo) {
		// TODO Auto-generated method stub
		return mapper.view(itemNo);
	}
	@Override
	public List<ImageVO> getImageFile(Long itemNo) {
		// TODO Auto-generated method stub
		return mapper.getImageFile(itemNo);
	}

	@Override
	public Integer changeImage(ImageVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeImage(vo);
	}
	
	@Override
	public Integer write(ItemVO vo, List<ImageVO> fileList) {
		// 1. vo 저장
		mapper.write(vo);
		// for문을 이용해서 데이터 저장 - 반드시 no를 세팅해야 한다. vo.no -> fileVO.no
		for(ImageVO fileVO : fileList) {
			fileVO.setItemNo(vo.getItemNo());
			mapper.writeFile(fileVO);
		}
		return 1;
	}
	
	@Override
	public Integer deleteImage(Long imageNo) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("imageNo", imageNo);
		// mapper로 넘길 때 파라메터를 한개로 넘겨야 한다. - 변수 : 변수 이름, vo - vo 안에 프로퍼티, map - key
		return mapper.deleteImage(map);
	}

	@Override
	public Integer changeDetailImae(ItemVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeDetailImage(vo);
	}
	
	@Override
	public Integer update(ItemVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer updateFile(ImageVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CategoryVO> categoryList() {
		System.out.println("ItemServiceImpl().category()");
		return mapper.categoryList();
	}

	@Override
	public List<BrandVO> brandList() {
		System.out.println("ItemServiceImpl().brand()");
		return mapper.brandList();
	}

	@Override
	public Integer delete(ItemVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}
}
