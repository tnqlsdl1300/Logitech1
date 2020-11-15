package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class JoinEventAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String seq_event = request.getParameter("seq_event");
			String memberno = request.getParameter("memberno");
			String eventcomment = request.getParameter("eventcomment");
			
			// joinevent 테이블에서 이미 이벤트에 참여한 회원인지 검사하는 메서드
			InterMemberDAO mdao = new MemberDAO();
			boolean bool = mdao.joinEventCheck(seq_event, memberno);
			
			JSONObject jsonObj = new JSONObject();
			
			if (bool) {
				// 이미 해당 이벤트에 참여한 회원일 경우
				jsonObj.put("event_duplication", true);
				
			}else {
				// 해당 이벤트에 참여하지 않은 회원일 경우
				// DB joinevent 테이블에 입력한 데이터 넣어주기

				// joinevent 테이블에 데이터를 넣어 이벤트 참여를 시켜주는 메서드
				int n = mdao.insertEventMember(seq_event, memberno, eventcomment);
				
				if (n == 1) {
					// DB 입력 성공
					jsonObj.put("event_join_success", true);
				}else {
					// DB 입력 실패
					jsonObj.put("event_join_fail", true);
				}
				
			}
			

			String json = jsonObj.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}else {
			// get방식으로 접근시 거부(뒤로가기) 
			
			String message = "잘못된 접근방법 입니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
