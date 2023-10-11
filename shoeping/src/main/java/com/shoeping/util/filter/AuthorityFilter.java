package com.shoeping.util.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shoeping.member.vo.LoginVO;

import lombok.extern.java.Log;

/**
 * Servlet Filter implementation class AuthorityFilter
 */
@Log
public class AuthorityFilter implements Filter {

	// url = 페이지 접근 권한 번호
	private Map<String, Integer> authMap = new HashMap<>();

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public AuthorityFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		// 로그인 정보가 들어 있는 객체
		HttpSession session = req.getSession();

		log.info("권한 처리 .................... ");

		String uri = req.getServletPath();
		String query = req.getQueryString();

		log.info(uri);

		// uri의 페이지 권한이 있는지 본다.
		Integer grade = authMap.get(uri);
		log.info("페이지의 권한 : " + ((grade == null) ? "전체 권한" : grade));

		// 사용자의 권한
		Integer gradeNo = null;
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		if (loginVO != null)
			gradeNo = loginVO.getGradeNo();
		log.info("사용자 권한 : " + ((gradeNo == null) ? "로그인 안함" : gradeNo));

		// 로그인이 필요한 페이지 체크
		if (grade != null && grade >= 1) {
			// 로그인이 되어 있지 않은 경우는 로그인 페이지로 이동 시킨다.
			if (loginVO == null) {
				// 요청한 페이지를 저장해 놓는다. 로그인을 하면 요청한 페이지로 이동시킨다.
				session.setAttribute("goBackURL", uri + ((query == null) ? "" : "?" + query));
				res.sendRedirect("/member/login.do");
				// 더 이상 진행되지 않도록 return이 필요하다.
				return;
			}
			// 관리자 권한(페이지 권한 grade > 사용자 권한 gradeNo)
			if (grade > gradeNo) {
				res.sendRedirect("/error/auth.do");
				// 더 이상 진행되지 않도록 return이 필요하다.
				return;
			}
		}

		// pass the request along the filter chain
		// 실행해야할 Servlet으로 가게되는 메서드
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("AuthorityFilter.init() - 권한 정보 세팅");

		// review
		authMap.put("/review/write.do", 1);
		authMap.put("/review/update.do", 1);
		authMap.put("/review/delete.do", 1);

		// 관리자 권한
	    authMap.put("/item/write.do", 9);
	    authMap.put("/item/changeImage.do", 9);
	    authMap.put("/item/detailImageChange.do", 9);
	    authMap.put("/item/deleteImage.do", 9);
	    authMap.put("/item/update.do", 9);
	    authMap.put("/buy/buyList.do", 9);
	    
	    // 일반 권한
	    authMap.put("/buy/list.do", 1);
	    authMap.put("/buy/buyCart.do", 1);
	    authMap.put("/buy/buyDirect.do", 1);
	    
		// notice
		authMap.put("/notice/write.do", 9);
		authMap.put("/notice/update.do", 9);
		authMap.put("/notice/delete.do", 9);
		
		// cart
		authMap.put("/cart/list.do", 1);
		authMap.put("/cart/insertCart.do", 1);
		authMap.put("/cartAjax/delete.do", 1);
		authMap.put("/cartAjax/quantityPlus.do", 1);
		authMap.put("/cartAjax/quantityMinus.do", 1);
		
		// wishList
		authMap.put("/wishList/list.do", 1);
		authMap.put("/wishListAjax/deleteWishList.do", 1);
		authMap.put("/wishListAjax/insertWishList.do", 1);
		
		// resell
		authMap.put("/resell/resell.do", 1);
		authMap.put("/resell/resellList.do", 1);
		authMap.put("/resell/write.do", 9);
		authMap.put("/resell/view.do", 1);
		authMap.put("/resell/update.do", 9);
		authMap.put("/resell/delete.do", 9);
		
		// 질문답변 필터
		// 관리자 권한
		authMap.put("/answer/write.do", 9);
		authMap.put("/answer/update.do", 9);
		authMap.put("/answer/delete.do", 9);
		authMap.put("/question/managerList.do", 9);
		// 일반 권한
		authMap.put("/question/write.do", 1);
		authMap.put("/question/update.do", 1);
		authMap.put("/question/delete.do", 1);
		authMap.put("/question/myList.do", 1);

		// member
		authMap.put("/member/view.do", 1);
		authMap.put("/member/category.do", 9);
		authMap.put("/member/brand.do", 9);
		authMap.put("/member/list.do", 9);

	}

}
