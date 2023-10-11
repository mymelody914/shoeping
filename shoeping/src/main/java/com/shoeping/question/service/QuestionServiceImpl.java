package com.shoeping.question.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.question.mapper.QuestionMapper;
import com.shoeping.question.vo.QuestionVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("questionServiceImpl")
@Data
public class QuestionServiceImpl implements QuestionService {
	
	@Inject
	private QuestionMapper mapper;

	@Override
	public List<QuestionVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public QuestionVO view(QuestionVO questionVO) {
		// TODO Auto-generated method stub
		return mapper.view(questionVO);
	}

	@Override
	public Integer write(QuestionVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(QuestionVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(QuestionVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

	@Override
	public List<QuestionVO> qlist(Long itemNo) {
		// TODO Auto-generated method stub
		return mapper.qlist(itemNo);
	}

	@Override
	public List<QuestionVO> mylist(String id) {
		// TODO Auto-generated method stub
		return mapper.mylist(id);
	}

}
