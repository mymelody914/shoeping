package com.shoeping.member.service;

import java.util.List;

import com.shoeping.member.vo.LoginVO;
import com.shoeping.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public interface MemberService {

	// 로그인 처리
	public LoginVO login(LoginVO vo);

	// 내 정보 보기
	public MemberVO view(String id);

	// 회원 리스트
	public List<MemberVO> list(PageObject pageObject);

	// 회원 등록(가입)
	public Integer register(MemberVO vo);

	public Integer changeGrade(MemberVO vo);

	public Integer changeStatus(MemberVO vo);

	public Integer changePhoto(MemberVO vo);

	public Integer updateInfo(MemberVO vo);

	// 아이디 찾기
	public String findID(String email);

	public Integer findIDCheck(String email);

	// 회원 리스트 검색
	public List<MemberVO> searchList(PageObject pageObject);

	public Integer changePw(MemberVO vo);

	public Integer categoryAdd(String category);

	public Integer categoryDelete(String category);

	public Integer brandAdd(String brand);

	public Integer brandDelete(String brand);

	// 아이디 중복 체크
	public Integer checkId(String id);

	// 닉네임 중복 체크
	public Integer checkNickname(String nickname);
}
