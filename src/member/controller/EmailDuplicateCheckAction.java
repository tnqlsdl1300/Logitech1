package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class EmailDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String email = request.getParameter("email");

		InterMemberDAO mdao = new MemberDAO();
		boolean isExists = mdao.emailDuplicateCheck(email);
		
		// JSON 객체 사용을 위해 선언(lib으로 받아옴) => {"키":value} 형식으로 객체를 생성해 줌
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isExists", isExists);	// {"isExists":true} 또는 {"isExists":false} 으로 만들어준다
		
		String json = jsonObj.toString();		// JSON 객체를 view 단에 찍어주기 위해 문자열 형태인 {"isExists":true} 또는 {"isExists":false}으로 변환시킴(ㄹㅇ 괄호까지 다 찍힘)
		// System.out.println(">>> 확인용 => " + json);
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");	// jsonview.jsp는 재사용이 가능하다. 그냥 끌어와서쓰면 됨

	}

}
