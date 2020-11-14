package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class GoPwdChangeAction extends AbstractController {

	// userid를 가지고 비밀번호 변경페이지로 이동시켜주는 컨트롤러
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {

			String userid = request.getParameter("userid");
			
			// DB에서 검색할 userid를 받아서 넘겨줌
			request.setAttribute("userid", userid);
			
			// 비밀번호 변경페이지로 이동
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/pwdChange.jsp");

		}else {
			// get방식으로 접속했을 때 (거부 - 패스워드창만 다시 띄우기)
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		}

	}

}
