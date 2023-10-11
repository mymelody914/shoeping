package com.shoeping.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shoeping.review.mapper.ReviewMapper;
import com.shoeping.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Data
@Qualifier("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	@Inject
	private ReviewMapper mapper;

	@Override
	public List<ReviewVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));

		System.out.println("reviewServiceImpl.view" + pageObject);

		return mapper.list(pageObject);
	}

	@Override
	public Integer write(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.write" + vo);
		return mapper.write(vo);
	}

	@Override
	public Integer update(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.update" + vo);
		System.out.println("업데이트---------------------");
		return mapper.update(vo);
	}

	@Override
	public ReviewVO view(Long review_no) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.view" + review_no);
		return mapper.view(review_no);
	}

	@Override
	public Integer delete(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.delete" + vo);
		return mapper.delete(vo);
	}

	@Override
	public Integer change(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.change" + vo);
		return mapper.change(vo);
	}

	@Override
	public Integer checkLike(ReviewVO vo) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.check" + vo);
		return mapper.checkLike(vo);
	}

	@Override
	public Integer likeInsert(ReviewVO vo) {
		// TODO Auto-generated method stub
		
		System.out.println("reviewServiceImpl.likeInsert"+vo);
		return mapper.likeInsert(vo);
	}

	@Override
	public Integer likeDelete(Integer result) {
		// TODO Auto-generated method stub
		System.out.println("reviewServiceImpl.result"+result);
		return mapper.likeDelete(result);
	}

	@Override
	public List<ReviewVO> reviewlist(Long itemNo) {
		// TODO Auto-generated method stub
		
		return mapper.reviewlist(itemNo);
	}

	@Override
	public List<ReviewVO> orderCk(String id) {
		System.out.println("reviewServiceImpl.orderCk()-----"+id);
		return mapper.orderCk(id);
	}

	@Override
	public Integer checkReview(ReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.checkReview(vo);
	}


}
