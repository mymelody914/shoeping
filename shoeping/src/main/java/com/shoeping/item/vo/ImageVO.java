package com.shoeping.item.vo;

import lombok.Data;

@Data
public class ImageVO {

   private Long imageNo;
   private Long itemNo;
   private String fileName;
   // 1- 주이미지(딱 한개만 선택이 되어야만 한다.) 0- 부이미지
   private int pr;
   
   
}