package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.EventVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class GoJoinEventAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if (loginuser == null) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/joinEvent.jsp");
		}else {
			// 사용자가 선택한 이벤트번호
			String seq_event = request.getParameter("seq_event");
			
			// DB에서 이벤트번호를 통해 이벤트 정보 가져오기
			
			InterProductDAO pdao = new ProductDAO();
			EventVO evo = pdao.selectOneEvent(seq_event);
			
			// index.sg 처음들어왔을 때 여기서 널포인터 떨어질 수 있음 주의
			
			request.setAttribute("evo", evo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/joinEvent.jsp");
		}
		
		

	}

}
