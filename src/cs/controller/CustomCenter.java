package cs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cs.model.CategoryVO;
import cs.model.CustomCenterDAO;
import cs.model.FaqVO;
import cs.model.InterCutomCenterDAO;
import cs.model.Sub_categoryVO;
import my.util.MyUtil;

public class CustomCenter extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		InterCutomCenterDAO cdao = new CustomCenterDAO();
		System.out.println("CustomCenter.java 서블릿이 실행되었습니다 ");
		
		String searchWord=request.getParameter("searchWord");
		String searchSub=request.getParameter("searchSub");
		String searchSubcate=request.getParameter("searchSubcate");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = request.getParameter("sizePerPage");
		
		System.out.println(searchSubcate);
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("searchWord", searchWord);
		paraMap.put("searchSub", searchSub);
		paraMap.put("searchSubcate", searchSubcate);
		
		
		// *** 페이징 처리를 한 모든 FAQ 또는 검색한 FAQ 목록 보여주기 *** //
		
		if( currentShowPageNo == null ) {
			currentShowPageNo = "1";
		}
		
		if( sizePerPage == null )
			
			{ 
			sizePerPage = "5";
		}
			
		try {
			Integer.parseInt(currentShowPageNo);
		}   catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		List<FaqVO> faqList = cdao.selectPagingFaq(paraMap);
		
		request.setAttribute("faqList", faqList);
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("sizePerPage", sizePerPage);
		
		
		// ================세부카테고리 가져오기====================
		
		/*
		if(searchSub == null || searchSub.trim().equals("")) {
			
			searchSub= "10";
			
		}
		*/
		List<Sub_categoryVO> scatelist = new ArrayList<>();
		
		scatelist=cdao.getSub_Category(searchSub); 
		request.setAttribute("scatelist", scatelist);
		request.setAttribute("searchSub", searchSub);
		
		// ================세부카테고리 가져오기====================
		
		
		// ====================== 카테고리 목록가져오기 =================
		List<CategoryVO> categorylist = new ArrayList<>();
		categorylist=cdao.getCategory();
		
		request.setAttribute("categorylist", categorylist);
		
		
		// ====================== 카테고리 가져오기 =================
		
	
		// ================== 검색건수 가져오기 ====================== //
		
		int searchResult = cdao.getSearchResult(paraMap);
		request.setAttribute("searchResult", searchResult);
		
		// ================== 검색건수 가져오기 ====================== //
		
		
		
		// **** ========= 페이지바 만들기 ========= **** //
		
		// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
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
		
		if( searchSub == null ) {
			searchSub = "";
			
		}
		
		if( searchSubcate == null ) {
			searchSubcate = "";
			
		}
		
		// **** [맨처음][이전] 만들기 **** //
		 
		
		if( pageNo != 1 ) {
			pageBar += "&nbsp;<a href='customCenter.sg?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"&searchSub="+searchSub+"'>[맨처음]</a>&nbsp;";
			pageBar += "&nbsp;<a href='customCenter.sg?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"&searchSub="+searchSub+"'>[이전]</a>&nbsp;";
		}
		
		
		while( !(loop > blockSize || pageNo > totalPage ) ) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
			}
			
			else {
				pageBar += "&nbsp;<a href='customCenter.sg?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"&searchSub="+searchSub+"'>"+pageNo+"</a>&nbsp;"; 
			}
			
			loop++;  
			          
			pageNo++; 
			
		}// end of while---------------------------------
		
		
		// **** [다음][마지막] 만들기 **** //
		 
		if( !( pageNo > totalPage ) ) {
			
			pageBar += "&nbsp;<a href='customCenter.sg?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"&searchSub="+searchSub+"'>[다음]</a>&nbsp;";
			pageBar += "&nbsp;<a href='customCenter.sg?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchWord="+searchWord+"&searchSub="+searchSub+"'>[마지막]</a>&nbsp;";
			
		}
		
		
		request.setAttribute("pageBar", pageBar);
		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		
		String currentURL = MyUtil.getCurrentURL(request);
		// FAQ조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
		
		currentURL = currentURL.replaceAll("&", " ");
		
		request.setAttribute("goBackURL", currentURL);
		
		super.setViewPage("/WEB-INF/customCenter/customCenter.jsp");
		
		
		
			
	}
	
	

}
