package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class SignOutController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();  // 세션 불러오기
		
		// @@ WAS 메모리 상에서 세션을 삭제하기 //
		session.invalidate();
		
		super.setRedirect(true);
		super.setViewPage(request.getContextPath() + "/manager/signIn.sg");
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception{}

}
