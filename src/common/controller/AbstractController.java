package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class AbstractController implements InterCommand {

	/*
    === 다음의 나오는 것은 우리끼리한 약속이다. ===

    ※ view 단 페이지(.jsp)로 이동시 forward 방법(dispatcher)으로 이동시키고자 한다라면 
       자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
     
    super.setRedirect(false); 
    super.setViewPage("/WEB-INF/index.jsp");
    
    
          ※ URL 주소를 변경하여 페이지 이동시키고자 한다라면
          즉, sendRedirect 를 하고자 한다라면    
          자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
          
    super.setRedirect(true);
    super.setViewPage("registerMember.up");               
*/
	
	// isRedirect 변수의 값이 false 라면 forward 방식, true 라면 sendRedirect 방식으로 한다
	private boolean isRedirect = false;
	
	// viewPage 는 isRedirect 값이 false 라면 view단 페이지(.jsp)의 경로명이고
	// isRedirect 값이 true 라면 이동해야할 페이지 URL 주소이다 
	private String viewPage;

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	
	
	
}
