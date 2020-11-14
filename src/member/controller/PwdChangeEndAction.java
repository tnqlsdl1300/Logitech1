package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class PwdChangeEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			String newPwd = request.getParameter("newPwd");
			
			// 비밀번호 변경 메서드 실행 
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.updatePwd(userid, newPwd);
			
			
			JSONObject jsonObj = new JSONObject();
			if (n == 1) {
				// DB에 비밀번호 변경 성공 시
				jsonObj.put("pwd_change_success", true);	
				
			}else {
				// DB에 비밀번호 변경 실패 시
				jsonObj.put("pwd_change_success", false);	
			}
			
			String json = jsonObj.toString();
			request.setAttribute("json", json);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}else {
			// get방식으로 접속했을 때 (거부 - 패스워드창만 다시 띄우기)
			String message = "잘못된 접근방법 입니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
