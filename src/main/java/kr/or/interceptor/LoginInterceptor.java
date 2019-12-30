package kr.or.interceptor;

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
		System.out.println("Login prhHandle : ");
		HttpSession session = request.getSession();
		//기존의 로그인 정보 제거
		if(session.getAttribute("loginUser") != null) {
			System.out.println("clear login data ");
			session.removeAttribute("loginUser");
		}
		return true; 
	}
	@Override
	public void postHandle (HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		System.out.println("Login postHandle : ");
		HttpSession session = request.getSession();
		Object object = modelAndView.getModelMap().get("user");

		if(object != null) {
			session.setAttribute("loginUser", object);
			System.out.println("new login! : " +request.getContextPath().toString());
			//response.sendRedirect("/");
		}
	}


}
