package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class FindLikeItemAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("취향찾기");
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/main/findLikeItem.jsp");

	}

}
