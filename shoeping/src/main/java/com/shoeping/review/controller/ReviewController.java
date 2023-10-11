package com.shoeping.review.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.member.vo.LoginVO;
import com.shoeping.review.service.ReviewService;
import com.shoeping.review.vo.ReviewVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Data
@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService service;
	String path = "/upload/image";
	
	
	
	@GetMapping("/list.do")
	public String list(PageObject pageObject,Model model,Long no) {
	System.out.println("controller-----------");	

		model.addAttribute("list",service.list(pageObject));
	
		System.out.println(model);
		return "review/list";
	}
	//아이템에 맞는 리스트 출력하기
	@GetMapping("/reviewlist.do")
	public String reviewlist(PageObject pageObject , Model model , Long itemNo) {
		System.out.println("reviewController.reviewlist()");
		
		model.addAttribute("reviewlist",service.reviewlist(itemNo));
		
		System.out.println(model);
		return "review/reviewlist";
	}
	@GetMapping("/write.do")
	public String writeForm(Model model , HttpServletRequest request,HttpSession session) {
		
		
		String id = (((LoginVO)session.getAttribute("login")).getId());
		List<ReviewVO> list = service.orderCk(id);
		
		System.out.println(list);
		
		model.addAttribute("writeList",list);
		
		return "review/write";
	}
	@PostMapping("/write.do")
	public String write(ReviewVO vo,HttpServletRequest request,HttpSession session,RedirectAttributes rttr)throws Exception {
		System.out.println("Controller------------write");
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		String fileName = FileUtil.upload(path, vo.getPrImageFile(), request);
		vo.setFileName(fileName);
		
		System.out.println("reviewController.write()"+vo);
	Integer result=	service.checkReview(vo);
	System.out.println(vo+"----------------------------------------");
	System.out.println(result);
		if(result==1) {
			rttr.addFlashAttribute("msg","이미리뷰가 등록되어있는 상품입니다.");
			return "redirect:list.do";
			
		}else {
			
			service.write(vo);
			rttr.addFlashAttribute("msg","리뷰등록완료");
		}
		
		return "redirect:list.do";
	}
	@GetMapping("/view.do") 
	public String view(Long review_no, Model model) {
	System.out.println("여기요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	ReviewVO vo =service.view(review_no);
	model.addAttribute("vo",vo);
		model.addAttribute("view",service.view(review_no));
	System.out.println(review_no);
	System.out.println(vo);
		return "review/view";
	}
	
	
	@GetMapping("/update.do")
	public String updateForm(Model model,Long review_no,HttpSession session,ReviewVO vo) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
	System.out.println("d업데이트 폼ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		model.addAttribute("vo",service.view(review_no));
		
		return "review/update";
	}
	@PostMapping("/update.do")
	public String update(ReviewVO vo,HttpSession session) {
		System.out.println("업데이트 컨트롤러 2222222222222222222");
		System.out.println("reviewController.update()"+vo);
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		service.update(vo);
		return "redirect:view.do?review_no="+vo.getReview_no();
	}
	@GetMapping("/delete.do")
	public String delete(ReviewVO vo,HttpSession session) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		vo.setGradeNo((long) ((LoginVO)session.getAttribute("login")).getGradeNo());
		
		System.out.println("reviewController.delete()"+vo);
		service.delete(vo);
		return "redirect:list.do";
	}
	@PostMapping("/change.do")
	public String change(ReviewVO vo,HttpSession session) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		System.out.println("reviewController.change()"+vo);
		String prFileName =  path+"/"+vo.fileName;
		vo.setFileName(prFileName);
		System.out.println(vo.fileName);
		System.out.println("reviewController.change()"+vo);
		service.change(vo);
		return "redirect:list.do";
	}
	
	@GetMapping("/checkLike.do")
	public String checkLike(ReviewVO vo,HttpSession session) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		System.out.println(vo);
		Integer result = (Integer) service.checkLike(vo);
		if(result !=null) {
			//delete
			service.likeDelete(result);
			System.out.println("reviewControlelr.likeDelete");
		}else {
			//insert
			service.likeInsert(vo);
			System.out.println("reviewControlelr.likeInsert");
		};
			
		return "redirect:list.do";
	}
	

	
	
}
