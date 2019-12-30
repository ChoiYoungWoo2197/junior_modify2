package kr.or.controller;

import java.util.Locale;
import java.util.Random;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.domain.Employee;
import kr.or.service.EmployeeService;
import kr.or.service.MailService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/mail/*")
public class MailController {
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	@Autowired
	EmployeeService employeeService;

	@Autowired
	MailService mailService;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	//이메일 인증페이지 출력
	@RequestMapping(value = "/authenticate", method = RequestMethod.GET)
	public String authenticate(Locale locale, Model model, HttpServletRequest request) {
		logger.info("mail > memberId :" + request.getParameter("memberId"));
		try {
			Employee employee = employeeService.checkIdEmployee(request.getParameter("memberId"));
			model.addAttribute("mail", employee.getEmail());
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		return "/mail/authenticate";
	}

	//이메일 인증요청
	@RequestMapping(value = "/request", method = RequestMethod.POST)
	public @ResponseBody String request(HttpServletRequest request) {
		boolean success = false;
		try {
			Employee employee = employeeService.checkEmailEmployee(request.getParameter("mail"));

			if(employee != null) {
				String authKey = mailService.getAuthKey();
				employeeService.modifyKey(employee.getMemberId(), authKey);

				String title = "회원가입 인증 이메일 입니다.";
				StringBuilder text = new StringBuilder();
				text.append("귀화의 인증번호는 : " + authKey + " 입니다.");

				mailService.sendMail(mailService.sendTo(), employee.getEmail(), title, text.toString());
				success = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return String.valueOf(success);	
	}

	//이메일 인증완료 
	@RequestMapping(value = "/complete", method = RequestMethod.POST)
	public String complete(HttpServletRequest request, Model model) {
		logger.info("mail > complete :" + request.getParameter("mail") + " : " + request.getParameter("authKey"));
		String result = "";
		try {
			Employee employee = employeeService.checkKey(request.getParameter("mail"), request.getParameter("authKey"));

			if(employee != null) {
				employeeService.modifyState(employee.getMemberId(), "Y");
				model.addAttribute("user", employee);
				result = "/mail/success";
			}
			else 
			{
				Employee tmp = employeeService.checkEmailEmployee(request.getParameter("mail"));
				result = "redirect:/mail/authenticate?memberId="+ tmp.getMemberId();
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		return result;
	}
}
