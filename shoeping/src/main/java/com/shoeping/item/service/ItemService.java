package com.shoeping.item.service;

import java.util.List;

import com.shoeping.item.vo.BrandVO;
import com.shoeping.item.vo.CategoryVO;
import com.shoeping.item.vo.ImageVO;
import com.shoeping.item.vo.ItemVO;
import com.webjjang.util.page.PageObject;

public interface ItemService {
	   
	   // list
	   public List<ItemVO> list(PageObject pageObject);
	   
	   // view
	   public ItemVO view(Long itemNo);
	   public List<ImageVO> getImageFile(Long itemNo);
	   
	   // write
	   public Integer write(ItemVO vo, List<ImageVO> fileList);
	   
	   // update
	   public Integer update(ItemVO vo);
	   public Integer updateFile(ImageVO vo);
	   
	   // category
	   public List<CategoryVO> categoryList();
	   // brand
	   public List<BrandVO> brandList();
	   
	   // 이미지 바꾸기
	   public Integer changeImage(ImageVO vo);
	   // 이미지 삭제
	   public Integer deleteImage(Long itemNo);
	   
	   // 상세이미지 바꾸기
	   public Integer changeDetailImae(ItemVO vo);
	   
	   // delete
	   public Integer delete(ItemVO vo);
	}
