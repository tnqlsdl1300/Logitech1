package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import member.model.MemberVO;
import myshop.model.OneQueryVO;

public class OneQueryDetailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다. @@
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
			// 관리자(admin)로 로그인한 경우
			String seq_oq = request.getParameter("seq_oq");
			
			
			// 일대일 문의 상세정보 select
			InterManagerDAO mdao = new ManagerDAO();
			OneQueryVO oqvo = mdao.oneQueryDetail(seq_oq);
			
			request.setAttribute("oqvo", oqvo);
			
			// 문의 작성자 정보 select
			String userid = request.getParameter("userid");
			super.checkAgreeStatus(request, userid);
			
			// @@@ 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 @@@ //
			String goBackURL = request.getParameter("goBackURL");
			request.setAttribute("goBackURL", goBackURL);
			request.setAttribute("method", method);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/manager/support/oneQueryDetail.jsp");
		} else {
			// 로그인하지 않았거나 일반 사용자로 로그인한 경우
			String message = "관리자만 접근할 수 있습니다.";
			String loc = request.getContextPath()+"/manager/signIn.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if(loginManager != null && "admin".equals(loginManager.getUserid())){}------------------		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
