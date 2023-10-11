package com.shoeping.resell.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ResellVO {
	
	private Long resellNo,imageNo;
	private String resellName,resellPrice,color,id,brand,category,resellModelName,dday,fileName,sizes;
private Date regDate;

private MultipartFile prImageFile;
private MultipartFile[] imageFile;
}
