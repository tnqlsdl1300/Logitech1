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
		
		// 검색한 결과 받기
		List<ProductVO> pList = pdao.searchProductKeyword(keyword, type);

		// 검색한 키워드 DB에 cnt + 1 해주기
		int n = pdao.updateRankingKeyword(keyword);
		
		/*if (n == 1) {
			System.out.println("업뎃 성공");
		}else {
			System.out.println("업뎃 실패");
		}*/
		
		request.setAttribute("pList", pList);
		request.setAttribute("keyword", keyword);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/searchResult.jsp");
	
		
		
	}

}
