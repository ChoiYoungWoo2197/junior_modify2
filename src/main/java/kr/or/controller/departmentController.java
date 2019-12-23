package kr.or.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.or.domain.Department;
import kr.or.domain.DepartmentAccount;
import kr.or.persistence.DepartmentAccountDao;
import kr.or.persistence.DepartmentDao;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/department/*")
public class departmentController {
	private static final Logger logger = LoggerFactory.getLogger(departmentController.class);
	@Autowired
	private DepartmentDao departmentDao;
	
	@Autowired
	private DepartmentAccountDao departmentAccountDao;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/boards", method = RequestMethod.GET)
	public String departmentBoard(Locale locale, Model model) {
		//logger.info("사원번호 : " + loginId + " " + "비밀번호 : " + loginPw);
		List<DepartmentAccount> departmentList = new ArrayList<DepartmentAccount>();
		departmentList = departmentAccountDao.selectAll();

		model.addAttribute("departmentData", departmentList);
		
		return "/department/departmentBoard";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public @ResponseBody List<DepartmentAccount> insertDepartment(String departmentName) {
		logger.info("부서명 : " + departmentName);
		List<DepartmentAccount> departmentList = new ArrayList<DepartmentAccount>();
		
		Department department = new Department();
		department.setName(departmentName);
		department.setRegisterDate(new Date());
		
		departmentDao.insertData(department);
		departmentList = departmentAccountDao.selectAll();
		
		return departmentList;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody List<DepartmentAccount> deleteDepartment(String departmentId) {
		logger.info("부서번호 : " + departmentId);
		List<DepartmentAccount> departmentList = new ArrayList<DepartmentAccount>();

		
		departmentDao.deleteData(departmentId);
		departmentList = departmentAccountDao.selectAll();
		
		return departmentList;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public @ResponseBody List<DepartmentAccount> updateDepartment(String departmentId, String updateName) {
		logger.info("부서번호 : " + departmentId + " 바꿀 명칭 : " + updateName);
		List<DepartmentAccount> departmentList = new ArrayList<DepartmentAccount>();

		
		departmentDao.updateDate(departmentId, updateName);
		departmentList = departmentAccountDao.selectAll();
		
		return departmentList;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public @ResponseBody List<DepartmentAccount> searchDepartment(String  searchName) {
		logger.info("검색할 부서명 : " + searchName);
		List<DepartmentAccount> departmentList = new ArrayList<DepartmentAccount>();

	
		departmentList = departmentAccountDao.selectSearch(searchName);
		
		return departmentList;
	}
}
