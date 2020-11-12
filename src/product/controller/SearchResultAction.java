package product.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class SearchResultAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String keyword = request.getParameter("keyword");
		String type = request.getParameter("type");	// 검색어:search, 인기검색어:rank
		
		InterProductDAO pdao = new ProductDAO();
		
		List<ProductVO> pList = pdao.searchProductKeyword(keyword, type);
		
		

		// 키워드 cnt + 1 업데이트도 해줘야 함
		
		request.setAttribute("pList", pList);
		request.setAttribute("keyword", keyword);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/searchResult.jsp");
	
		
		
	}

}
