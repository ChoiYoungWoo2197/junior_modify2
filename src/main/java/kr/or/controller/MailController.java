package kr.or.controller;

import java.util.Locale;
import java.util.Random;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
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

import kr.or.service.EmployeeService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/mail/*")
public class MailController {
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	@Autowired
	EmployeeService employeeService;
	
	@Inject    //서비스를 호출하기 위해서 의존성을 주입
	JavaMailSender senderMail;     //메일 서비스를 사용하기 위해 의존성을 주입함.

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/authenticate", method = RequestMethod.GET)
	public String authenticate(Locale locale, Model model) {

		return "/mail/authenticate";
	}

	//이메일 인증 번호 보내기
	@RequestMapping(value = "/request", method = RequestMethod.POST)
	public @ResponseBody String request(HttpServletResponse response, @RequestParam("mail") String mail) {
		boolean success = false;
		String authKey = getAuthKey(); //이메일로 받는 인증번호 부분 (난수)
		String sendPerson = "arangchoi40@gamil.com";
		String receivePerson = mail; // 받는 사람 이메일
		String title = "회원가입 인증 이메일 입니다."; // 제목
		String content =System.getProperty("line.separator") + "씨엠티정보통신"	+
						System.getProperty("line.separator") + "이메일인증 안내입니다." +
						System.getProperty("line.separator") + "안녕하세요." +
						System.getProperty("line.separator") + "회원가입을 해주셔서 진심으로 감사드립니다." 	+
						System.getProperty("line.separator") + "귀하의 인증번호는 " + "'" + authKey + "'" + "이며 회원가입을 완료해 주세요."	+
						System.getProperty("line.separator") + "감사합니다."; // 내용

		try {
			MimeMessage message = senderMail.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(sendPerson); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(receivePerson); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			senderMail.send(message);
			success = true;


		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			success = false;
		}


		return String.valueOf(success);
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
