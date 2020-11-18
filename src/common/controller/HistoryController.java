package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.InterProductDAO;
import product.model.ProductDAO;

public class HistoryController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String history = request.getParameter("history");
		
		
		history = history.substring(1, history.length());
		System.out.println(history);
		
		// 최대 20건(20번 돌리면 멈추고 나오기)
		InterProductDAO pdao = new ProductDAO();
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/history.jsp");
	}

}
