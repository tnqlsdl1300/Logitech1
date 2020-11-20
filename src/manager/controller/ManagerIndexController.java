package manager.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;

public class ManagerIndexController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// @@@ Ajax(JSON) 를 사용하여 HIT 상품목록을 "더 보기" 방식으로 페이징 처리하기 위해 전체 문의 수를 알아오기 @@@ //
		// 오늘 작성한 일대일문의만 확인하기 위해 오늘 날짜를 알아온다.
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String today = format.format(cal.getTime());
		// System.out.println("~~~ 확인용 today ==> " + today);
		
		InterManagerDAO mdao = new ManagerDAO();
		int totalOQCount = mdao.totalOQCount(today);  // 오늘 등록된 일대일 문의 전체 개수를 알아온다.
		
		request.setAttribute("totalOQCount", totalOQCount);
		
		int totalPQACount = mdao.totalPQACount(today);  // 오늘 등록된 일대일 문의 전체 개수를 알아온다.
		
		request.setAttribute("totalPQACount", totalPQACount);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/manager/managerIndex.jsp");
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception{}

}
