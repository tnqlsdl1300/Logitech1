package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import myshop.model.OneQueryVO;
import myshop.model.ProductQAVO;

public class ProductQADetailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다. @@
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
			// 관리자(admin)로 로그인한 경우
			String seq_qa = request.getParameter("seq_qa");
			
			// 제품 문의 상세정보 select
			InterManagerDAO mdao = new ManagerDAO();
			ProductQAVO pqavo = mdao.productQADetail(seq_qa);
			
			request.setAttribute("pqavo", pqavo);
			
			// 문의 작성자 정보 select
			String userid = request.getParameter("userid");
			super.checkAgreeStatus(request, userid);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/manager/support/productQADetail.jsp");
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
