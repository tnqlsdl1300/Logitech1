package mypage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.PurchaseVO;
import product.model.*;

public class MyPoint extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterProductDAO pdao = new ProductDAO();
		
		int usernum = 9;
		
		/*
		ArrayList<PurchaseVO> pointlist = new ArrayList<>();
		
		pointlist = pdao.selectPoint(usernum);
		*/
		
		
		// 해당 유저의 총 포인트 금액 가져오기
		String totalpt = pdao.selectSumPoint(usernum);
		
		if(totalpt == null){
			totalpt = "0";
		}
		
		// 해당 유저가 사용한 포인트 금액 가져오기
		String pt = pdao.selectUsedPoint(usernum);
		if(pt == null){
			pt = "0";
		}
		
		request.setAttribute("totalpt", totalpt);
		// 포인트 내역 조회 페이징 처리 
		// currentShowPageNo : 사용자가 보고자하는 페이지 넘버
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo는 null이 된다.
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		// currentShowPageNo가 null이라면 1로 바꿔주어야 한다. (null 페이지는 안됨)
		if(currentShowPageNo == null){
			currentShowPageNo = "1";
		}
		
		// 한 페이지당 화면상에 보여줄 제품의 개수는 10으로 한다. 
		// GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo에 숫자 아닌 문자로 입력한 경우
		// 이를 무작위로 조작하지 못하도록 exception을 설정해준다.
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e){
			currentShowPageNo = "1";
		}
				
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("usernum", Integer.toString(usernum));
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		ArrayList<PurchaseVO> pointlist = pdao.selectPointList(paraMap);
		request.setAttribute("pointlist", pointlist);
		
		// 페이지바를 만들기 위해서 특정카테고리의 제품개수에 대한 총페이지수를 알아오기
		int totalPage = pdao.getTotalPage(usernum);
		
		String pageBar = "";
		int blockSize = 10; // 블럭 당 보여지는 페이지 번호의 개수이다.
		int loop = 1; // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수까지만 증가하는 용도이다.
		int pageNo = 0; // 페이지바에서 보여지는 첫번째 번호이다.
		
		// 다음은 pageNo를 구하는 공식
		pageNo = ((Integer.parseInt(currentShowPageNo) - 1) / blockSize) * blockSize + 1;
        
		
		// **** [이전][맨처음] 만들기 **** //
				// pageNo - 1 == 11 - 1 == 10 ==> currentShowPageNo
				if (pageNo != 1) {
					pageBar += "&nbsp;<a href='mypoint.sg?currentShowpage=1'>[맨처음]</a>&nbsp;";
					pageBar += "&nbsp;<a href='mypoint.sg?currentShowpage=" + (pageNo - 1) + "'>[이전]</a>&nbsp;";
				}

				while (!(loop > blockSize || pageNo > totalPage)) {

					if (pageNo == Integer.parseInt(currentShowPageNo)) {
						pageBar += "&nbsp;<span style='color:red; padding: 2px 4px;'>" + pageNo
								+ "</span>&nbsp;";
					} else {
						pageBar += "&nbsp;<a href='mypoint.sg?currentShowPageNo=" + pageNo + "'>"
								+ pageNo + "</a>&nbsp;";
					}

					loop++; // 1 2 3 4 5 6 7 8 9 10

					pageNo++; // 1 2 3 4 5 6 7 8 9 10
								// 11 12 13 14 15 16 17 18 19 20
								// 21
				} // end of while---------------------------------

				// **** [다음][마지막] 만들기 **** //
				// pageNo ==> 11
				if (!(pageNo > totalPage)) {
					pageBar += "&nbsp;<a href='mypoint.sg?currentShowPageNo=" + pageNo + "'>[다음]</a>&nbsp;";
					pageBar += "&nbsp;<a href='mypoint.sg?currentShowPageNo=" + totalPage + "'>[마지막]</a>&nbsp;";
				}

		request.setAttribute("pageBar", pageBar);
		request.setAttribute("usedpoint", pt);
		//request.setAttribute("pointlist", pointlist);
		

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_point.jsp");
	}

}
