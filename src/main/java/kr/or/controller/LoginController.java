package kr.or.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.domain.Employee;
import kr.or.persistence.EmployeeDao;
import kr.or.service.EmployeeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	EmployeeService employeeService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET) 
	public String login(Locale locale, Model model) {
		return "login";
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String loginCheck(Locale locale, Model model, HttpServletRequest request) {
		logger.info("사원번호 : " + request.getParameter("loginId") + " " + "비밀번호 : " + request.getParameter("loginPw"));
		String result = "login";
		Employee employee = employeeService.checkUser(request.getParameter("loginId"), employeeService.encSHA256(request.getParameter("loginPw")));

		if(employee != null) { // 로그인 성공인 경우
			//if(employeeService.checkState(employee.getMemberId(), "Y") != null) 
			//인증을 했는 경우
			{
				model.addAttribute("user", employee);
				return "redirect:/";
			}
			//인증을 안했는 경우
			
		}
		else { //로그인 실패인 경우
			return "redirect:/login";
		}

		
	}

}
