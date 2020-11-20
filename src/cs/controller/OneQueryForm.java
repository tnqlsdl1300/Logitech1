package cs.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

import util.security.AES256;
import util.security.SecretMyKey;

public class OneQueryForm extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 현재 로그인 연결이 안되어 있어서  loginuser는 null인 상태 java.lang.NullPointerException
		
		HttpSession session=request.getSession();
		// 로그인 처리가 되어있어야 1:1문의창으로 이동할수있도록 해둠.
		if(session.getAttribute("loginuser") == null) {
					
			
			String message = "먼저 로그인 해주세요.";
			
			String loc = request.getContextPath()+"/customCenter.sg";
			
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
			// 로그인창이 별도로 없고 모달로 만들었기 때문에 메세지를 띄워줘야함.
			// 아니면 직접 연결하는 방법도?
		 
			
			// forward 데이터 를 넘겨주고 페이지 이동
			// sendreDirect 데이터를 넘겨주지 않고 페이지 이동
			return;
		}
			
			
			
			AES256 aes = new AES256(SecretMyKey.KEY);
     		super.setRedirect(false);		
			
		    
		    
			// 로그인한 회원의 정보를 알아오려고하는데 DAO에서 가져와야하는지 session에서 가져와야 하는지.
		    
			MemberVO loginuser= (MemberVO)session.getAttribute("loginuser");
			String name=loginuser.getName();
			String mobile=loginuser.getMobile();
			
			// 암호화 된걸 풀고 그 안에다가 넣어줌
			String h1=mobile.substring(0, 3);
		    String h2=mobile.substring(3, 7);
		    String h3=mobile.substring(7);
		   
			String email=loginuser.getEmail();
			
			int s = email.indexOf("@");
			 
			String email_id = email.substring(0, s);
			
			String email_domain = email.substring(s + 1);
			
			
			// view 단에서 사용할 데이터를 request에 넘겨줌
			request.setAttribute("name", name);
			request.setAttribute("h1", h1);
			request.setAttribute("h2", h2);
			request.setAttribute("h3", h3);
			request.setAttribute("email_id", email_id);
			request.setAttribute("email_domain", email_domain);
			
			
			super.setViewPage("/WEB-INF/customCenter/oneQueryform.jsp");
			
			
			
			
			
			
			
	}

}
