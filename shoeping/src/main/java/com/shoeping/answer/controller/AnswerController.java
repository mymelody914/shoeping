package com.shoeping.answer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.answer.service.AnswerService;
import com.shoeping.answer.vo.AnswerVO;

import lombok.Data;

@Controller
@RequestMapping("/answer")
@Data
public class AnswerController {
	
	@Autowired
	@Qualifier("answerServiceImpl")
	private AnswerService answerService;
	
	@PostMapping("/write.do")
	public String write(AnswerVO vo, RedirectAttributes rttr) {
		
		System.out.println("AnswerController.write() - vo : " + vo);

		answerService.write(vo);
		
		// 처리 결과를 리스트로 보낸다.- session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "답변이 등록 되었습니다.");
		
		return "redirect:/question/managerList.do";
	}
	
	@PostMapping("/update.do")
	public String update(AnswerVO vo, RedirectAttributes rttr) {
		
		System.out.println("AnswerController.update() - vo : " + vo);
		
		answerService.update(vo);
		
		// 처리 결과를 리스트로 보낸다.- session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "답변이 수정 되었습니다.");
		
		return "redirect:/question/managerList.do";
	}
	
	@GetMapping("/delete.do")
	public String delete(AnswerVO vo, RedirectAttributes rttr) {
		
		System.out.println("AnswerController.delete() - vo : " + vo);
		
		answerService.delete(vo);
		
		// 처리 결과를 리스트로 보낸다.- session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "답변이 삭제 되었습니다.");
		
		return "redirect:/question/managerList.do";
	}

}
