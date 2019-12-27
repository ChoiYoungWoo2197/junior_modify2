package kr.or.controller;

import java.util.Locale;
import java.util.Random;

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
import kr.or.persistence.EmployeeDao;
import kr.or.service.EmployeeService;
import kr.or.service.ManagementService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	EmployeeService employeeService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Locale locale, Model model) {

		return "/member/register";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(HttpServletRequest request) {
		logger.info("member insert :" + request.getParameter("employeeId") + " : " + request.getParameter("departmentType"));
		
		Employee employee = new Employee();
		employee.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
		employee.setDepartmentId(Integer.parseInt(request.getParameter("departmentType")));
		employee.setName(request.getParameter("name"));
		employee.setPassword(request.getParameter("password"));
		employee.setEmail(request.getParameter("email"));
		employee.setPhone(request.getParameter("phone"));
		employee.setAuthkey(getAuthKey());
		employee.setState("N");
		employeeService.insertEmployee(employee);
		return "redirect:/mail/authenticate?employeeId="+employee.getEmployeeId();
	}
	
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public @ResponseBody String checkId(HttpServletRequest request) {
		logger.info("employee Id :" + request.getParameter("employeeId"));
		String employeeId = request.getParameter("employeeId");
		String result = "false";
		Employee employee = employeeService.checkIdEmployee(employeeId);
		
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
	
	//20자리  영문+숫자 랜덤코드 만들기
	public String getAuthKey() {
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();	 

		for(int i=0;i<20;i++){
		    if(rnd.nextBoolean()){
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		        buf.append((rnd.nextInt(10))); 
		    }
		}
		
		return buf.toString();
	}

}