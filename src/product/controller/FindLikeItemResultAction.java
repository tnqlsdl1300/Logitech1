package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class FindLikeItemResultAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productid = request.getParameter("productid");

		if ("none".equals(productid)) {
			// 검색결과가 없을 시 
			request.setAttribute("pvo", null);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/main/findLikeItemResult.jsp");
			
		}else {
			// 검색결과가 있을 시
			
			InterProductDAO pdao = new ProductDAO();
			ProductVO pvo = pdao.selectLikeItemOne(productid);
			
			request.setAttribute("pvo", pvo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/main/findLikeItemResult.jsp");
			
		}

	}

}
