package com.bjsxt.utils;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class Mail {
public boolean sendEmai(String address, String title,String text) {
	String from ="1922669677@qq.com";//发送的账号
	String to =address;//接收的账户
	String host ="smtp.qq.com";//QQ邮箱服务器的SMTP
	Properties property=System.getProperties();
	property.setProperty("mail.smtp.host", host);
	property.put("mail.smtp.auth","true");
	Session session =Session.getDefaultInstance(property,
			new Authenticator() {
		public PasswordAuthentication getPasswordAuthentication()
		{

		return new PasswordAuthentication(from,
					"nkujrfkpxmfpebhe");
		}});
	
	try {
		MimeMessage message = new MimeMessage(session);

		message.setFrom(new InternetAddress(from));

		message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
	message.setSubject(title);	
	message.setText(text);
	Transport.send(message);
	return true;
	}catch(MessagingException mex) {
		   mex.printStackTrace();
	         return false;
	}
}
}
