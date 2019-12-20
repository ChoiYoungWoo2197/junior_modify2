package kr.or.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;
import kr.or.domain.Department;
import kr.or.domain.DepartmentAccount;
import kr.or.persistence.DepartmentDao;
import kr.or.persistence.EmployeeDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private DepartmentDao departMentDao;
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/departMentPage.do", method = RequestMethod.POST) 
	public String departMent(Locale locale, Model model) {
		List<DepartmentAccount> departMentList = new ArrayList<DepartmentAccount>();
		departMentList = departMentDao.selectAll();

		model.addAttribute("departMentData", departMentList);
		return "departMent";
		
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/loginCheck.do", method = RequestMethod.POST)
	public String login(Locale locale, Model model, @RequestParam("loginId") String loginId, @RequestParam("loginPw") String loginPw) {
		logger.info("사원번호 : " + loginId + " " + "비밀번호 : " + loginPw);
		String result = "login";
		boolean loginFlag = employeeDao.checkAccount(loginId, loginPw);

		if(loginFlag == true) {
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

			String formattedDate = dateFormat.format(date);

			model.addAttribute("serverTime", formattedDate );
			result = "home";
		}
		else {

		}

		return result;
	}

}
