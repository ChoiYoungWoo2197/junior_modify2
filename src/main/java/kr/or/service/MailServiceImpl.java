package kr.or.service;

import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import kr.or.domain.Employee;

@Service
public class MailServiceImpl implements MailService{
	@Inject    //서비스를 호출하기 위해서 의존성을 주입
	private JavaMailSender senderMail;     //메일 서비스를 사용하기 위해 의존성을 주입함.

	@Override
	public boolean sendMail(String sendFrom, String sendTo, String title, String text) {
		boolean success = false;
		try {
			MimeMessage message = senderMail.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(sendFrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(sendTo); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(text); // 메일 내용

			senderMail.send(message);
			success = true;


		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			success = false;
		}


		return success;
	}


	@Override
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


	@Override
	public String sendTo() {
		// TODO Auto-generated method stub
		return "arangchoi40@gmail.com";
	}

}
