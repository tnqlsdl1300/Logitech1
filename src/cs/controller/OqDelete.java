package cs.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import cs.model.CustomCenterDAO;
import cs.model.InterCutomCenterDAO;
import cs.model.OneQueryVO;
import member.model.MemberVO;


public class OqDelete extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String seq_oq=request.getParameter("seq_oq");
		

		
		
		InterCutomCenterDAO cdao = new CustomCenterDAO();
		
		int n=cdao.deloq(seq_oq);
		
		HttpSession session=request.getSession();
		MemberVO mvo=(MemberVO)session.getAttribute("loginuser");
		List<OneQueryVO> oqlist = new ArrayList<OneQueryVO>();
		oqlist=cdao.getmyoq(mvo);
		
		request.setAttribute("oqlist", oqlist);
		
		
		super.setViewPage("/WEB-INF/customCenter/oneQueryView.jsp");
	}

}
