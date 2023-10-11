package com.shoeping.resell.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.resell.mapper.ResellMapper;
import com.shoeping.resell.vo.ResellFileVO;
import com.shoeping.resell.vo.ResellVO;

import lombok.Data;
import lombok.extern.java.Log;


@Service
@Qualifier("resellServiceImpl")
@Data
@Log
public class ResellServiceImpl implements ResellService{
	
	@Inject
	private ResellMapper mapper;

	@Override
	public List<ResellVO> list() {
		// TODO Auto-generated method stub
		
		return mapper.list();
	}

	@Override
	public ResellVO getImageFile() {
		// TODO Auto-generated method stub
		return mapper.getImageFile();
	}

	@Override
	public Integer write(ResellVO vo ,ResellFileVO fileVO) {
		// TODO Auto-generated method stub
		mapper.write(vo);
		fileVO.setResellNo(vo.getResellNo());
		System.out.println(fileVO);
		mapper.writeFile(fileVO);
		return 1;
	}

	@Override
	public List<ResellVO> getCategory() {
		// TODO Auto-generated method stub
		
		return mapper.getCategory();
	}

	@Override
	public List<ResellVO> getBrand() {
		// TODO Auto-generated method stub
		return mapper.getBrand();
	}

	@Override
	public ResellVO view(ResellVO vo) {
		// TODO Auto-generated method stub
		return mapper.view(vo);
	}

	@Override
	public Integer update(ResellVO vo, ResellFileVO fileVO) {
		// TODO Auto-generated method stub
		mapper.changeImage(fileVO);
		return mapper.update(vo);
	}

	@Override
	public Integer delete(ResellVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

}
