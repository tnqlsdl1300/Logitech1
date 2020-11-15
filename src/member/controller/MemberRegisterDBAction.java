package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterDBAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		if ("post".equalsIgnoreCase(method)) {
			
			String agreethird = request.getParameter("agreethird");
			String agreesms = request.getParameter("agreesms");
			String agreeemail = request.getParameter("agreeemail");
			
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String mobile = request.getParameter("mobile");
			String email = request.getParameter("email");
			String birthday = request.getParameter("birthday");

			MemberVO member = new MemberVO();
			member.setName(name);
			member.setUserid(userid);
			member.setPwd(pwd);
			member.setMobile(mobile);
			member.setEmail(email);
			member.setBirthday(birthday);
			member.setAgreethird(agreethird);
			member.setAgreesms(agreesms);
			member.setAgreeemail(agreeemail);
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.registerMember(member);
			String message = "";
			String loc = "";
			if (n == 1) {
				message = "회원가입을 축하드립니다!";
				loc = request.getContextPath() + "/index.sg";
			}else {
				message = "회원가입에 실패했습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);	// forward 방식
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}else {
			super.setRedirect(false);	// forward 방식
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}

	}

}
