package com.shoeping.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoeping.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {

	public List<ReviewVO> list(PageObject pageObject);
	
	public List<ReviewVO> reviewlist(Long itemNo);

	public Long getTotalRow(PageObject pageObject);

	// 후기 상세보기
	public ReviewVO view(Long review_no);

	// 후기 등록하기
	public Integer write(ReviewVO vo);
	
	

	// 후기 수정하기
	public Integer update(ReviewVO vo);

	// 후기 삭제
	public Integer delete(ReviewVO vo);

	// 후기 사진 바꾸기
	public Integer change(ReviewVO vo);

	// 좋아요 확인하기
	public Integer checkLike(ReviewVO vo);

	// 좋아요 추가하기
	public Integer likeInsert(ReviewVO vo);

	// 좋아요 취소하기
	public Integer likeDelete(Integer result);
	
	public List<ReviewVO> orderCk(String id);
		
	
	public Integer checkReview(ReviewVO vo);
	
	
}
