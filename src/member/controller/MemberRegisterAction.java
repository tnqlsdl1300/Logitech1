package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String agreethird = request.getParameter("agreethird");
			String agreesms = request.getParameter("agreesms");
			String agreeemail = request.getParameter("agreeemail");
			
			if (agreethird == null) {
				agreethird = "0";
			}
			if (agreesms == null) {
				agreesms = "0";
			}
			if (agreeemail == null) {
				agreeemail = "0";
			}
			
			request.setAttribute("agreethird", agreethird);
			request.setAttribute("agreesms", agreesms);
			request.setAttribute("agreeemail", agreeemail);
			
			
			super.setRedirect(false);	// forward 방식
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
			
			
		}else {
			super.setRedirect(false);	// forward 방식
			super.setViewPage("/WEB-INF/member/agreeRegister.jsp");
		}
		
		

	}

}
