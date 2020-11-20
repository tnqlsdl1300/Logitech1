package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import member.model.MemberVO;
import myshop.model.ProductOptionVO;

public class ProdOptionOneDetailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다. @@
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
			// 관리자(admin)로 로그인한 경우
			String productserialid = request.getParameter("productserialid");
			productserialid = productserialid.replaceAll("%20", " ");
			
			InterManagerDAO mdao = new ManagerDAO();
			ProductOptionVO povo = mdao.prodOptionOneDetail(productserialid);
			
			request.setAttribute("povo", povo);
			
			// @@@ 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 @@@ //
			String goBackURL = request.getParameter("goBackURL");
			request.setAttribute("goBackURL", goBackURL);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/manager/product/prodOptionOneDetail.jsp");
		} else {
			// 로그인하지 않았거나 일반 사용자로 로그인한 경우
			String message = "관리자만 접근할 수 있습니다.";
			String loc = request.getContextPath()+"/manager/signIn.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if(loginManager != null && "admin".equals(loginManager.getManagerid())){}------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception{}

}
