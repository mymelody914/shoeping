package com.shoeping.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.member.mapper.MemberMapper;
import com.shoeping.member.vo.LoginVO;
import com.shoeping.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Data
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberMapper mapper;
	
	@Override
	public LoginVO login(LoginVO vo) {
		// TODO Auto-generated method stub
		return mapper.login(vo);
	}

	@Override
	public MemberVO view(String id) {
		// TODO Auto-generated method stub
		return mapper.view(id);
	}

	@Override
	public List<MemberVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public Integer register(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.register(vo);
	}

	@Override
	public Integer changeGrade(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeGrade(vo);
	}

	@Override
	public Integer changePhoto(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changePhoto(vo);
	}

	@Override
	public Integer updateInfo(MemberVO vo) {
		// TODO Auto-generated method stub
		System.out.println("MemberServiceImpl.updateInfo().vo : " + vo);
		
		return mapper.updateInfo(vo);
	}

	@Override
	public String findID(String email) {
		// TODO Auto-generated method stub
		System.out.println("MemberServiceImpl.findID().email : " + email);
		
		return mapper.findID(email);
	}

	@Override
	public Integer findIDCheck(String email) {
		// TODO Auto-generated method stub
		System.out.println("MemberServiceImpl.findID().email : " + email);
		
		return mapper.findIDCheck(email);
	}

	@Override
	public List<MemberVO> searchList(PageObject pageObject) {
		// TODO Auto-generated method stub
		
		return mapper.searchList(pageObject);
	}

	@Override
	public Integer changePw(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changePw(vo);
	}

	@Override
	public Integer changeStatus(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeStatus(vo);
	}

	@Override
	public Integer categoryAdd(String category) {
		// TODO Auto-generated method stub
		return mapper.categoryAdd(category);
	}

	@Override
	public Integer categoryDelete(String category) {
		// TODO Auto-generated method stub
		return mapper.categoryDelete(category);
	}

	@Override
	public Integer brandAdd(String brand) {
		// TODO Auto-generated method stub
		return mapper.brandAdd(brand);
	}

	@Override
	public Integer brandDelete(String brand) {
		// TODO Auto-generated method stub
		return mapper.brandDelete(brand);
	}

	@Override
	public Integer checkId(String id) {
		return mapper.checkId(id);
	}

	@Override
	public Integer checkNickname(String nickname) {
		return mapper.checkNickname(nickname);
	}


}
