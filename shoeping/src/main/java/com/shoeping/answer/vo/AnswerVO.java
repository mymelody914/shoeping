package com.shoeping.answer.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerVO {
	
	private Long ano;
	private Long qno;
	private String title;
	private String content;
	private Long itemNo;
	private Date writeDate;
	private Long hit;
	
}
