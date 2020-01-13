package kr.or.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	//private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) { //로그인이 안된 경우
			
			/*
			 * //회원가입인 경우 if(request.getRequestURI().contains("/member/insert") == true) {
			 * String oldUrl = request.getHeader("referer"); //이전주소 //로그인 페이지에서 회원가입을 눌렀을 경우
			 * if(oldUrl.contains("login") == true) { return true; } }
			 */
			
			response.sendRedirect(request.getContextPath() + "/login/login");
			return false;
		}
		
		return true;
	}

}
