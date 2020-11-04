package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController {
	
	@Override
	public String toString() {
		return "### 클래스 MainController의 인스턴스 메서드 toString() 호출함 ###";
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// System.out.println("### 확인용 MainController 의 인스턴스 메서드 execute 가 호출됨 ###");
		super.setRedirect(true);
		super.setViewPage("index.up");	// 	/MyMVC/index.up 페이지로 이동한다
		
	}

}
