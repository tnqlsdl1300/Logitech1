package cs.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import cs.model.CustomCenterDAO;
import cs.model.InterCutomCenterDAO;
import cs.model.OneQueryVO;
import member.model.MemberVO;



public class OqModifyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String anform = request.getParameter("anform");
		String seq_oq = request.getParameter("seq_oq");
		
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("category", category);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("anform", anform);
		paraMap.put("seq_oq", seq_oq);
		
		InterCutomCenterDAO cdao = new CustomCenterDAO();
		
		int n=cdao.modifyoq(paraMap);
		
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
