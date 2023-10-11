package com.shoeping.resell.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.resell.vo.ResellFileVO;
import com.shoeping.resell.vo.ResellVO;

public interface ResellMapper {
	
	public List<ResellVO> list();

	public ResellVO getImageFile();

	public Integer write(ResellVO vo);

	public void writeFile(ResellFileVO fileVO);

	public List<ResellVO> getCategory();

	public List<ResellVO> getBrand();

	public ResellVO view(ResellVO vo);

	public Integer update(@Param("vo")ResellVO vo);

	public Integer changeImage(ResellFileVO fileVO);

	public Integer delete(ResellVO vo);

}
