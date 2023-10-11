package com.shoeping.item.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoeping.answer.service.AnswerService;
import com.shoeping.answer.vo.AnswerVO;
import com.shoeping.item.service.ItemService;
import com.shoeping.item.vo.ImageVO;
import com.shoeping.item.vo.ItemVO;
import com.shoeping.member.vo.LoginVO;
import com.shoeping.question.service.QuestionService;
import com.shoeping.question.vo.QuestionVO;
import com.shoeping.review.service.ReviewService;
import com.shoeping.wishlist.service.WishListService;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Controller
@RequestMapping("/item")
@Data
public class ItemController {

	@Autowired
	@Qualifier("itemServiceImpl")
	private ItemService service;

	@Autowired
	@Qualifier("wishListServiceImpl")
	private WishListService wishListService;

	// review
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;

	// qna
	@Autowired
	@Qualifier("questionServiceImpl")
	private QuestionService questionService;

	@Autowired
	@Qualifier("answerServiceImpl")
	private AnswerService answerService;
	
	// 저장하려는 파일의 위치
	String path = "/upload/image";

	@GetMapping("list.do")
	public String list(Model model, @ModelAttribute PageObject pageObject, HttpSession session ,HttpServletRequest request) {
		String perPageNumStr = request.getParameter("perPageNum");
		pageObject.setPerPageNum((perPageNumStr == null)?9L:Long.parseLong(perPageNumStr));
		System.out.println("ItemController.list()");
		List<ItemVO> list = service.list(pageObject);
		System.out.println("alskdjfasodjf : " + perPageNumStr);
		System.out.println("123412341234 : " + list);
		model.addAttribute("list", list);
		List<Long> wishlist = new ArrayList<>();
		if (((LoginVO) session.getAttribute("login")) != null) {

			for (int i = 0; i < list.size(); i++) {
				wishlist.add(wishListService.checkWishList(list.get(i).getItemNo(),
						(((LoginVO) session.getAttribute("login")).getId())));
			}
			System.out.println(wishlist);
			model.addAttribute("wishlist", wishlist);
		}

		return "item/list";
	}

	@SuppressWarnings("unused")
	@GetMapping("view.do")
	public String view(Long itemNo, Model model, PageObject pageObject, HttpSession session) {
		System.out.println("ItemController.view()");
		ItemVO vo = service.view(itemNo);
		model.addAttribute("vo", service.view(itemNo));
		model.addAttribute("fileList", service.getImageFile(itemNo));
		String[] colors = vo.getColors().split("/");
		model.addAttribute("colors", colors);
		String[] sizes = vo.getSizes().split("/");
		model.addAttribute("sizes", sizes);
		model.addAttribute("wishListNumber", wishListService.wishListNumber(itemNo));

		LoginVO loginVO = ((LoginVO) session.getAttribute("login"));

		System.out.println("dkdleladadasdfasdasdasdasdads" + loginVO);

		if (((LoginVO) session.getAttribute("login")) != null) {
			String id = (((LoginVO) session.getAttribute("login")).getId());
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% itemNO ="
					+ itemNo + "id=" + id);

			if (wishListService.checkWishList(itemNo, id) == null) {
				System.out.println("리스트가넘어온다아아아아아아아아아아아ㅏㅇ아아ㅏ아아아ㅏ 빈리스트 :  " + wishListService.checkWishList(itemNo, id));

				model.addAttribute("checkWishList", null);
			} else {
				model.addAttribute("checkWishList", wishListService.checkWishList(itemNo, id));
				System.out.println("리스트가넘어온다아아아아아아아아아아아ㅏㅇ아아ㅏ아아아ㅏ " + wishListService.checkWishList(itemNo, id));
			}
		}

		// 문의 리스트입니다.
	      List<QuestionVO> list = questionService.qlist(itemNo);
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

		// 리스트 출력예정입니다 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

		System.out.println("review를 위한 itemNO =" + itemNo);
		model.addAttribute("reviewlist", reviewService.reviewlist(itemNo));

		return "item/view";
	}

	@GetMapping("write.do")
	public String writeForm(ItemVO vo, Model model) {
		System.out.println("ItemController.writeForm()");
		model.addAttribute("c_list", service.categoryList());
		System.out.println(service.categoryList());
		model.addAttribute("b_list", service.brandList());
		System.out.println(service.brandList());

		return "item/write";
	}

	@PostMapping("write.do")
	public String write(ItemVO vo, Long perPageNum, HttpServletRequest request,
			HttpSession session, RedirectAttributes rttr) throws Exception {
		System.out.println("ItemController.write().vo" + vo);
		
		String id = (((LoginVO) session.getAttribute("login")).getId());
		vo.setMembrId(id);
		
		// DB에 저장할 file 정보가 여러개 들어 있는 변수 선언
		List<ImageVO> fileList = new ArrayList<ImageVO>();
		
		// 넘어오는 파일의 정보 출력 - 메인 이미지
		System.out.println("ImageController.write() - 대표 이미지 : " + vo.getPrImageFile().getOriginalFilename());
		// 대표 이미지 업로드
		String prFileName = FileUtil.upload(path, vo.getPrImageFile(), request);
		ImageVO prVO = new ImageVO();
		prVO.setFileName(prFileName);
		prVO.setPr(1);
		
		fileList.add(prVO);
		
		// 넘어오는 파일의 정보 출력 - 상세 이미지
		System.out.println("ImageController.write() - 상세 이미지 : " + vo.getM_detailImage().getOriginalFilename());
		// 대표 이미지 업로드
		String detailImage = FileUtil.upload(path, vo.getM_detailImage(), request);
		vo.setDetailImage(detailImage);
		
		// 넘어오는 파일의 정보 출력 - 추가 이미지
		System.out.println("ImageController.write() - 추가 이미지 : ");
		if(vo.getImageFile() == null) System.out.println("추가 이미지 없음");
		else
			for(MultipartFile mf : vo.getImageFile()) {
				String fileName = FileUtil.upload(path, mf, request);
				ImageVO fileVO = new ImageVO();
				fileVO.setFileName(fileName);
				fileVO.setPr(0);
				fileList.add(fileVO);
			}
		
		// 업로드된 정보 출력
		System.out.println("ImageController.write() - 업로드 파일 정보 : " + fileList);

		// DB 처리
		service.write(vo, fileList);
		
		// 처리 결과를 리스트로 보낸다. - session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "상품 등록이 되었습니다.");
		
		// 파일의 저장되는 시간이 있으므로 list에서 이미지가 안 보이는 경우가 발생된다.
		// 그래서 멈춤 시간을 조금 준다. - 0.5초
		Thread.sleep(500);
		
		// 이동 URL 정보 : 앞에 "redirect:"을 붙여야 합니다. 
		return "redirect:list.do";
	}
	
		// 이미지 바꾸기
		@PostMapping("/changeImage.do")
		public String changeImage(Long imageNo, MultipartFile changeImage, String deleteFileName,
				String query, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
			System.out.println("ItemController.changeImage()" + imageNo + deleteFileName);
			
			// 데이터 확인
			System.out.println("ImageController.changeImage() - 데이터 확인");
			System.out.println("imageNo = " + imageNo);
			System.out.println("changeFileName = " + changeImage.getOriginalFilename());
			System.out.println("deleteFileName = " + deleteFileName);
			
			// 서버에 파일 올리기
			String fileName = FileUtil.upload(path, changeImage, request);
			// DB에 파일 바꾸기 - ImageFileVO - fno, fileName
			ImageVO vo = new ImageVO();
			vo.setImageNo(imageNo);
			vo.setFileName(fileName);
			Integer result = service.changeImage(vo);
			
			if(result == 1) {
				// 이전 파일은 지운다.
				FileUtil.remove(FileUtil.getRealPath("", deleteFileName, request));
				rttr.addFlashAttribute("msg", "성공적으로 이미지가 바꿔졌습니다.");
			} else {
				rttr.addFlashAttribute("msg", "이미지가 바꾸기에 실패하셨습니다.");
			}
			
			// 파일이 저장하는 시간이 필요하다. 저장이 안된 상태로 가면 이미지가 보이지 않는다.
			Thread.sleep(500);
			
			return "redirect:view.do?" + query;
		}
		
		// 상세이미지 바꾸기
		@PostMapping("/detailImageChange.do")
		public String detailPageChange(Long itemNo, MultipartFile changeImage, String deleteFileName,
				String query, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
			System.out.println("ItemController.detailPageChange()" + itemNo + deleteFileName);
			
			// 데이터 확인
			System.out.println("ImageController.changeImage() - 데이터 확인");
			System.out.println("itemNo = " + itemNo);
			System.out.println("changeFileName = " + changeImage.getOriginalFilename());
			System.out.println("deleteFileName = " + deleteFileName);
			
			// 서버에 파일 올리기
			String fileName = FileUtil.upload(path, changeImage, request);
			// DB에 파일 바꾸기 - ImageFileVO - fno, fileName
			ItemVO vo = new ItemVO();
			vo.setItemNo(itemNo);
			vo.setDetailImage(fileName);
			Integer result = service.changeDetailImae(vo);
			
			if(result == 1) {
				// 이전 파일은 지운다.
				FileUtil.remove(FileUtil.getRealPath("", deleteFileName, request));
				rttr.addFlashAttribute("msg", "성공적으로 이미지가 바꿔졌습니다.");
			} else {
				rttr.addFlashAttribute("msg", "이미지가 바꾸기에 실패하셨습니다.");
			}
			
			// 파일이 저장하는 시간이 필요하다. 저장이 안된 상태로 가면 이미지가 보이지 않는다.
			Thread.sleep(500);
			
			return "redirect:view.do?" + query;
		}

		
		// 한개 이미지 삭제
		@GetMapping("deleteImage.do")
		public String deleteImage(Long imageNo, String deleteFile, String query,
				HttpServletRequest request, RedirectAttributes rttr) throws Exception{
			
			// 데이터 확인
			System.out.println("ImageController.deleteImage().fno = " + imageNo);
			System.out.println("ImageController.deleteImage().deleteFile = " + deleteFile);
			System.out.println("ImageController.deleteImage().query = " + query);
			
			//DB 처리
			Integer result = service.deleteImage(imageNo);
			
			if(result == 1) {
				// 이전 파일은 지운다.
				FileUtil.remove(FileUtil.getRealPath("", deleteFile, request));
				rttr.addFlashAttribute("msg", "성공적으로 이미지가 삭제되었습니다.");
			} else {
				rttr.addFlashAttribute("msg", "이미지가 삭제하기에 실패하셨습니다."
						+ "<br>삭제하려는 이미지가 존재하지 않거나 본인의 이미지가 아니거나"
						+ " 주이미지인 경우는 삭제되지 않습니다.");
			}
			
			
			// 처리가 다 끝나면 이미지 보기로 가야 한다.
			return "redirect:view.do?" + query;
		}
		
	@GetMapping("update.do")
	public String updateForm(Long itemNo ,Model model) {
		System.out.println("ItemController.updateForm()");
		model.addAttribute("vo", service.view(itemNo));
		model.addAttribute("fileList", service.getImageFile(itemNo));
		model.addAttribute("c_list", service.categoryList());
		model.addAttribute("b_list", service.brandList());
		
		return "item/update";
	}

	@PostMapping("update.do")
	public String update(ItemVO vo, PageObject pageObject) throws Exception {
		System.out.println("ItemController.update()");
		service.update(vo);

		return "redirect:view.do?itemNo=" + vo.getItemNo() + "&" + pageObject.getPageQuery();
	}

	@PostMapping("delete.do")
	   public String delete(ItemVO vo, Long perPageNum, HttpSession session,
	         HttpServletRequest request, RedirectAttributes rttr) throws Exception {
	      System.out.println("ItemController.delete()");
	      
	      List<ImageVO> fileList = service.getImageFile(vo.getItemNo());
	      
	      Integer result = service.delete(vo);
	      
	      if(result == 1) {
	         for (ImageVO imgVO : fileList) {
	            
	            FileUtil.remove(FileUtil.getRealPath("", imgVO.getFileName(), request));
	         }
	         rttr.addFlashAttribute("msg",  vo.getItemName() + " 상품이 삭제가 되었습니다.");
	      } else {
	         // modal 창에서 줄 바꿈은 <br>로 한다. alert에서 줄 바꿈은 \n으로 한다.
	         rttr.addFlashAttribute("msg", vo.getItemName() + ") 상품이 삭제가 되지 않었습니다." + 
	               "<br>본인이 글이 아니거나 글이 존재하지 않습니다.");
	      }

	      return "redirect:list.do";
	   }

}