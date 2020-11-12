package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterKeywordSearch;
import product.model.KeywordSearchDAO;
import product.model.KeywordSearchVO;

public class SearchModalAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 검색어순위 리스트를 ArrayList를 통해 순서대로 받아온다 
		InterKeywordSearch kdao = new KeywordSearchDAO();
		List<KeywordSearchVO> rankingList =  kdao.selectRanking();
		
		request.setAttribute("rankingList", rankingList);

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/searchModal.jsp");

	}

}
