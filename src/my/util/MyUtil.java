package my.util;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// *** 주소의 ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메서드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		// http://localhost:9090/MyMVC/member/memberList.up
		String currentURL = request.getRequestURL().toString();
		
		// currentShowPageNo=7&sizePerPage=10&searchType=&searchWord=
		String queryString = request.getQueryString();
		
		// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=7&sizePerPage=10&searchType=&searchWord=
		if (queryString != null) {
			currentURL += "?" + queryString;
		}
		
		
		//  /member/memberList.up?currentShowPageNo=7&sizePerPage=10&searchType=&searchWord=
		
		//  /MyMVC
		String ctxPath = request.getContextPath();
		
		// indexOf => 특정 문자열을 찾아서 숫자로 위치를 알려주는 메서드
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		//						21					 + 		  6
		// 				http://localhost:9090				/MyMVC
		
		// member/memberList.up?currentShowPageNo=7&sizePerPage=10&searchType=&searchWord=
		currentURL = currentURL.substring(beginIndex + 1);
		//System.out.println(currentURL);
		return currentURL;
	}
	
	// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 **** //
	public static String secureCode(String contents) {
		
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
				  
		return contents;
	}
}
