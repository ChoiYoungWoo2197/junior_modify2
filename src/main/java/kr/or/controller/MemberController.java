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
import org.springframework.web.bind.annotation.ResponseBody;
import kr.or.domain.Employee;
import kr.or.service.EmployeeService;
import kr.or.service.MailService;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	MailService mailService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Locale locale, Model model) {

		return "/member/register";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(HttpServletRequest request) {
		logger.info("member insert :" + request.getParameter("memberId") + " : " + request.getParameter("departmentType"));
		
		Employee employee = new Employee();
		//employee.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
		employee.setDepartmentId(Integer.parseInt(request.getParameter("departmentType")));
		employee.setName(request.getParameter("name"));
		employee.setMemberId(request.getParameter("memberId"));
		employee.setPassword(employeeService.encSHA256(request.getParameter("password")));
		employee.setEmail(request.getParameter("email"));
		employee.setPhone(request.getParameter("phone"));
		employee.setAuthkey(mailService.getAuthKey());
		employee.setState("N");
		employeeService.insertEmployee(employee);
		
		String title = "회원가입 인증 이메일 입니다.";
		StringBuilder text = new StringBuilder();
		text.append("귀화의 인증번호는 : " + employee.getAuthkey() + " 입니다.");
		
		mailService.sendMail(mailService.sendTo(), employee.getEmail(),title, text.toString());
		
		return "redirect:/mail/authenticate?memberId="+employee.getMemberId();
	}
	
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public @ResponseBody String checkId(HttpServletRequest request) {
		logger.info("memberId:" + request.getParameter("memberId"));
		String memberId = request.getParameter("memberId");
		String result = "false";
		Employee employee = employeeService.checkIdEmployee(memberId);
		
		if(employee != null) {
			result = "true";
		}
		return result;
	}
	
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
	public @ResponseBody String checkEmail(HttpServletRequest request) {
		logger.info("email :" + request.getParameter("email"));
		String email = request.getParameter("email");
		String result = "false";
		Employee employee = employeeService.checkEmailEmployee(email);
		
		if(employee != null) {
			result = "true";
		}
		return result;
	}

}
