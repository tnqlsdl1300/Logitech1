package login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("post".equalsIgnoreCase(method)) {
			// 로그인시
		}else {
			// 로그인 창에 들어왔을 시
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
			
		}

	}

}
