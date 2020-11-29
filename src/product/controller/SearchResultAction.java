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
		
		String all = request.getParameter("all");
		
		if ("all".equals(all)) {
			// 메인화면에서 Best3의 더보기를 클릭했을 시 실행
			
			List<ProductVO> pList = null;
			InterProductDAO pdao = new ProductDAO();
			
			pList = pdao.searchAllBestProductSale();
			
			request.setAttribute("all", all);
			request.setAttribute("pList", pList);
			request.setAttribute("keyword", "전체");
			request.setAttribute("select", "sale");
			request.setAttribute("type", "search");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/searchResult.jsp");
			
		}else {
			// 검색창을 통해 검색했을 시 실행
			
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
				// 사용자가 select를 선택했을 때 검색(검색결과 페이지에서 정렬)

				if ("highPrice".equals(select) || "lowPrice".equals(select)) {
					pList = pdao.searchProductSelect(keyword, select, type);
					
				}else if("sale".equals(select)) {
					// dao에 새로운 메서드 생성 sql문이 달라질듯
					pList = pdao.selectBestOrder(keyword, type);
				}else if ("favorite".equals(select)) {
					pList = pdao.selectFavOrder(keyword, type);
				}
				
			}
			
			
			request.setAttribute("pList", pList);
			request.setAttribute("keyword", keyword);
			request.setAttribute("type", type);
			request.setAttribute("select", select);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/searchResult.jsp");
		}

		
	}

}
