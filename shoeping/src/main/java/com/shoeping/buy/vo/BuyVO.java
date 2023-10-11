package com.shoeping.buy.vo;

import lombok.Data;

@Data
public class BuyVO {
	
	private Long BuyNo;
	private String memberId;
	private String name;
	private String tel;
	private String buyDate;
	private String Address;
	private String Status;
	private int totalPrice;
	
	// 바로 결제를 위한 수집 데이터
	private Long itemNo;
	private String color;
	private String size;
	private int quantity;
}
