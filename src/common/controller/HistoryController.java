package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HistoryController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("히스토리 들어옴");
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/history.jsp");
	}

}
