package cs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cs.model.CustomCenterDAO;
import cs.model.FaqVO;
import cs.model.InterCutomCenterDAO;
import my.util.MyUtil;


public class FaqSearch extends AbstractController {


	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			
		InterCutomCenterDAO cdao = new CustomCenterDAO();
			String method=request.getMethod();
			if (!method.equals("post")) {
				// 처음에 get방식으로 뿌려줄때
				
				
				
				System.out.println("SearchList.java 서블릿이 실행되었습니다 ");
				String searchWord=request.getParameter("searchWord");
				
				System.out.println(searchWord);
				
			}
			
			
			// post 방식으로 뿌려줄때.
			
			
			
			
		
			
			// 서블릿으로 값이 넘어가지 않음.
			
			
			String searchWord = request.getParameter("searchWord");
			
			
			Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("searchWord", searchWord);
					
			// *** 페이징 처리를 한 모든 FAQ 또는 검색한 FAQ 목록 보여주기 *** //

						
				String currentShowPageNo = "1";
			 
				String sizePerPage = "5";
			
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			List<FaqVO> faqList = cdao.selectPagingFaq(paraMap);
			
			request.setAttribute("faqList", faqList);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("sizePerPage", sizePerPage);
			
			
			// **** ========= 페이지바 만들기 ========= **** //

			int totalPage = cdao.getTotalPage(paraMap);
			String pageBar = "";
			
			int blockSize = 5;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 5개)까지만 증가하는 용도이다. 
			
			int pageNo = 0;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! // 
			
			pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
						
			if( searchWord == null ) {
				searchWord = "";
			}
			
			
			// **** [맨처음][이전] 만들기 **** //
			 
			
			if( pageNo != 1 ) {
				pageBar += "&nbsp;<a href='faqSearch.sg?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='faqSearch.sg?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
			}
			
			
			
			
			while( !(loop > blockSize || pageNo > totalPage ) ) {
				
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
				}
				else {
					pageBar += "&nbsp;<a href='faqSearch.sg?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;"; 
				}
				
				loop++;   // 1 2 3 4 5
				          
				pageNo++; //  1  2  3  4  5  6  7  8  9 10 
				          // 11 12 13 14 15 16 17 18 19 20 
				          // 21 
				
			}// end of while---------------------------------
			
			
			// **** [다음][마지막] 만들기 **** //
			 
			if( !( pageNo > totalPage ) ) {
				pageBar += "&nbsp;<a href='faqSearch.sg?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='faqSearch.sg?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"'>[마지막]</a>&nbsp;";
			}
			
			
			request.setAttribute("pageBar", pageBar);
			

			// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
			String currentURL = MyUtil.getCurrentURL(request);
			// FAQ조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
			
		//	System.out.println("currentURL => " + currentURL);
		//  currentURL => member/memberList.up?currentShowPageNo=15&sizePerPage=5&searchType=name&searchWord=%ED%99%8D%EC%8A%B9%EC%9D%98
			
			currentURL = currentURL.replaceAll("&", " ");
		//	System.out.println("currentURL => " + currentURL); 
		//  currentURL => member/memberList.up?currentShowPageNo=15 sizePerPage=5 searchType=name searchWord=%ED%99%8D%EC%8A%B9%EC%9D%98	
			
			request.setAttribute("goBackURL", currentURL);
			
		//	super.setRedirect(false);
			
			super.setViewPage("/WEB-INF/customCenter/customCenter.jsp");
		
		

		}
		
	}


