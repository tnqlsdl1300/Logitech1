package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class IndexController extends AbstractController {
	
	@Override
	public String toString() {
		return "@@@ 클래스 IndexController의 인스턴스 메서드 toString() 호출함 @@@";
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("@@@ 확인용 IndexController 의 인스턴스 메서드 execute 가 호출됨 @@@");
		HttpSession session = request.getSession();
		System.out.println("index 코드: " +  session.getAttribute("code"));
		
		//InterProductDAO pdao = new ProductDAO();
		
		//List<ImageVO> imgList = pdao.ImageSelectAll();
		
		//request.setAttribute("imgList", imgList);
		
		// super.setRedirect(false);
		// this.setRedirect(false);
		// setRedirect(false); => 셋 다 같은말
		
		super.setViewPage("/WEB-INF/index.jsp");
		
	}

}
