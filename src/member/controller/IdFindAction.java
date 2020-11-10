package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String message = "";
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("name", name);
			paraMap.put("email", email);
			
			String userid = mdao.findUserid(paraMap);
			
			if (userid == "") {
				message = "존재하지 않는 아이디입니다.";
			}else {
				message = "회원님의 아이디는 " + userid + " 입니다.";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("name", name);
			request.setAttribute("email", email);
			request.setAttribute("method", method);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/idFind.jsp");
			
		}else {
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/idFind.jsp");
		}


	}

}
