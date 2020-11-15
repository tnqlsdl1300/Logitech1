package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MemberRegisterAgreeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("post".equalsIgnoreCase(method)) {
			
			String agreethird = request.getParameter("agreethird");
			String agreesms = request.getParameter("agreesms");
			String agreeemail = request.getParameter("agreeemail");

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
			
		}else {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/agreeRegister.jsp");
		}
		
		

	}

}
