package util.authentication;

public class AuthenticationCode {

	public static String getAuthenticationCode() {
		
		// 따로 클래스를 만들어서 난수 생성, session에 담아서 검사
		// 6자리 숫자난수 생성
		int code = (int)Math.floor(Math.random() * 1000000)+100000;
		if(code>1000000){
			code = code - 100000;
		}
		
		String sCode = Integer.toString(code); 
		
		return sCode;
	}
	
}
