package com.shoeping.question.service;

import java.util.List;

import com.shoeping.question.vo.QuestionVO;
import com.webjjang.util.page.PageObject;

public interface QuestionService {
	
	// question list
	public List<QuestionVO> list(PageObject pageObject);
	
	// question list
	public List<QuestionVO> mylist(String id);
	
	// question list = 상세페이지용
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
