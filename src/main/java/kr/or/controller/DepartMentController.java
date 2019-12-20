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
import kr.or.persistence.DepartmentDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class DepartMentController {
	private static final Logger logger = LoggerFactory.getLogger(DepartMentController.class);
	@Autowired
	private DepartmentDao departMentDao;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/department", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		//logger.info("사원번호 : " + loginId + " " + "비밀번호 : " + loginPw);
		List<DepartmentAccount> departMentList = new ArrayList<DepartmentAccount>();
		departMentList = departMentDao.selectAll();

		model.addAttribute("departMentData", departMentList);
		
		return "departMent";
	}

}
