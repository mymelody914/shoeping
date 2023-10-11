package com.shoeping.review.vo;



import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;


@Data

public class ReviewVO {

	public Integer review_no;
	
	public String title;
	public String content;
	public String fileName; 
	public String itemName;
	public String id;
	public Date writeDate;
	public Long itemNo;
	public Long orderNo;
	public Integer review_like_no;
	public Long count;
	public Long gradeNo;
	public Long reviewck;
	
	
	private MultipartFile prImageFile;

	
	
	public Integer review_like_ck;
	
	
}
