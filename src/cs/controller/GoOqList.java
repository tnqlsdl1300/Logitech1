package cs.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import cs.model.CustomCenterDAO;
import cs.model.InterCutomCenterDAO;
import cs.model.OneQueryVO;


public class GoOqList extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		InterMemberDAO mdao = new MemberDAO();
		InterCutomCenterDAO cdao= new CustomCenterDAO();
		
		
		HttpSession session=request.getSession();
		MemberVO mvo=(MemberVO)session.getAttribute("loginuser");
		List<OneQueryVO> oqlist = new ArrayList<OneQueryVO>();
		oqlist=cdao.getmyoq(mvo);
		
		request.setAttribute("oqlist", oqlist);
		
		
		
		
		// end of 수정처리 //
		
		// start of oqlist // 
		
		
		super.setViewPage("/WEB-INF/customCenter/oneQueryView.jsp");

	}

}
