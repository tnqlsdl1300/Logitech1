package cs.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import cs.model.CustomCenterDAO;
import cs.model.InterCutomCenterDAO;
import cs.model.OneQueryVO;
import member.model.MemberVO;


public class OneQueryView extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session=request.getSession();
		MemberVO mvo= (MemberVO) session.getAttribute("loginuser");
		
		if(mvo == null) {
			
			
			String message = "먼저 로그인 해주세요.";
			
			String loc = request.getContextPath()+"/customCenter.sg";
			
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		
		}
		
		
		// DAO에 있는 내역을 가져와서 view단에서 뿌린다
		
		System.out.println("OneQueryView 서블릿이 실행되었습니다.");
		
		InterCutomCenterDAO cdao = new CustomCenterDAO();
		List<OneQueryVO> oqlist = cdao.getmyoq(mvo);
		
		request.setAttribute("oqlist", oqlist);
		
		super.setViewPage("/WEB-INF/customCenter/oneQueryView.jsp");
		
		
	}

}
