package common.controller;

import java.io.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		description = "사용자가 웹에서 *.up 을 했을 경우 이 서블릿이 먼저 응답을 해주도록 한다.", 
		urlPatterns = { "*.up" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/Users/Subin/workspace(jsp)/Logitech/WebContent/WEB-INF/Command.properties", description = "*.up 에 대한 클래스의 매핑파일")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Map<String, Object> cmdMap = new HashMap<>();

	public void init(ServletConfig config) throws ServletException {
	/*
	        웹브라우저 주소창에서  *.up 을 하면 FrontController 서블릿이 응대를 해오는데 
	        맨 처음에 자동적으로 실행되어지는 메소드가 init(ServletConfig config) 이다.
	        여기서 중요한 것은 init(ServletConfig config) 메소드는 WAS(톰캣)가 구동되어진 후
	        딱 1번만 init(ServletConfig config) 메소드가 실행되어지고, 그 이후에는 실행이 되지 않는다. 
	        
	       그러므로 init(ServletConfig config) 메서드에는  FrontController 서블릿이 동작해야할 환경설정을 잡아주는데 사용된다
	*/
		
		Properties pr = new Properties();
		// Properties 는 Collection 중 HashMap 계열중의  하나로써
		// "key","value"으로 이루어져 있는것이다.
		// 그런데 중요한 것은 Properties 는 key도 String 타입이고, value도 String 타입만 가능하다는 것이다.
		// key는 중복을 허락하지 않는다. value 값을 얻어오기 위해서는 key값만 알면 된다.
		
		FileInputStream fis = null;
		// 특정 파일에 있는 내용을 읽어오기 위한 용도로 쓰이는 객체
		
		try {
			String props = config.getInitParameter("propertyConfig");
			// System.out.println("~~~ 확인용 props => " + props);
			// ~~~ 확인용 props => C:/Users/Subin/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 
			
			fis = new FileInputStream(props);
			// fis는 C:/Users/Subin/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용을 읽어오기 위한 용도로 쓰이는 객체이다
			
			pr.load(fis);
			/*
			 	pr.load(fis); 은 fis 객체를 사용하여 C:/Users/Subin/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용을 읽어오기 위한 용도로 쓰이는 객체이다
			 	Properties 클래스의 객체인 pr 에 로드시킨다
			 	그러면 pr 은 읽어온 파일(Command.properties)의 내용에서
			 	= 을 기준으로 왼쪽은 key, 오른쪽은 value 로 인식한다
			*/
			
			Enumeration<Object> en = pr.keys();
			/*
				pr.keys(); 은 
				C:/Users/Subin/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용물에서
				= 을 기준으로 왼쪽에 있는 모든 key들만 가져오는 것이다
			*/
			
			// en.hasMoreElements() 는 대충 JDBC에 rs.next()랑 비슷한거
			while(en.hasMoreElements()) {
				
				// Command.properties 파일에 있는 모든 것들을 밑에 출력해줌
				String key = (String)en.nextElement();
				// System.out.println("~~~~ 확인용 key => " + key);
				// System.out.println("~~~~ 확인용 value => " + pr.getProperty(key));
				
				String className = pr.getProperty(key);
				
				if (className != null) {
					
					className = className.trim();
					
					Class<?> cls = Class.forName(className);
					// <?> 은 generic인데 어떤 클래스 타입인지는 모르지만 클래스 타입이 들어온다는 뜻이다
					// String 타입으로 되어진 className 을 클래스화 시켜주는 것이다.
					// 주의할 점은 실제로 String 으로 되어져 있는 문자열이 클래스로 존재해야만 한다는 것이다.
					
					Object obj = cls.newInstance();
					// 클래스로부터 실제 객체(인스턴스)를 생성해주는 것이다
					
					// System.out.println("~~~ 확인용 obj.toString() => " + obj.toString());
					
					cmdMap.put(key, obj);
					// cmdMap 에서 키값으로 Command.properties 파일에 저장되어진 url 을 주면 
					// cmdMap 에서 해당 클래스에 대한 객체(인스턴스)를 얻어오도록 만든 것이다.
					
				}// end of if ---------------
				
			}// end of while(en.hasMoreElements())--------------
			
		}catch (ClassNotFoundException e) {
			System.out.println(">>> 문자열로 명명되어진 클래스가 존재하지 않습니다. <<<");
		} catch (FileNotFoundException e) {
			System.out.println(">>> C:/Users/Subin/workspace(jsp)/Logitech/WebContent/WEB-INF/Command.properties 파일이 없습니다");
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request, response);
	}
	
	// doGet(), doPost() 메서드가 호출받았을 때 requestProcess() 메서드로 넘어와 웹관련 처리를 해줌
	private void requestProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		// 웹브라우저의 주소 입력창에서
		// http://localhost:9090/MyMVC/member/idDuplicateCheck.up?userid=leess 와 같이 입력되었더라면
		//String url = request.getRequestURL().toString();
		//System.out.println("~~~ 확인용 url => " + url);
		// ~~~ 확인용 url => http://localhost:9090/MyMVC/member/idDuplicateCheck.up 
		
		String uri = request.getRequestURI();
		System.out.println("~~~ 확인용 uri => " + uri);
		// ~~~ 확인용 uri => /MyMVC/member/idDuplicateCheck.up
		
		String key = uri.substring(request.getContextPath().length());
		// 컨텍스트네임의 길이를 받아서 그 뒤로 다 잘라서 해당 페이지의 맞는 key 값을 구해준다
		// /MyMVC/main.up
		// /MyMVC/index.up
		
		// 여기서 cmdMap에 저장해둔 .java 파일을 받아온다
		// 사실상 jsp 페이지에서 action을 호출했을 때 .java 파일을 불러오는 것
		AbstractController action = (AbstractController)cmdMap.get(key);
		
		if (action == null) {
			System.out.println(">>> " + key + " URL 패턴에 매핑된 클래스는 없습니다. <<<");
		}else {
			
			try {
				action.execute(request, response);
				
				
				boolean bool = action.isRedirect();
				String viewPage = action.getViewPage();
				
				if (!bool) {
					// viewPage 에 명기된 view단 페이지로 forward(dispatcher)를 하겠다는 말이다.
		            // forward 되어지면 웹브라우저의 URL주소 변경되지 않고 그대로 이면서 화면에 보여지는 내용은 forward 되어지는 jsp 파일이다.
		            // 또한 forward 방식은 forward 되어지는 페이지로 데이터를 전달할 수 있다는 것이다.
					
					if(viewPage != null) {
						RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
						dispatcher.forward(request, response);
					}
					
				}else {
					// viewPage 에 명기된 주소로 sendRedirect(웹브라우저의 URL주소 변경됨)를 하겠다는 말이다.
		            // 즉, 단순히 페이지이동을 하겠다는 말이다. 
		            // 암기할 내용은 sendRedirect 방식은 sendRedirect 되어지는 페이지로 데이터를 전달할 수가 없다는 것이다. 
					if (viewPage != null) {
						response.sendRedirect(viewPage);						
					}

				}// end of if-else -------------------------------
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}

}
