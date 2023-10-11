package com.shoeping.question.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QuestionVO {
	
	private Long qno;
	private String title;
	private String content;
	private String id;
	private Long itemNo;
	private Date writeDate;
	private Long hit;
	
	// 답변이 있다면
	private Long ano;
	// 비밀번호가 있다면
	private String pw;

}
