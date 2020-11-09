package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CompanyInfoController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("컴퍼니 인포");
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/companyInfo.jsp");

	}

}
