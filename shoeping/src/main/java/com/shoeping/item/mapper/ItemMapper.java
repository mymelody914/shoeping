package com.shoeping.item.mapper;

import java.util.List;
import java.util.Map;

import com.shoeping.item.vo.BrandVO;
import com.shoeping.item.vo.CategoryVO;
import com.shoeping.item.vo.ImageVO;
import com.shoeping.item.vo.ItemVO;
import com.webjjang.util.page.PageObject;

public interface ItemMapper {

	// list
	public List<ItemVO> list(PageObject pageObject);
	// page
	public Long getTotalRow(PageObject pageObject);

	// view
	public ItemVO view(Long itemNo);
	// 이미지 리스트 가져오기.
	public List<ImageVO> getImageFile(Long itemNo);

	// write
	public Integer write(ItemVO vo);
	// file write -> java에서 forEach 처리를 하겠다.
	public Integer writeFile(ImageVO vo);
	
	// 이미지 바꾸기 - imageNo
	public Integer changeImage(ImageVO vo);
	// 이미지 삭제하기 - imageNo
	public Integer deleteImage(Map<String, Object> map);
	
	// 상세 이미지 바꾸기 - itemNO
	public Integer changeDetailImage(ItemVO vo);
	// 상세 이미지 삭제하기 - itemNO
	public Integer deleteDetailImage(ItemVO vo);
	
	// update
	public Integer update(ItemVO vo);

	// category
	public List<CategoryVO> categoryList();
	
	// brand
	public List<BrandVO> brandList();

	// delete
	public Integer delete(ItemVO vo);
}
