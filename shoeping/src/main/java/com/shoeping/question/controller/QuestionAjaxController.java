package com.shoeping.question.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shoeping.answer.service.AnswerService;
import com.shoeping.member.vo.LoginVO;
import com.shoeping.question.service.QuestionService;
import com.shoeping.question.vo.QuestionVO;

import lombok.Data;

@Controller
@RequestMapping("/questionajax")
@Data
public class QuestionAjaxController {
	
	@Autowired
	@Qualifier("questionServiceImpl")
	private QuestionService service;
	
	@Autowired
	@Qualifier("answerServiceImpl")
	private AnswerService answerService;
	
	// question view
	@GetMapping("/view.do")
	@ResponseBody
	public Map<String, Object> view(Long qno, String pw, HttpSession session, ServletRequest request) {
		System.out.println("QuestionAjaxController.view() - qno/pw : " + qno + "/" + pw);
		Map<String, Object> result = new HashMap<String, Object>();
		HttpServletRequest req = (HttpServletRequest)request;
		session = req.getSession();
		Integer gradeNo = null;
		String id = null;
		// 수정, 삭제, 답변버튼 등을 숨기기 위한 처리
		if(session != null && session.getAttribute("login") != null) {
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			if(loginVO != null) {
				gradeNo = loginVO.getGradeNo();
				id = loginVO.getId();
			}
	        System.out.println("QuestionAjaxController.view() - id/gradeNo : " + id + "/" + gradeNo);
	        result.put("login", id);
	        if(gradeNo == 9) {
	        	// System.out.println("등급넘버 9");
	        	result.put("grade", gradeNo);
	        }
	    } else {
	        System.out.println("로그인 안함");
	    }
		
		// vo에 담아서 넘기기
		QuestionVO questionVO = new QuestionVO();
		questionVO.setQno(qno);
		// 비밀글을 위한 처리
		if(pw.equals("1")) {
			// 관리자가 아닌 로그인이 되어 있을때 실행
			if(((LoginVO)session.getAttribute("login")).getGradeNo() != 9) {
				questionVO.setId(((LoginVO)session.getAttribute("login")).getId());
				questionVO.setPw(pw);
			}
			System.out.println("vo에 들어있는 값들은?????????????????????????" + questionVO);
			result.put("vo", service.view(questionVO));
			if(service.view(questionVO) == null) {
				result.put("voview", "볼수없음");
			}
			
		} else {
			result.put("vo", service.view(questionVO));
		}
		
		// 답변이 없을때 처리
		if(answerService.view(qno) != null) {
			result.put("answerVO", answerService.view(qno));
		} else {
			result.put("answerVO", qno);
		}
		System.out.println("뷰값???????????????????????" + result);
		return result;
	}
	
}
