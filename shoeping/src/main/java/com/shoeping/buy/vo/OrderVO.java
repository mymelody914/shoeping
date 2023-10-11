package com.shoeping.buy.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderVO {
	
	private Long orderNo;
	private Long buyNo;
	private Long itemNo;
	private String itemName;
	private String buyColor;
	private String buySize;
	private int quantity;
	
	// buyOredr 테이블에 없는 데이터
	private int itemPrice;
	private Date buyDate;
	private String fileName;
	private String memberId;
	private String status;
	private int buyPrice;

}
