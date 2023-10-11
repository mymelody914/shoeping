package com.shoeping.answer.service;

import java.util.List;

import com.shoeping.answer.vo.AnswerVO;

public interface AnswerService {
	
	// answer list
	public List<AnswerVO> list();
	
	// answer view
	public AnswerVO view(Long qno);
	
	// answer write
	public Integer write(AnswerVO vo);
	
	// answer update
	public Integer update(AnswerVO vo);
	
	// answer delete
	public Integer delete(AnswerVO vo);

}
