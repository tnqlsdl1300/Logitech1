package manager.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		// GMail의 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("conbrio04","sistcclass");
	}// end of public PasswordAuthentication getPasswordAuthentication(){}

}
