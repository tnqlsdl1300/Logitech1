package manager.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;

public class SignInController extends AbstractController {

	@Override
	public String toString() {
		return "@@@ 클래스 IndexController 의 인스턴스 메소드 toString() 호출함 @@@";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/manager/managerSignIn.jsp");
		} else {
			// 로그인한 경우
			String managerId = request.getParameter("managerId");
			String managerPwd = request.getParameter("managerPwd");
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("managerId", managerId);
			paraMap.put("managerPwd", managerPwd);
			
			InterManagerDAO mdao = new ManagerDAO();
			ManagerVO loginManager = mdao.selectOneManager(paraMap);
			
			if(loginManager != null) {
				HttpSession session = request.getSession();
				session.setAttribute("loginManager", loginManager);
				
				super.setRedirect(true);
				super.setViewPage("managerIndex.sg");
			} else {
				String message = "로그인 실패";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}//end of if(loginManager != null){}----------------------
		}// end of if("GET".equalsIgnoreCase(method)){}----------------------
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception{}

}
