package com.shoeping.resell.service;

import java.util.List;

import com.shoeping.resell.vo.ResellFileVO;
import com.shoeping.resell.vo.ResellVO;

public interface ResellService {
	
	public List<ResellVO> list();

	public ResellVO getImageFile();

	public Integer write(ResellVO vo, ResellFileVO fileVO);

	public List<ResellVO> getCategory();

	public List<ResellVO> getBrand();

	public ResellVO view(ResellVO vo);

	public Integer update(ResellVO vo, ResellFileVO fileVO);

	public Integer delete(ResellVO vo);
}
