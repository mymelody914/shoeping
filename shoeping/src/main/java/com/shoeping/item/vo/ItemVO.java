package com.shoeping.item.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ItemVO {
   
   private Long itemNo;
   private String itemName;
   private Long itemPrice;
   private String detailImage;
   private Date regData;
   private String colors;
   private String sizes;
   private String category;
   private String brand;
   private String membrId;
   private String fileName;
   private Long imageNo;

   // 상세이미지
   private MultipartFile m_detailImage;
   	// 대표 이미지 - 1개
	private MultipartFile prImageFile;
	// 추가 이미지 - 여러개(0~5 사이)
	private MultipartFile[] imageFile;
}