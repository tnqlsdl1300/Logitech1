package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;

public class ManagerRegisterController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/manager/manager/managerRegister.jsp");
		} else {
			String managerid = request.getParameter("managerid");
			String managerpwd = request.getParameter("managerpwd");
			String managertype = request.getParameter("managertype");
			String manageremail = request.getParameter("manageremail");
			String managermobile = request.getParameter("managermobile");
			
			ManagerVO mgvo = new ManagerVO();
			mgvo.setManagerid(managerid);
			mgvo.setManagerpwd(managerpwd);
			mgvo.setManagertype(managertype);
			mgvo.setManageremail(manageremail);
			mgvo.setManagermobile(managermobile);
			
			InterManagerDAO mdao = new ManagerDAO();
			int n = mdao.registerManager(mgvo);  // 예외 처리를 넘겨받았는데 처리하지 않는 이유는 다시 한 번 넘겨주기 때문이다.
			
			String message = "";
			String loc = "";
			
			if(n == 1) {
				message = "계정 등록 성공";
				loc = request.getContextPath() + "/manager/managerIndex.sg";  // 시작페이지
			} else {
				message = "계정 등록 실패";
				loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것
			}// end of if(n == 1){}----------------------
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}// end of if("GET".equalsIgnoreCase(method)){}----------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
