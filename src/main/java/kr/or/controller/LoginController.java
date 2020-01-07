package kr.or.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	//로그인 화면 출력
	@RequestMapping(value = "/login", method = RequestMethod.GET) 
	public String login(Locale locale, Model model) {
		return "login";
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	//로그인 시도
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String check(Locale locale, Model model, HttpServletRequest request, HttpSession session) {
		logger.info("사원번호 : " + request.getParameter("loginId") + " " + "비밀번호 : " + request.getParameter("loginPw"));
		String result = "redirect:/login/login";
		try {
			Employee employee = employeeService.checkUser(request.getParameter("loginId"), employeeService.encSHA256(request.getParameter("loginPw")));
			if(employee != null) { // 로그인 성공인 경우
				//인증을 했는 경우
				if(employeeService.checkStateByMap(employee.getMemberId(), "Y") != null) 
				{
					Map<String, Object> map = new HashMap<>();

					//관리자 계정인 경우
					if(employeeService.checkManager(employee.getEmployeeId()) != null) { 
						//관리자
						map.put("manager", "true");
					}
					else {
						//일반회원
						map.put("manager", "false");
					}
					map.put("user", employee);
					//여기서 세션 저장한다.
					session.setAttribute("loginUser", map);
					
					//model.addAttribute("Account", map);

					result = "redirect:/reservation/list";
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
	//로그인 시도
	@RequestMapping(value = "/out", method = RequestMethod.GET)
	public String out(HttpSession session) {
		session.invalidate();
		return "redirect:/reservation/list";
	}

}
