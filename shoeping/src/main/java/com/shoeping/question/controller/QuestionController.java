package com.shoeping.question.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.answer.service.AnswerService;
import com.shoeping.answer.vo.AnswerVO;
import com.shoeping.member.vo.LoginVO;
import com.shoeping.question.service.QuestionService;
import com.shoeping.question.vo.QuestionVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Controller
@RequestMapping("/question")
@Data
public class QuestionController {
	
	@Autowired
	@Qualifier("questionServiceImpl")
	private QuestionService service;
	
	@Autowired
	@Qualifier("answerServiceImpl")
	private AnswerService answerService;
	
	// question list
	@GetMapping("/managerList.do")
	public String list(Model model, @ModelAttribute PageObject pageObject) {
		
	    List<QuestionVO> list = service.list(pageObject);
	    List<AnswerVO> check = answerService.list();
	    
	    for (QuestionVO question : list) {
    		for (AnswerVO answer : check) {
    			if (answer.getQno() == question.getQno()) {
    				question.setAno(answer.getAno());
    				break; // 같은 qno를 가진 answer를 찾았으면 더 이상 검색하지 않음
    			}
    		}
	    }
	    model.addAttribute("list", list);

	    return "question/managerList";
	}
	
	// question list
	@GetMapping("/myList.do")
	public String mylist(Model model, HttpSession session) {
		String id = ((LoginVO)session.getAttribute("login")).getId();
		
		List<QuestionVO> list = service.mylist(id);
		List<AnswerVO> check = answerService.list();
		
		for (QuestionVO question : list) {
			for (AnswerVO answer : check) {
				if (answer.getQno() == question.getQno()) {
					question.setAno(answer.getAno());
					break; // 같은 qno를 가진 answer를 찾았으면 더 이상 검색하지 않음
				}
			}
		}
		model.addAttribute("list", list);
		
		return "question/myList";
	}
	
	// question write
	@PostMapping("/write.do")
	public String write(QuestionVO vo, HttpSession session, RedirectAttributes rttr) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		System.out.println("QuestionController.write() - vo : " + vo);

		service.write(vo);
		
		// 처리 결과를 리스트로 보낸다.- session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "문의가 등록 되었습니다.");

		return "redirect:/item/view.do?itemNo="+ vo.getItemNo();
	}
	
	// question update
	@PostMapping("/update.do")
	public String update(QuestionVO vo, HttpSession session, RedirectAttributes rttr) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		System.out.println("QuestionController.update() - vo : " + vo);

		service.update(vo);
		
		// 처리 결과를 리스트로 보낸다.- session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "문의가 수정 되었습니다.");

		return "redirect:/item/view.do?itemNo="+ vo.getItemNo();
	}
	
	// question delete
	@GetMapping("/delete.do")
	public String delete(Long itemNo, Long qno, HttpSession session, RedirectAttributes rttr) {
		System.out.println("QuestionController.delete() - qno : " + qno);
		System.out.println("QuestionController.delete() - itemNo : " + itemNo);
		Long gradeNo = (long) ((LoginVO)session.getAttribute("login")).getGradeNo();
		System.out.println("등급? : " + gradeNo);
		
		QuestionVO vo = new QuestionVO();
		if(gradeNo == 1) {
			vo.setId(((LoginVO)session.getAttribute("login")).getId());
		}
		vo.setItemNo(itemNo);
		vo.setQno(qno);
		System.out.println("QuestionController.delete() - vo : " + vo);
		
		service.delete(vo);
		
		// 처리 결과를 리스트로 보낸다.- session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "문의가 삭제 되었습니다.");
		
		if(gradeNo == 9) {
			return "redirect:/question/managerList.do";
		} else {
			return "redirect:/item/view.do?itemNo="+ vo.getItemNo();
		}
	}

}
