package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("post".equalsIgnoreCase(method)) {
			// 로그인 시도
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("password");
			
			String clientip = request.getRemoteAddr();
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			InterMemberDAO mdao = new MemberDAO();
			MemberVO loginuser = mdao.selectOneMember(paraMap);
			
			
			if (loginuser != null) {
				// 로그인 성공시

				if (loginuser.getIdle() == 1) {
					// 1년 이상 미로그인 회원
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("login", "restAccount");
					
					String json = jsonObj.toString();
					request.setAttribute("json", json);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/jsonview.jsp");
				}else {
					// 정상적인 회원일 시 session에 로그인한 회원정보 저장
					
					HttpSession session = request.getSession();
					session.setAttribute("loginuser", loginuser);
					
					if (loginuser.isRequirePwdChange()) {
						// 비밀번호 변경한지 3개월 이상 지난 회원(alert만 띄워주기)
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("login", "pwdChange");
						
						String json = jsonObj.toString();
						request.setAttribute("json", json);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/jsonview.jsp");
						
					}else {
						// 정상적으로 로그인 된 회원
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("login", "loginSuccess");
						
						String json = jsonObj.toString();
						request.setAttribute("json", json);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/jsonview.jsp");
					}
					
				}
				
			} else {
				// ==== 로그인이 실패한 경우 ==== // 
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("login", "loginFail");
				
				String json = jsonObj.toString(); // {"login":"fail"}
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
			
			
		}else {
			// 로그인 창에 들어왔을 시

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
			
		}

	}

}
