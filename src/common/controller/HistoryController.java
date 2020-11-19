package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class HistoryController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String history = request.getParameter("history");
		
		// 최대 20건(20번 돌리면 멈추고 나오기)
		InterProductDAO pdao = new ProductDAO();
		// 로컬스토리지에서 받은 페이지 방문 기록값으로 디비에서 해당 제품들을 받아오는 메서드(최근 본 제품)
		List<ProductVO> pvoList = pdao.selectHistoryItem(history);

		request.setAttribute("pvoList", pvoList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/history.jsp");
	}

}
