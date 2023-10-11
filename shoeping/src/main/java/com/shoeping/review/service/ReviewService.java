package com.shoeping.review.service;

import java.util.List;

import com.shoeping.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewService {
	// 리뷰리스트
	public List<ReviewVO> list(PageObject pageObject);
	// 아이템뷰에서 리뷰리스트 보기
	public List<ReviewVO> reviewlist(Long itemNo);

	// 후기 상세보기
	public ReviewVO view(Long review_no);

	// 후기 등록하기
	public Integer write(ReviewVO vo);

	// 후기 수정하기
	public Integer update(ReviewVO vo);

	// 후기글 삭제하기
	public Integer delete(ReviewVO vo);

	// 후기사진바꾸기
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
