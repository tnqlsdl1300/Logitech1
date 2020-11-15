package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model.*;

public class StoreValueSessionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String evoNo = request.getParameter("evoNo");
		
		HttpSession session = request.getSession();
		session.setAttribute("evoNo", evoNo);

	}

}
