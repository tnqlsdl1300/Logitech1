package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import util.authentication.AuthenticationCode;

public class PwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			String mobile = request.getParameter("mobile");
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("userid", userid);
			paraMap.put("mobile", mobile);
			
			InterMemberDAO mdao = new MemberDAO();
			
			// 입력받은 정보가 DB에 저장되어 있는지 아닌지 찾는 메서드
			boolean isExist = mdao.pwdFindOneMember(paraMap);
			// isExist => true/회원존재		false/회원존재x

			JSONObject jsonObj = new JSONObject();
			
			if (isExist) {
				// 회원존재
				jsonObj.put("isExist", true);	

			}else{
				jsonObj.put("isExist", false);	
			}

			String json = jsonObj.toString();
			request.setAttribute("json", json);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		}else {
			// get방식으로 접속했을 때 (거부 - 패스워드창만 다시 띄우기)
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		}

		
		
	}

}
