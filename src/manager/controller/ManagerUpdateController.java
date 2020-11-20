package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.ManagerVO;
import member.model.MemberVO;

public class ManagerUpdateController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 나의 정보를 수정하기 위한 전제조건은 먼저 자신의 계정으로 로그인 해야 하는 것이다.
		if(super.checkLogin(request)) {
			// 로그인 한 경우
			String managerid = request.getParameter("managerid");
			
			HttpSession session = request.getSession();
			ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
			if(loginManager.getManagerid().equals(managerid)) {
				// 총 관리자는 모든 정보를 수정할 수 있도록 수정할 아이디를 조회한다.
				String updateid = request.getParameter("updateid");
				asdasd
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/manager/manager/managerUpdate.jsp");
			} else {
				// 로그인 했지만 자신이 아닌 타인의 정보를 수정하려는 경우
				String message = "다른 관리자의 정보는 수정할 수 없습니다!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}// end of if(loginUser.getUserid().equals(userid)){}-----------------------
		} else {
			// 로그인 안 한 경우
			String message = "관리자 정보를 수정하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if(super.checkLogin(request)){}------------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
