import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
  
public class Mailer{
	public static void send(String to,String subject,String msg){
		final String user="pinggwingg@gmail.com";
		final String pass="pingtokro";
		Properties props = new Properties();
		props.put("mail.smtp.user", user);
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.starttls.enable","true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

	  
		Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(user,pass);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
			message.setSubject(subject);
			message.setText(msg);
			Transport.send(message);
			System.out.println("Done");
		}catch(Exception e){System.out.println(e);}
	}
}