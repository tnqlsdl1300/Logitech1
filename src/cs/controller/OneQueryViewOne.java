package cs.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import cs.model.CustomCenterDAO;
import cs.model.InterCutomCenterDAO;
import cs.model.OneQueryVO;
import member.model.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class OneQueryViewOne extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session=request.getSession();
		
		MemberVO mvo= (MemberVO)session.getAttribute("loginuser");
		
		
		
		String seq_oq=request.getParameter("seq_oq");
		
		InterCutomCenterDAO cdao = new CustomCenterDAO();
		
		OneQueryVO oqvo=cdao.getoqvo(seq_oq);
		
		
		AES256 aes = new AES256(SecretMyKey.KEY);
		

		String mobile=mvo.getMobile();
		String email=mvo.getEmail();
		
		
		int s = email.indexOf("@");
		 
		String email_id = email.substring(0, s);
		
		String email_domain = email.substring(s + 1);
		
		
		String h1=mobile.substring(0, 3);
	    String h2=mobile.substring(3, 7);
	    String h3=mobile.substring(7);
	    
	     
	    
		// 로그인한 사용자의 회원번호와 문의내용 글을 남긴 회원번호와 같지 않다면 다른페이지로 보내주기.
		if (mvo.getMemberno() != oqvo.getFk_memberno())  {
			
			super.setViewPage("WEB-INF/customCenter/CustomCenter.jsp");
		}
		
		// 로그인한 사용자의 회원번호와 문의내용의 글을 남긴 회원번호와 같다면
		
		request.setAttribute("oqvo", oqvo);
		request.setAttribute("h1", h1);
		request.setAttribute("h2", h2);
		request.setAttribute("h3", h3);
		request.setAttribute("email_id", email_id);
		request.setAttribute("email_domain", email_domain);
		request.setAttribute("seq_oq", seq_oq);
		
		
		System.out.println("OneQueryViewOne 서블릿이 실행되었습니다.");
		
		
		super.setViewPage("WEB-INF/customCenter/oneQueryViewOne.jsp");
		

	}

}
