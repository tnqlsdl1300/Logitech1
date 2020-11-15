package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import product.model.*;


public class IndexController extends AbstractController {
	
	@Override
	public String toString() {
		return "@@@ 클래스 IndexController의 인스턴스 메서드 toString() 호출함 @@@";
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 이벤트 캐러셀 데이터 DB에서 불러오기
		InterProductDAO pdao = new ProductDAO();
		List<EventVO> eventList = pdao.selectCarousel();
		
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/index.jsp");
	}

}
