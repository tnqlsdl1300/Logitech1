package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class SearchModalAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("get으로 들어옴");
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/searchModal.jsp");

	}

}
