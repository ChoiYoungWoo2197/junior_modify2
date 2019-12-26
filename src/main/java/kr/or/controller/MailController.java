package kr.or.controller;

import java.io.PrintWriter;
import java.util.Locale;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/mail/*")
public class MailController {
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);

    @Inject    //서비스를 호출하기 위해서 의존성을 주입
    JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
    
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/authenticate", method = RequestMethod.GET)
	public String authenticate(Locale locale, Model model) {

		return "/mail/authenticate";
	}
	
	@RequestMapping(value = "/request", method = RequestMethod.POST)
	public @ResponseBody String request(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam("mail") String mail) {
        Random r = new Random();
        int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
        String setfrom = "arangchoi40@gamil.com";
        String tomail = mail; // 받는 사람 이메일
        String title = "회원가입 인증 이메일 입니다."; // 제목
        String content =
        
        System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
        
        System.getProperty("line.separator") +
        "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
        +System.getProperty("line.separator") +      
        System.getProperty("line.separator")+
        " 인증번호는 " +dice+ " 입니다. "
        
        +System.getProperty("line.separator")+
        
        System.getProperty("line.separator")+
        
        "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                    true, "UTF-8");

            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            
            mailSender.send(message);
            
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out_email = response.getWriter();
            out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
            out_email.flush();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
        

		return "true";
	}
}
