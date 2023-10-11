package com.shoeping.notice.mapper;

import java.util.List;

import com.shoeping.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

public interface NoticeMapper {
	public  List<NoticeVO> list(PageObject pageObject);
	public Long getTotalRow(PageObject pageObject);
	
	public NoticeVO view(Long no);
	
	public Integer update(NoticeVO vo);
	
	public Integer write(NoticeVO vo);
	
	public Integer delete(Long notice_no);
}
