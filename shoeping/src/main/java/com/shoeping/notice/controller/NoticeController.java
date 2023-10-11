package com.shoeping.notice.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoeping.notice.service.NoticeService;
import com.shoeping.notice.vo.NoticeVO;

import com.webjjang.util.page.PageObject;

import lombok.Data;


@Controller
@Data
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService service;
	
	@GetMapping("/list.do")
	public String list(Model model,@ModelAttribute PageObject pageObject,HttpServletRequest request,Long no) {
		System.out.println("NoticeController");
		String perPageNumStr = request.getParameter("perPageNum");
		pageObject.setPerPageNum((perPageNumStr == null) ? 10L : Long.parseLong(perPageNumStr));
		System.out.println(pageObject);
		model.addAttribute("list", service.list(pageObject));
		if(no ==null) {
			return "notice/list";
		}else {
		model.addAttribute("vo",service.view(no));
		
		return "notice/list";
	}
	}
	@GetMapping("/view.do")
	public String view(Model model, Long no) {
		System.out.println("공지 글보기");
		System.out.println(no);
		
		NoticeVO vo = service.view(no);
		
		model.addAttribute("vo",service.view(no));
		return "notice/view";
	}
	
	@GetMapping("/update.do")
	public String updateform() {
	
		
		return "notice/update";
	}
	
	@PostMapping("/update.do")
	public String update(NoticeVO vo) throws Exception {
		System.out.println("noticeController.update()"+vo);
		service.update(vo);
		return "redirect:list.do";
	}
	@GetMapping("/write.do")
	public String writeForm() {
		
		return "notice/write";
	}
	
	
	@PostMapping("/write.do")
	public String write(NoticeVO vo, Long perPageNum)throws Exception {
		service.write(vo);
		return "redirect:list.do?perPageNum="+perPageNum;
	}
	
	@GetMapping("/delete.do")
	public String delete(Long notice_no)throws Exception{
		System.out.println("controller----delete------"+notice_no);
		service.delete(notice_no);
		System.out.println("NoticeController--delete________--------");
		
		return "redirect:list.do?notice_no="+notice_no;
	}
	
	
	
}
