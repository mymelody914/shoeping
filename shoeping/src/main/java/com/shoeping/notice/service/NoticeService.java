package com.shoeping.notice.service;

import java.util.List;

import com.shoeping.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

public interface NoticeService {

	
	public List<NoticeVO> list(PageObject pageObject);
	
	
	//공지보기
	public NoticeVO view(Long no);
	
	//공지수정
	public Integer update(NoticeVO vo);
	
	public Integer write(NoticeVO vo);
	
	public Integer delete(Long notice_no);
}
