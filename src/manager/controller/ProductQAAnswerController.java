package manager.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;

public class ProductQAAnswerController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다. @@
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
			// 관리자(admin)로 로그인한 경우
			String seq_qa = request.getParameter("seq_qa");
			String oq_content = request.getParameter("oq_content");
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("seq_qa", seq_qa);
			paraMap.put("oq_content", oq_content);
			
			// 일대일 문의 답변 insert 메소드
			InterManagerDAO mdao = new ManagerDAO();
			int result = mdao.productQAAnswer(paraMap);
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("result", result);  // {"isExists":true} 또는 {"isExists":false}
			String json = jsonObj.toString();  // {"isExists":true} 또는 {"isExists":false} 을 문자열 형태로 만든다.
			// System.out.println(">>> 확인용 json ==> " + json);  // {"result":1}
			
			request.setAttribute("json", json);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		} else {
			// 로그인하지 않았거나 일반 사용자로 로그인한 경우
			String message = "관리자만 접근할 수 있습니다.";
			String loc = request.getContextPath()+"/manager/signIn.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if(loginManager != null && "admin".equals(loginManager.getUserid())){}------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception 

}
