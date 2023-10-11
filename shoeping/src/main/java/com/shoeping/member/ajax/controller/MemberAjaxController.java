package com.shoeping.member.ajax.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.shoeping.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

import com.shoeping.member.service.MemberService;

@RestController
@RequestMapping("/ajax")
@Data
public class MemberAjaxController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;

	@GetMapping(value = "/changeGrade.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> changeGrade(MemberVO vo) {
		System.out.println("MemberAjaxController.changeGrade().vo = " + vo);
		
		Integer result = memberService.changeGrade(vo);
		if (result == 1)
			return new ResponseEntity<String>(
					"회원 [" + vo.getId() + "]의 등급이 " + ((vo.getGradeNo() == 1) ? "일반회원으로" : "관리자로") + " 변경되었습니다.",
					HttpStatus.OK);
		else
			return new ResponseEntity<String>("회원의 등급 변경이 되지 않었습니다.\n정보를 확인해 주세요.", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/changeStatus.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> changeStauts(MemberVO vo) {
		System.out.println("MemberAjaxController.changeGrade().vo = " + vo);
		
		Integer result = memberService.changeStatus(vo);
		if (result == 1)
			return new ResponseEntity<String>(
					"회원 [" + vo.getId() + "]의 상태가 " + ((vo.getStatusNo() == 1) ? "정상으로" : (vo.getStatusNo() == 2)? "휴면으로" : "탈퇴로") + " 변경되었습니다.",
					HttpStatus.OK);
		else
			return new ResponseEntity<String>("회원의 상태 변경이 되지 않었습니다.\n정보를 확인해 주세요.", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/categoryAdd.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> categoryAdd(String category) {
		System.out.println("MemberAjaxController.categoryAdd().category : " + category);
		
		Integer result = memberService.categoryAdd(category);
		if (result == 1)
			return new ResponseEntity<String>(
					"카테고리 " + category + "가 추가 되었습니다.",
					HttpStatus.OK);
		else
			return new ResponseEntity<String>("카테고리가 추가되지 않았습니다. 정보를 확인 해 주세요", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/brandAdd.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> brandAdd(String brand) {
		System.out.println("MemberAjaxController.brandAdd().brand : " + brand);
		
		Integer result = memberService.brandAdd(brand);
		if (result == 1)
			return new ResponseEntity<String>(
					"브랜드 " + brand + " 가 추가 되었습니다.",
					HttpStatus.OK);
		else
			return new ResponseEntity<String>("브랜드가 추가되지 않았습니다. 정보를 확인 해 주세요", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PostMapping(value = "/updateInfo.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> updateInfo(MemberVO vo, HttpServletResponse response, HttpServletRequest request) {
		System.out.println("MemberAjaxController.updateInfo().vo : " + vo);

		vo.setAddress(vo.getAddress() + " " + request.getParameter("detailAddress"));

		Integer result = memberService.updateInfo(vo);

		return ResponseEntity.ok("{\"nickName\": \"" + vo.getNickName() + "\", \"email\": \"" + vo.getEmail()
				+ "\", \"address\": \"" + vo.getAddress() + "\"}");
	}

	@GetMapping(value = "/findIDCheck.do")
	public @ResponseBody Integer findIDCheck(@RequestParam String email) {
		System.out.println("MemberAjaxController.findIDCheck().email : " + email);
		Integer result = 0;

		result = memberService.findIDCheck(email);
		System.out.println("MemberAjaxController.findIDCheck().result : " + result);
		return result;
	}

	@PostMapping(value = "/findID.do")
	public String findID(String email) {
		System.out.println("MemberAjaxController.findID().email : " + email);
		String id = memberService.findID(email);

		return id;
	}
	
	@GetMapping(value = "/searchList.do")
	public List<MemberVO> searchList(PageObject pageObject) {
		List<MemberVO> list = memberService.searchList(pageObject);

		return list;
	}
	
	@RequestMapping(value = "/checkId.do", method = RequestMethod.GET)
	public Integer checkId(String id) {
		System.out.println("MemberAjaxController.checkId().id : " + id);
		Integer result = 0;
		result = memberService.checkId(id);
		return result;
	}
	
	// 닉네임 중복 체크
		@RequestMapping(value = "/checkNickname.do", method = RequestMethod.GET)
		public Integer checkNickname(String nickname) {
			Integer result = 1;
			// 중복 체크 서비스
			// 1 : 중복
			// 0 : 없음
			result = memberService.checkNickname(nickname);
			return result;
		}
}
