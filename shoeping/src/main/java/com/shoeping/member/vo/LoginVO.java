package com.shoeping.member.vo;

import lombok.Data;

@Data
public class LoginVO {

	private String id, pw, nickName, name, gradeName, statusName;
	
	private int gradeNo, statusNo;
}
