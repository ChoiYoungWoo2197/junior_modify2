package kr.or.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.slf4j.Logger;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handle) throws Exception
	{ 
		//여기서 인증관련된 로직을 구성한다.
		//리다이렉트로 인증안되어 있으면 적당하게 페이지 전환 시킨다.
		
		/*
		System.out.println("Login prhHandle : ");
		HttpSession session = request.getSession();
		//기존의 로그인 정보 제거
		if(session.getAttribute("loginUser") != null) {
			System.out.println("clear login data ");
			session.removeAttribute("loginUser");
		}
		 */
		return true; 
	}
	@Override
	public void postHandle (HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		//인터셉터 개념이 아님 
		//지워야됨
		/*


		System.out.println("Login postHandle : ");
		HttpSession session = request.getSession();

		Object object = modelAndView.getModelMap().get("Account");
		if(object != null) {
			session.setAttribute("loginUser", object);
			System.out.println("new login! : " +request.getContextPath().toString());
			//response.sendRedirect("/");
		}
		 */
	}


}
