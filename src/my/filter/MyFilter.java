package my.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
	=== 필터란 ? ===
	필터란 Servlet 2.3 버전에 추가된 것으로,
	클라이언트의 요청을 서블릿이 받기 전에 가로채어 필터에 작성된 내용을 수행하는 것을 말한다. 
	따라서 필터를 사용하면 클라이언트의 요청을 가로채서 서버 컴포넌트의 추가적인 다른 기능을 수행시킬 수 있다.
	
	<< 필터 적용 순서 >>
	1. Filter 인터페이스를 구현하는 자바 클래스를 생성.
	2. /WEB-INF/web.xml 에 filter 엘리먼트를 사용하여 필터 클래스를 등록한다. 
*/

public class MyFilter implements Filter{

	@Override
	public void destroy() {
		// 필터 인스턴스를 종료시키기 전에 호출되는 메소드 
	    // 지금은 여기에 기술할 것이 없다.
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 필터의 로직을 작성해주는 곳 
		/*
			POST 방식으로 넘겨온 데이터를 처리해주는 메소드가
			doPost(request, response) 인데 넘겨받은 데이터가 한글일 경우
			아래와 같이 해주어야만 한글이 안깨지고 잘 나온다.
			중요한 것은 request.getParameter("변수명"); 이러한 명령보다
			먼저 기술을 해주어야만 한다는 것이다.
		*/
		request.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// 서블릿 컨테이너가 필터 인스턴스를 초기화하기 위해서 호출되는 메소드 
	    // 지금은 여기에 기술할 것이 없다.
		
	}
	
	
	
}
