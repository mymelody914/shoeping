package com.shoeping.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.item.service.ItemService;
import com.shoeping.mail.service.MailSendService;
import com.shoeping.member.service.MemberService;
import com.shoeping.member.vo.LoginVO;
import com.shoeping.member.vo.MemberVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Controller
@Data
@RequestMapping("/member")
public class MemberController {

	String path = "/upload/image";

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;

	@Autowired
	@Qualifier("itemServiceImpl")
	private ItemService itemService;

	@Autowired
	private MailSendService mailService;

	// 로그인 폼
	@GetMapping("/login.do")
	public String loginForm() {
		System.out.println("MemberController.loginForm()");

		return "member/login";
	}

	// 로그인 처리
	@PostMapping("/login.do")
	public String login(LoginVO vo, HttpSession session, RedirectAttributes rttr) {
		System.out.println("MemberController.login().vo : " + vo);
		LoginVO loginVO = service.login(vo);

		if (loginVO == null) {
			rttr.addFlashAttribute("msg", "로그인 실패");
			return "redirect:/member/login.do";
		} else if (loginVO.getStatusNo() == 2) {
			
			return "member/dormant";

		} else {

			session.setAttribute("login", loginVO);
			rttr.addFlashAttribute("msg", "로그인 성공");
		}

		String goBackURL = (String) session.getAttribute("goBackURL");

		if (goBackURL == null) {
			return "redirect:/main/main.do";
		} else {
			session.removeAttribute("goBackURL");
			return "redirect:" + goBackURL;
		}
	}

	// 로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		System.out.println("MemberController.logout()");
		session.removeAttribute("login");

		rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");

		return "redirect:/main/main.do";
	}

	// 정보 보기
	@GetMapping("/view.do")
	public String view(String id, HttpSession session, Model model) {
		System.out.println("MemberController.view().id : " + id);

		if (id == null) {
			id = ((LoginVO) session.getAttribute("login")).getId();
			System.out.println("MemberController.view().id : " + id);
		}

		model.addAttribute("vo", service.view(id));

		return "member/view";
	}

	// (관리자) 회원 리스트
	@GetMapping("/list.do")
	public String list(@ModelAttribute PageObject pageObject, Model model) {

		pageObject.setPerPageNum(10L);
		model.addAttribute("list", service.list(pageObject));

		return "member/list";
	}

	// 회원 가입 폼
	@GetMapping("/register.do")
	public String registerForm() {
		System.out.println("MemberController.registerForm()");

		return "member/register";
	}

	@PostMapping("/register.do")
	public String register(MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		System.out.println("MemberController.register().vo : " + vo);

		// 상세주소 받아와서 Address에 합쳐주기
		String detail = request.getParameter("detailAddress");
//		System.out.println("detail : " + detail);
//		System.out.println("birth : " + request.getParameter("birth"));

		vo.setAddress(vo.getAddress() + " " + detail);

		Integer result = service.register(vo);
		if (result == 1) {
			rttr.addFlashAttribute("msg", "회원가입 완료. 로그인 후 이용해 주세요");
			return "redirect:/member/login.do";
		} else {
			rttr.addFlashAttribute("msg", "회원가입 실패. 데이터를 확인해 주세요.");
			return "redirect:/member/login.do";
		}

	}

	@GetMapping("/category.do")
	public String categoryForm(Model model) {
		model.addAttribute("categoryList", itemService.categoryList());

		return "member/category";
	}

	@GetMapping("/brand.do")
	public String brandForm(Model model) {
		model.addAttribute("brandList", itemService.brandList());

		return "member/brand";
	}

	@PostMapping("/changePhoto.do")
	public String changePhoto(MultipartFile changePhoto, String deleteFileName, String query,
			HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		System.out.println("MemberController.changePhoto()");

		// System.out.println("changeFileName = " + changeImage.getOriginalFilename());
		System.out.println("deleteFileName = " + deleteFileName);

		String fileName = FileUtil.upload(path, changePhoto, request);

		String id = request.getParameter("id");
		System.out.println("id : " + id);

		MemberVO vo = new MemberVO();
		vo.setId(id);
		vo.setProfilePhoto(fileName);

		Integer result = service.changePhoto(vo);

		if (result == 1) {
			FileUtil.remove(FileUtil.getRealPath("", deleteFileName, request));
			rttr.addFlashAttribute("msg", "성공적으로 프로필이 변경 되었습니다.");
			return "redirect:/member/view.do?id=" + id;
		}
		return "redirect:/member/view.do?id=" + id;
	}

	// 이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
	}

	@GetMapping("/findID")
	public String findID() {
		System.out.println("MemberController.findID()");

		return "member/findid";
	}

	@GetMapping("/findPW")
	public String findPW() {
		System.out.println("MemberController.findPW()");
		return "member/findpw";
	}

	@GetMapping("/categoryDelete")
	public String categoryDelete(String category) {
		System.out.println("MemberController.categoryDelete().category : " + category);

		service.categoryDelete(category);

		return "redirect:/member/category.do";
	}

	@GetMapping("/brandDelete")
	public String brandDelete(String brand) {
		System.out.println("MemberController.categoryDelete().brand : " + brand);

		service.brandDelete(brand);

		return "redirect:/member/brand.do";
	}

	@PostMapping("/changePW")
	public String changePW(MemberVO vo, RedirectAttributes rttr) {
		System.out.println("MemberController.changePW().vo : " + vo);

		service.changePw(vo);
		rttr.addFlashAttribute("msg", "비밀번호 변경 완료.");

		return "redirect:/member/login.do";
	}
}
