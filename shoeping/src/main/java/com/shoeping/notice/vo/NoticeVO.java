package com.shoeping.notice.vo;

import java.util.Date;

import lombok.Data;

@Data

public class NoticeVO {
	public Long notice_no;
	public String title;
	public String content;
	public Date writeDate;
}
