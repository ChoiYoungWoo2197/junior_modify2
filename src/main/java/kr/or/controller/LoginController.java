package kr.or.controller;

import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.or.domain.Employee;
import kr.or.service.EmployeeService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/login/*")
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
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String loginCheck(Locale locale, Model model, HttpServletRequest request) {
		logger.info("사원번호 : " + request.getParameter("loginId") + " " + "비밀번호 : " + request.getParameter("loginPw"));
		String result = "redirect:/login/login";
		try {
			Employee employee = employeeService.checkUser(request.getParameter("loginId"), employeeService.encSHA256(request.getParameter("loginPw")));
			if(employee != null) { // 로그인 성공인 경우
				if(employeeService.checkState(employee.getMemberId(), "Y") != null) //인증을 했는 경우
				{
					//인터셉터 post에서 사용하기 위해 model에 키값을 저장
					model.addAttribute("user", employee);
					result = "redirect:/";
				}
				else {
					result = "redirect:/mail/authenticate?memberId="+employee.getMemberId();
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return result;
	}

}
