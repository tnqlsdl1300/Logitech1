package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;

public class PwdChangeAction extends AbstractController {

	// 입력받은 인증코드를 맞는지 확인해주는 컨트롤러[비밀번호 찾기]
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			// 사용자로부터 입력받은 인증번호
			String inputCode = request.getParameter("inputCode");

			// session에 저장된 발송된 인증번호
			HttpSession session = request.getSession();
			String sessionCode = (String) session.getAttribute("code");
			
			// 입력받은 인증번호와 session의 인증번호를 비교하여 맞을 시 json을 통해 true,false 반환
			JSONObject jsonObj = new JSONObject();
			if (inputCode.equals(sessionCode)) {
				jsonObj.put("code_success", true);
				
				// session에서 인증번호 부분만 삭제
				session.removeAttribute("code");
				
			}else {
				jsonObj.put("code_success", false);
			}
			
			String json = jsonObj.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		}else {
			// get방식으로 접근시 거부(뒤로가기) 
			
			String message = "잘못된 접근방법 입니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		

	}

}
