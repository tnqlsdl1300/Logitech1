package login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
				System.out.println(loginuser.getIdle());
				if (loginuser.getIdle() == 1) {
					// 1년 이상 미로그인 회원
					String message = "1년동안 로그인을 하지 않아 휴면처리 된 계정입니다. 관리자에게 문의하세요.";
					String loc = request.getContextPath() + "/index.sg";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}else {
					// 정상적인 회원일 시 session에 로그인한 회원정보 저장
					
					HttpSession session = request.getSession();
					session.setAttribute("loginuser", loginuser);
					
					if (loginuser.isRequirePwdChange()) {
						String message = "비밀번호를 변경한지 3개월이 지났습니다. 비밀번호를 변경해주세요.";
						String loc = request.getContextPath() + "/index.sg";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
						
					}else {
						// 메인으로 이동할 때 모달을 벗어나게 짜야함(질문)
						super.setRedirect(true);
						super.setViewPage(request.getContextPath() + "/index.sg");
					}
					
				}
				
			}else {

				String message = "로그인 실패";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}else {
			// 로그인 창에 들어왔을 시
			
			System.out.println("get으로 들어옴");
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
			
		}

	}

}
