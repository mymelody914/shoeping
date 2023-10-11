package com.shoeping.resell.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.member.vo.LoginVO;
import com.shoeping.resell.service.ResellService;
import com.shoeping.resell.vo.ResellFileVO;
import com.shoeping.resell.vo.ResellVO;
import com.webjjang.util.file.FileUtil;

import lombok.Data;

@Controller
@RequestMapping("/resell")
@Data
public class ResellController {
	
	String path="/upload/image";
	
	@Autowired
	@Qualifier("resellServiceImpl")
	private ResellService service;
	
	@GetMapping("resell.do")
	public String resell() {
		System.out.println("리셀로가자");
		return "resell/resell";
	}
	@GetMapping("resellList.do")
	public String resellList(Model model) {
		System.out.println("리셀리스트 ㄱ ");
		model.addAttribute("list",service.list());
		return "resell/resellList";
	}
	@GetMapping("write.do")
	public String writeForm(Model model) {
		System.out.println("write.do- 폼으로가기 ");
		
		
	model.addAttribute("category",service.getCategory());
	model.addAttribute("brandList",service.getBrand());
	
		return "resell/write";
	}
	@PostMapping("write.do")
	public String write(ResellVO vo, HttpSession session,HttpServletRequest request) throws Exception {
		System.out.println("write.do- 처리하러 가기 ");
		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		
		System.out.println("올릴때 나의 pr 이미지 파일은? : " + vo.getPrImageFile().getOriginalFilename());
		
		String FileName = FileUtil.upload(path, vo.getPrImageFile() , request);
		
		ResellFileVO fileVO = new ResellFileVO();
		fileVO.setFileName(FileName);
		fileVO.setPr(1);
		
		System.out.println("ResellController.write() - 업로드된 파일 정보"+fileVO);
		
		
		service.write(vo,fileVO);
		
		Thread.sleep(500);
		return "redirect:resellList.do";
	}
	
	@GetMapping("view.do")
	public String viewForm(ResellVO vo, Model model) {
		System.out.println("viewForm ---------------");
		
		model.addAttribute("vo",service.view(vo)) ;
		return "resell/view";
	}
	
	@GetMapping("update.do")
	public String updateForm(ResellVO vo ,Model model) {
		System.out.println(vo);
		model.addAttribute("category",service.getCategory());
		model.addAttribute("brandList",service.getBrand());
		model.addAttribute("vo",service.view(vo)) ;
		return "resell/update";
	}
	@PostMapping("update.do")
	public String update(ResellVO vo ,String deleteFileName,Model model,HttpSession session,HttpServletRequest request) throws Exception {
		System.out.println("update.do- 처리하러 가기 ");
		//vo.setId(((LoginVO) session.getAttribute("login")).getId());
		vo.setId("admin");
		System.out.println("올릴때 나의 pr 이미지 파일은? : " + vo.getPrImageFile().getOriginalFilename());
		System.out.println("걍vo 다 뽑아버려 !@#!$%@#%@%$#%@#%@$@$@#$@$@#$@# + "+ vo);
		String FileName = FileUtil.upload(path, vo.getPrImageFile() , request);
		
		ResellFileVO fileVO = new ResellFileVO();
		fileVO.setFileName(FileName);
		fileVO.setImageNo(vo.getImageNo());
		fileVO.setPr(1);
		
		System.out.println("ResellController.update() - 업로드된 파일 정보"+fileVO);
		System.out.println("삭제할 파일 네임은? : " + deleteFileName);
		service.update(vo,fileVO);
		
		FileUtil.remove(FileUtil.getRealPath("",deleteFileName, request));
		
		Thread.sleep(500);
		return "redirect:resellList.do";
	}
	
	@GetMapping("delete.do")
	// no만 넘어오는데 vo를 쓰는 이유 : no를 받으면 vo를 생성하고 no를 세팅해야 하는 코드를 작성해야함.
	public String delete(ResellVO vo,HttpSession session,RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		System.out.println("ImageController.delete(). vo " + vo);
		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		
		
		//DB의 글삭제 -> ImageFile 테이블의 같은 글 이미지 데이터들이 삭제된다. 
		Integer result = service.delete(vo);
		System.out.println("------------------------------------------------------");
		if(result == 1) {
			
				FileUtil.remove(FileUtil.getRealPath("",vo.getFileName(), request));
			
			rttr.addFlashAttribute("msg", "리셀 게시판 (글번호: "+vo.getResellNo()+ ") 삭제가 완료되었습니다. ");
		}else {
			// modal 창에서 줄바꿈은 br태그로 해야함 alert는 \n으로 해야함.
			rttr.addFlashAttribute("msg", "리셀 게시판 (글번호: "+vo.getResellNo()+ ") 이 삭제되지 않았습니다. " + "<br>정보를 확인해 주세요.");
			
		}
		 return "redirect:resellList.do"; 
	}

}
