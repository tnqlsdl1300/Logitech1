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
		String select = request.getParameter("select");
		String type = request.getParameter("type");	// 검색어:search, 인기검색어:rank
		
		List<ProductVO> pList = null;
		
		InterProductDAO pdao = new ProductDAO();

		
		if (select == null) {
			// 검색한 결과 받기
			pList = pdao.searchProductKeyword(keyword, type);
			
			// 검색한 키워드 DB에 cnt + 1 해주기
			int n = pdao.updateRankingKeyword(keyword);
		} else {
			// 사용자가 select를 선택했을 때 검색
			if (select == "highPrice" || select == "lowPrice") {
				pList = pdao.searchProductSelect(keyword, select, type);
			}else if(select == "sale") {
				// dao에 새로운 메서드 생성 sql문이 달라질듯
			}
			// else if favorite
			
		}
		
		
		request.setAttribute("pList", pList);
		request.setAttribute("keyword", keyword);
		request.setAttribute("type", type);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/searchResult.jsp");
	
		
		
	}

}
