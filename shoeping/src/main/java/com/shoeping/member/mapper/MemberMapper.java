package com.shoeping.member.mapper;

import java.util.List;

import com.shoeping.member.vo.LoginVO;
import com.shoeping.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public interface MemberMapper {

	public LoginVO login(LoginVO vo);

	public MemberVO view(String id);

	public Long getTotalRow(PageObject pageObject);

	public List<MemberVO> list(PageObject pageObject);

	public List<MemberVO> searchList(PageObject pageObject);

	public Integer register(MemberVO vo);

	public Integer changeGrade(MemberVO vo);
	public Integer changeStatus(MemberVO vo);

	public Integer changePhoto(MemberVO vo);

	public Integer updateInfo(MemberVO vo);

	public String findID(String email);

	public Integer findIDCheck(String email);

	public Integer changePw(MemberVO vo);

	public Integer categoryAdd(String category);
	public Integer categoryDelete(String category);
	
	public Integer brandAdd(String brand);
	public Integer brandDelete(String brand);
	
	public Integer checkId(String id);
	public Integer checkNickname(String nickname);
}
