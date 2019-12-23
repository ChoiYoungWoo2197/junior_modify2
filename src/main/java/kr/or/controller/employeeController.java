package kr.or.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.domain.DepartmentAccount;
import kr.or.domain.Employee;
import kr.or.persistence.DepartmentDao;
import kr.or.persistence.EmployeeDao;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/employee/*")
public class employeeController {
	private static final Logger logger = LoggerFactory.getLogger(employeeController.class);
	@Autowired
	private EmployeeDao employeeDao;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/boards", method = RequestMethod.GET)
	public String employeeBoard(Locale locale, Model model) {
		List<Employee> employeeList = new ArrayList<Employee>();
		employeeList = employeeDao.selectAll();

		model.addAttribute("employeeData", employeeList);
		
		return "/employee/listEmployee";
	}

}
