package com.shoeping.question.mapper;

import java.util.List;

import com.shoeping.question.vo.QuestionVO;
import com.webjjang.util.page.PageObject;

public interface QuestionMapper {
	
	// question list
	public List<QuestionVO> list(PageObject pageObject);
	// question page
	public Long getTotalRow(PageObject pageObject);
	
	// question list = 내 문의
	public List<QuestionVO> mylist(String id);
	
	// question list = 상세페이지
	public List<QuestionVO> qlist(Long itemNo);
	
	// question view
	public QuestionVO view(QuestionVO questionVO);
	
	// question write
	public Integer write(QuestionVO vo);
	
	// question update
	public Integer update(QuestionVO vo);
	
	// question delete
	public Integer delete(QuestionVO vo);

}
