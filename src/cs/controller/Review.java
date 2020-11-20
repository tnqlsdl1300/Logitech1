package cs.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class Review extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		super.setViewPage("/WEB-INF/customCenter/review.jsp");
		
		
		
		
		HttpSession session =request.getSession();
		
		MemberVO mvo=  (MemberVO) (session.getAttribute("loginuser") );
		
		
		String userid=mvo.getUserid();
		

		
		
		
	
		
		
		
		
		
	}

}
