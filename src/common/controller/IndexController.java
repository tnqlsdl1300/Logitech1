package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.*;


public class IndexController extends AbstractController {
	
	@Override
	public String toString() {
		return "@@@ 클래스 IndexController의 인스턴스 메서드 toString() 호출함 @@@";
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		///// 시작: 이벤트 캐러셀 데이터 DB에서 불러오기
		InterProductDAO pdao = new ProductDAO();
		List<EventVO> eventList = pdao.selectCarousel();
		
		// 진행중인 이벤트가 없을 시 문제가 생길 듯(널포인터)
		
		request.setAttribute("eventList", eventList);
		
		///// 끝: 이벤트 캐러셀 데이터 DB에서 불러오기
		
		
		///// 시작: 판매순으로 정렬한 각 3개씩의 물품 데이터 DB에서 불러오기
		List<ProductVO> best3ItemList = pdao.selectBest3Items();
		///// 끝: 판매순으로 정렬한 각 3개씩의 물품 데이터 DB에서 불러오기
		
		
		///// 시작: 카테고리별 판매순으로 정렬한 각 3개씩의 물품 데이터 DB에서 불러오기
		List<ProductVO> mouseList = pdao.selectBestCategoryOrder("mouse");
		List<ProductVO> keyboardList = pdao.selectBestCategoryOrder("keyboard");
		List<ProductVO> headsetList = pdao.selectBestCategoryOrder("headset");
		List<ProductVO> speakerList = pdao.selectBestCategoryOrder("speaker");
		///// 끝: 카테고리별 판매순으로 정렬한 각 3개씩의 물품 데이터 DB에서 불러오기
		
		request.setAttribute("best3ItemList", best3ItemList);
		
		request.setAttribute("mouseList", mouseList);
		request.setAttribute("keyboardList", keyboardList);
		request.setAttribute("headsetList", headsetList);
		request.setAttribute("speakerList", speakerList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/index.jsp");
	}

}
