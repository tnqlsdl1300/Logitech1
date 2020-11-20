package cs.controller;




import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import cs.model.CustomCenterDAO;
import cs.model.InterCutomCenterDAO;
import cs.model.OneQueryVO;
import member.model.MemberVO;



public class OneQueryExcute extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		if(request.getMethod().equalsIgnoreCase("get") ) {
			
			 
			setViewPage("/WEB-INF/customCenter/customCenter.jsp");
			// 고객센터로
		}
		
		
		
		HttpSession session=request.getSession();
		
		MemberVO mvo=(MemberVO) session.getAttribute("loginuser");
		

		
		int memberno= mvo.getMemberno();
		String category=request.getParameter("category");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String anform = request.getParameter("anform");
		
		
		
		OneQueryVO onequeryvo = new OneQueryVO();
		
		
		onequeryvo.setFk_memberno(memberno);
		onequeryvo.setCategory(category);
		onequeryvo.setTitle(title);
		onequeryvo.setContent(content);
		onequeryvo.setAnswerform(anform);
		
		InterCutomCenterDAO cdao = new CustomCenterDAO();
		
		
		int result=0;
		
		result=cdao.submitoneQuery(onequeryvo);
		
		if(result == 1) {
			
			String message = "일대일 문의 등록이 성공하였습니다. ";
			String loc = request.getContextPath()+"/customCenter.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
			
		}
		
		else {
			
			String message = "일대일 문의 등록이 실패하였습니다. ";
			String loc = request.getContextPath()+"/customCenter.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;  // 메소드 종료
		}
		
		
		
		
		
		
		
		
	}

}
