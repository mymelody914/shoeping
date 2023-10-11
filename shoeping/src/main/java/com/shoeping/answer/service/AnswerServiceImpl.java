package com.shoeping.answer.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.answer.mapper.AnswerMapper;
import com.shoeping.answer.vo.AnswerVO;

import lombok.Data;

@Service
@Qualifier("answerServiceImpl")
@Data
public class AnswerServiceImpl implements AnswerService {
	
	@Inject
	private AnswerMapper mapper;

	@Override
	public List<AnswerVO> list() {
		// TODO Auto-generated method stub
		return mapper.list();
	}
	
	@Override
	public AnswerVO view(Long qno) {
		// TODO Auto-generated method stub
		return mapper.view(qno);
	}

	@Override
	public Integer write(AnswerVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(AnswerVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(AnswerVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

}
