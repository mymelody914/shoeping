package com.shoeping.cart.vo;

import lombok.Data;

@Data
public class CartVO {
	private String id,itemName,color,buysize,fileName,brand;
	private Long cartNo,itemNo,itemPrice,imageNo;
	private Integer quantity,pr;

}
