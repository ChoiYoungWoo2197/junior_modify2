package kr.or.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.domain.Department;
import kr.or.domain.Employee;
import kr.or.domain.Manager;
import kr.or.domain.Page;
import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;
import kr.or.service.EmployeeService;
import kr.or.service.MailService;
import kr.or.service.ManagementService;
import kr.or.service.ReservationDetailService;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/member")
public class MemberController {
	//private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	ManagementService managementServcice;
	
	@Autowired
	ReservationDetailService reservationDetailService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria,Model model) throws UnsupportedEncodingException {
		List<Employee> employeeList = employeeService.searchEmployee(searchCriteria);
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("employeeListSize", employeeService.searchEmployeeCount(searchCriteria));
		
		model.addAttribute("searchCriteria", searchCriteria);
		model.addAttribute("page", new Page(employeeService.searchEmployeeCount(searchCriteria), searchCriteria));
		if(searchCriteria.getSearchContent()!=null){
	         model.addAttribute("searchContent", URLEncoder.encode(searchCriteria.getSearchContent(),"UTF-8"));
	      }
		return "/member/list";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Locale locale, Model model) {
		List<Department> departmentList = managementServcice.searchDepartmentList();
		model.addAttribute("departmentList", departmentList);
		return "/member/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(HttpServletRequest request) {
		String result;
		//Enumeration enums = request.getParameterNames();
		String register = request.getParameter("register");
		String managerType = request.getParameter("manager");
		Employee employee = new Employee();
		//employee.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
 		employee.setDepartmentId(request.getParameter("departmentType"));
		employee.setName(request.getParameter("name"));
		employee.setMemberId(request.getParameter("memberId"));
		employee.setPassword(employeeService.encSHA256(request.getParameter("password")));
		employee.setEmail(request.getParameter("email"));
		employee.setPhone(request.getParameter("phone"));
		employee.setAuthkey(mailService.getAuthKey());
		employee.setState("N");
		employee.setAuthKeyDate(new Date());
		employeeService.insertEmployee(employee);
		
		if(register.equals("true") == true) {//관리자가 회원등록을 한경우
			//이메일 인증이 필요 없다.
			employeeService.updateStateByMap(employee.getMemberId(), "Y");
			
			if(managerType.equals("yes") == true) {//회원을 관리자로 등록할 경우
				Employee tmp = employeeService.checkEmployeeById(request.getParameter("memberId"));
				if(employeeService.checkManager(tmp.getEmployeeId()) == null) {
					employeeService.insertManager(tmp.getEmployeeId());
				}
			}
			result = "redirect:/member/list";
		}
		else {// 회원가입을 한경우
			String title = "회원가입 인증 이메일 입니다.";
			StringBuilder text = new StringBuilder();
			text.append("귀하의 인증번호는 : " + employee.getAuthkey() + " 입니다.");
			
			mailService.sendMail(mailService.sendTo(), employee.getEmail(),title, text.toString());
			
			result = "redirect:/mail/authenticate?memberId="+employee.getMemberId();
		}


		return result;
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET) 
	public String read(Model model, String memberId) {
		Employee employee = employeeService.checkEmployeeById(memberId);
		Department department = managementServcice.selectDepartmentById(Integer.parseInt(employee.getDepartmentId()));
		Manager manager = employeeService.checkManager(employee.getEmployeeId());
		
		employee.setDepartmentId(department.getName());
		model.addAttribute("employeeDetail", employee);
		model.addAttribute("managerType", (manager != null)? "Y": "N");
		return "member/read";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyPage(Model model, String memberId) {
		Employee employee = employeeService.checkEmployeeById(memberId);
		Manager manager = employeeService.checkManager(employee.getEmployeeId());
		List<Department> departmentList = managementServcice.searchDepartmentList();
		
		
		model.addAttribute("employeeModify", employee);
		model.addAttribute("managerType", (manager != null)? "Y" : "N");
		model.addAttribute("departmentList", departmentList);
		
		return "member/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(HttpServletRequest request) {
		Enumeration enums = request.getParameterNames();
		
		String modifyPassword = request.getParameter("modifyPassword");
		String originalMemberId = request.getParameter("originalMemberId");
		String managerType = request.getParameter("manager");
		
		Employee employee =employeeService.checkEmployeeById(originalMemberId);
		employee.setDepartmentId(request.getParameter("departmentType"));
		employee.setName(request.getParameter("name"));
		employee.setMemberId(request.getParameter("modifyMemberId"));
		
		if(modifyPassword.equals("") != true) {
			employee.setPassword(employeeService.encSHA256(modifyPassword));
		}
		
		employee.setEmail(request.getParameter("email"));
		employee.setPhone(request.getParameter("phone"));
		employeeService.modifyEmployee(employee);
		
		
		if(managerType.equals("yes")) {
			if(employeeService.checkManager(employee.getEmployeeId()) == null) {
				employeeService.insertManager(employee.getEmployeeId());
			}
		
		}
		else {
			employeeService.deleteManager(employee.getEmployeeId());
		}
		
		return  "redirect:/member/list";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(HttpServletRequest request, String memberId) {
		Employee employee = employeeService.checkEmployeeById(memberId);
		List<Reservation> reservationList = reservationDetailService.searchReservationByEmployeeId(employee.getEmployeeId());
		
		for (int i = 0; i < reservationList.size(); i++) {
			reservationDetailService.deleteExtendById(reservationList.get(i).getReservationId());
		}
		
		
		reservationDetailService.deleteReservationById(employee.getEmployeeId());
		employeeService.deleteManager(employee.getEmployeeId());
		employeeService.deleteEmployee(memberId);
		
		
		return "redirect:/member/list";
	}
	
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public @ResponseBody String checkId(HttpServletRequest request) {
		String memberId = request.getParameter("memberId");
		String result = "false";
		Employee employee = employeeService.checkEmployeeById(memberId);
		
		if(employee != null) {
			result = "true";
		}
		return result;
	}
	
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
	public @ResponseBody String checkEmail(HttpServletRequest request) {
		String email = request.getParameter("email");
		String result = "false";
		Employee employee = employeeService.checkEmployeeByEmail(email);
		
		if(employee != null) {
			result = "true";
		}
		return result;
	}

}
