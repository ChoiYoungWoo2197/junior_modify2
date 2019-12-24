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

		return "/member/registerMember";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(HttpServletRequest request) {
		logger.info("member insert :" + request.getParameter("employeeId") + " : " + request.getParameter("departmentType"));
		
		Employee employee = new Employee();
		employee.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
		employee.setDepartmentId(Integer.parseInt(request.getParameter("departmentType")));
		employee.setName(request.getParameter("name"));
		employee.setPhone(request.getParameter("phone"));
		
		employeeService.insertEmployee(employee);
		return "/member/registerMember";
	}

}
