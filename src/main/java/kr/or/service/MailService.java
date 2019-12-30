package kr.or.service;

public interface MailService {
	public boolean sendMail(String sendFrom, String sendTo, String title, String text);
	public String sendTo();
	public String getAuthKey();
}

