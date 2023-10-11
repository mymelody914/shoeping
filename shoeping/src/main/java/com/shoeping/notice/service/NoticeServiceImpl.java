package com.shoeping.notice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.notice.mapper.NoticeMapper;
import com.shoeping.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;
@Service
@Data
@Qualifier("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {
	@Inject
	private NoticeMapper mapper;

	@Override
	public List<NoticeVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		System.out.println("serviceImpl");
		System.out.println(mapper.getTotalRow(pageObject));
		
		//pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public NoticeVO view(Long no) {
		// TODO Auto-generated method stub
		return mapper.view(no);
	}

	@Override
	public Integer update(NoticeVO vo) {
		// TODO Auto-generated method stub
		System.out.println("vo"+vo.getNotice_no());
		return mapper.update(vo);
	}

	@Override
	public Integer write(NoticeVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer delete(Long notice_no) {
		// TODO Auto-generated method stub
		System.out.println("serviceDelete-----------------");
		return mapper.delete(notice_no);
	}

}
