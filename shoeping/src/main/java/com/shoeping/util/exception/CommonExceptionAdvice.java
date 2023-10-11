//package com.shoeping.util.exception;
//
//
//
//import org.springframework.http.HttpStatus;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.bind.annotation.ResponseStatus;
//import org.springframework.web.servlet.NoHandlerFoundException;
//
//
//@ControllerAdvice
//public class CommonExceptionAdvice {
//	
//	// 컨트롤러에서 나오는 모든 익셉션은 전부 잡겟따.
//	@ExceptionHandler(Exception.class)
//	public String exception(Exception ex ,Model model) {
//		model.addAttribute("ex",ex);
//		
//		
//		return"error/error_page";
//	}
//	
//	//404 처리
//	@ExceptionHandler(NoHandlerFoundException.class)
//	@ResponseStatus(HttpStatus.NOT_FOUND)
//	public String handle404(NoHandlerFoundException ex) {
//		
//		return "error/error_404";
//		
//	}
//
//}
