package kr.or.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//logger.info("AuthInterceptor preHandler"); 
		System.out.println("AuthInterceptor preHandler : " +request.getContextPath( ));
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") == null) { //로그인이 안된 경우
			logger.info("current user is not login ......... ");

			response.sendRedirect(request.getContextPath() + "/login/login");
			return false;
		}
		
		return true;
	}

}
