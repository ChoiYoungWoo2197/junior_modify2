package kr.or.controller;


import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

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
@RequestMapping("/mail")
public class MailController {
	//private static final Logger logger = LoggerFactory.getLogger(MailController.class);
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
		Employee employee = employeeService.checkEmployeeById(request.getParameter("memberId"));
		model.addAttribute("mail", employee.getEmail());
		boolean b = true ;
		System.out.println("인텔리제이 커밋");
		//test
		return "/mail/authenticate";
	}

	//이메일 인증요청
	@RequestMapping(value = "/request", method = RequestMethod.POST)
	public @ResponseBody String request(HttpServletRequest request) {
		boolean result = false;
		Employee employee = employeeService.checkEmployeeByEmail(request.getParameter("mail"));

		//제한일시내에 재발송을 한경우에는
		if(compareDay(employee.getAuthKeyDate(), new Date()) < 0) {
			result = false;
		}
		else {
			if(employee != null) {
				String authKey = mailService.getAuthKey();
				employeeService.updateKeyByMap(employee.getMemberId(), authKey); //난수를 업데이트 한다.
				employeeService.updateKeyDateByMap(employee.getMemberId(), new Date());  //인증요청 일시를 업데이트 한다.
				
				String title = "회원가입 인증 이메일 입니다.";
				StringBuilder text = new StringBuilder();
				text.append("귀하의 인증번호는 : " + authKey + " 입니다.");

				mailService.sendMail(mailService.sendTo(), employee.getEmail(), title, text.toString());
				result = true;
			}
		}

		return String.valueOf(result);	
	}

	//이메일 인증완료 
	@RequestMapping(value = "/complete", method = RequestMethod.POST)
	public String complete(HttpServletRequest request, Model model) {
		String result = "";
		Employee employee = employeeService.checkKeyByMap(request.getParameter("mail"), request.getParameter("authKey"));

		if(employee != null) {
			employeeService.updateStateByMap(employee.getMemberId(), "Y");
			model.addAttribute("user", employee);
			result = "/mail/success";
		}
		else 
		{
			Employee tmp = employeeService.checkEmployeeByEmail(request.getParameter("mail"));
			result = "redirect:/mail/authenticate?memberId="+ tmp.getMemberId();
		}
		return result;
	}
	
	//날짜 비교
	public int compareDay(Date authKeyDate, Date currentDate) {
		//yyyy-MM-dd hh:mm:ss
		int compare =0;
		Calendar cal = Calendar.getInstance();
		cal.setTime(authKeyDate); //디비에 저장되어 있는 일시
		cal.add(Calendar.MINUTE, 2); // 2분 추가
		
		Date limitAuthKeyDate= new Date(cal.getTimeInMillis()); // 제한 일시 만듬
		
		compare = currentDate.compareTo(limitAuthKeyDate);

		
		return compare;
	}
}
