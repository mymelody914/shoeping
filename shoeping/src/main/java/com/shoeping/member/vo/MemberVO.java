package com.shoeping.member.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	
	private String id, pw, name, nickName, gradeName, email, phone, zipCode, address, mySize, profilePhoto, statusName;
	
	private Date regDate;
	
	private int gradeNo, statusNo;
}
