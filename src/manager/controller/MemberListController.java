package manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import member.model.MemberVO;
import my.util.MyUtil;

public class MemberListController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다.
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
			// 관리자(admin)로 로그인한 경우
			
			String searchOption1 = request.getParameter("searchOption1");
			String searchKey1 = request.getParameter("searchKey1");
			String searchOption2 = request.getParameter("searchOption2");
			String searchKey2 = request.getParameter("searchKey2");
			
			// @@ 넘어온 옵션이 이메일동의, 문자동의, 휴면, 탈퇴일 경우 입력값을 데이터베이스 입력 형태로 변환하기
			if("agreeemail".equals(searchOption1)) {
				if("O".equalsIgnoreCase(searchKey1)) {
					searchKey1 = "1";
				} else {
					searchKey1 = "0";
				}
			}// end of if("agreeemail".equals(searchOption1)){}
			
			if("agreeemail".equals(searchOption2)) {
				if("O".equalsIgnoreCase(searchKey2)) {
					searchKey2 = "1";
				} else {
					searchKey2 = "0";
				}
			}// end of if("agreeemail".equals(searchOption2)){}
			
			if("agreesms".equals(searchOption1)) {
				if("O".equalsIgnoreCase(searchKey1)) {
					searchKey1 = "1";
				} else {
					searchKey1 = "0";
				}
			}// end of if("agreesms".equals(searchOption1)){}
			
			if("agreesms".equals(searchOption2)) {
				if("O".equalsIgnoreCase(searchKey2)) {
					searchKey2 = "1";
				} else {
					searchKey2 = "0";
				}
			}// end of if("agreesms".equals(searchOption2)){}
			
			if("idle".equals(searchOption1)) {
				if("정상".equals(searchKey1)) {
					searchKey1 = "0";
				} else {
					searchKey1 = "1";
				}
			}// end of if("idle".equals(searchOption1)){}
			
			if("idle".equals(searchOption2)) {
				if("정상".equals(searchKey2)) {
					searchKey2 = "0";
				} else {
					searchKey2 = "1";
				}
			}// end of if("idle".equals(searchOption2)){}
			
			if("status".equals(searchOption1)) {
				if("정상".equals(searchKey1)) {
					searchKey1 = "0";
				} else if("예정".equals(searchKey1)) {
					searchKey1 = "1";
				} else {
					searchKey1 = "2";
				}
			}// end of if("status".equals(searchOption1)){}
			
			if("status".equals(searchOption2)) {
				if("정상".equals(searchKey2)) {
					searchKey2 = "0";
				} else if("예정".equals(searchKey2)) {
					searchKey2 = "1";
				} else {
					searchKey2 = "2";
				}
			}// end of if("status".equals(searchOption2)){}
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("searchOption1", searchOption1);
			paraMap.put("searchKey1", searchKey1);
			paraMap.put("searchOption2", searchOption2);
			paraMap.put("searchKey2", searchKey2);
			
			// @@@ 페이징 처리를 하여 모든 회원 또는 검색한 회원 목록 보여주기 @@@
			String currentPageNo = request.getParameter("currentPageNo");
			
			String sizePerPage = request.getParameter("sizePerPage");
			
			boolean bFlag = true;
			try {
				Integer.parseInt(currentPageNo);
			} catch (Exception e) {
				bFlag = false;
			}// end of try~catch{}--------------------------
			
			if(currentPageNo == null || !bFlag) {
				currentPageNo = "1";
			}// end of if(currentPageNo == null){}-----------------------
			
			if(sizePerPage == null || !( "5".equals(sizePerPage) || "10".equals(sizePerPage) || "20".equals(sizePerPage) )) {
				// GET 방식으로 사용자가 임의의 숫자로 접근할 경우에도 10으로 제한한다.
				sizePerPage = "10";
			}// end of if(sizePerPage == null || !( "5".equals(sizePerPage) || "10".equals(sizePerPage) || "20".equals(sizePerPage) )){}
			
			paraMap.put("currentPageNo", currentPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			String selectedHead = request.getParameter("selectedHead");
			String sortFlag = request.getParameter("sortFlag");
			paraMap.put("selectedHead", selectedHead);
			paraMap.put("sortFlag", sortFlag);
			
			InterManagerDAO mdao = new ManagerDAO();
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);
			
			// @@ 데이터베이스에서 select 한 후 원래의 검색어로 되돌려 view 단으로 넘겨주기
			if("agreeemail".equals(searchOption1)) {
				if("1".equalsIgnoreCase(searchKey1)) {
					searchKey1 = "O";
				} else {
					searchKey1 = "X";
				}
			}// end of if("agreeemail".equals(searchOption1)){}
			
			if("agreeemail".equals(searchOption2)) {
				if("1".equalsIgnoreCase(searchKey2)) {
					searchKey2 = "O";
				} else {
					searchKey2 = "X";
				}
			}// end of if("agreeemail".equals(searchOption2)){}
			
			if("agreesms".equals(searchOption1)) {
				if("1".equalsIgnoreCase(searchKey1)) {
					searchKey1 = "O";
				} else {
					searchKey1 = "X";
				}
			}// end of if("agreesms".equals(searchOption1)){}
			
			if("agreesms".equals(searchOption2)) {
				if("1".equalsIgnoreCase(searchKey2)) {
					searchKey2 = "O";
				} else {
					searchKey2 = "X";
				}
			}// end of if("agreesms".equals(searchOption2)){}
			
			if("idle".equals(searchOption1)) {
				if("0".equals(searchKey1)) {
					searchKey1 = "정상";
				} else {
					searchKey1 = "휴면";
				}
			}// end of if("idle".equals(searchOption1)){}
			
			if("idle".equals(searchOption2)) {
				if("0".equals(searchKey2)) {
					searchKey2 = "정상";
				} else {
					searchKey2 = "휴면";
				}
			}// end of if("idle".equals(searchOption2)){}
			
			if("status".equals(searchOption1)) {
				if("0".equals(searchKey1)) {
					searchKey1 = "정상";
				} else if("1".equals(searchKey1)) {
					searchKey1 = "예정";
				} else {
					searchKey1 = "탈퇴";
				}
			}// end of if("status".equals(searchOption1)){}
			
			if("status".equals(searchOption2)) {
				if("0".equals(searchKey2)) {
					searchKey2 = "정상";
				} else if("1".equals(searchKey2)) {
					searchKey2 = "예정";
				} else {
					searchKey2 = "탈퇴";
				}
			}// end of if("status".equals(searchOption2)){}
			
			request.setAttribute("memberList", memberList);
			request.setAttribute("searchOption1", searchOption1);
			request.setAttribute("searchKey1", searchKey1);
			request.setAttribute("searchOption2", searchOption2);
			request.setAttribute("searchKey2", searchKey2);
			request.setAttribute("currentPageNo", currentPageNo);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("selectedHead", selectedHead);
			request.setAttribute("sortFlag", sortFlag);
			
			int totalPage = mdao.getTotalPage(paraMap);
			
			String pageBar = "";
			int blockSize = 10;  // blockSize 는 한 블럭당 표시할 페이지 수
			int loop = 1;  		 // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지 개수(지금은 10개)까지만 증가하는 용도이다.
			int pageNo = 0;
			// pageNo 은 페이지바에서 보여지는 첫 번째 번호
			// ★★ 다음은 pageNo 을 구하는 공식이다.
			pageNo = ( (Integer.parseInt(currentPageNo) - 1)/blockSize ) * blockSize + 1;
			
			if(searchOption1 == null) {
				searchOption1 = "";
			}// end of if(searchOption1 == null){}-------------------------
			
			if(searchKey1 == null) {
				searchKey1 = "";
			}// end of if(searchWord == null){}-------------------------
			
			if(searchOption2 == null) {
				searchOption2 = "";
			}// end of if(searchOption1 == null){}-------------------------
			
			if(searchKey2 == null) {
				searchKey2 = "";
			}// end of if(searchWord == null){}-------------------------
			
			if(selectedHead == null) {
				selectedHead = "";
			}// end of if(searchWord == null){}-------------------------
			
			if(sortFlag == null) {
				sortFlag = "";
			}// end of if(searchWord == null){}-------------------------
			
			// @@@ [처음][이전] 만들기 @@@ //
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='memberList.sg?currentPageNo=1&sizePerPage="+sizePerPage+"&searchOption1="+searchOption1+"&searchKey1="+searchKey1+"&searchOption2="+searchOption2+"&searchKey2="+searchKey2+"&selectedHead="+selectedHead+"&sortFlag="+sortFlag+"'>[처음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='memberList.sg?currentPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchOption1="+searchOption1+"&searchKey1="+searchKey1+"&searchOption2="+searchOption2+"&searchKey2="+searchKey2+"&selectedHead="+selectedHead+"&sortFlag="+sortFlag+"'>[이전]</a>&nbsp;";
			}// end of if(pageNo != 1){}----------------------
			
			while(!(loop > blockSize || pageNo > totalPage)) {
				if(pageNo == Integer.parseInt(currentPageNo)) {
					// 클릭한 페이지 번호가 화면에 보이는 페이지 번호인 경우
					pageBar += "&nbsp;<span style='border: solid 1px gray; color: red; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
				} else {
					// 화면에 보이는 페이지 번호 이외인 경우
					pageBar += "&nbsp;<a href='memberList.sg?currentPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchOption1="+searchOption1+"&searchKey1="+searchKey1+"&searchOption2="+searchOption2+"&searchKey2="+searchKey2+"&selectedHead="+selectedHead+"&sortFlag="+sortFlag+"'>"+pageNo+"</a>&nbsp;";
				}// end of if(pageNo == Integer.parseInt(currentShowPageNo)){}----------------------
				
				loop++;
				pageNo++;
			}// end of while(!(loop > blockSize || pageNo > totalPage)){}----------------------
			
			// @@@ [다음][마지막] 만들기 @@@ //
			// while 문을 빠져나오면 pageNo == 11
			if(!(pageNo > totalPage)) {
				pageBar += "&nbsp;<a href='memberList.sg?currentPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchOption1="+searchOption1+"&searchKey1="+searchKey1+"&searchOption2="+searchOption2+"&searchKey2="+searchKey2+"&selectedHead="+selectedHead+"&sortFlag="+sortFlag+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='memberList.sg?currentPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchOption1="+searchOption1+"&searchKey1="+searchKey1+"&searchOption2="+searchOption2+"&searchKey2="+searchKey2+"&selectedHead="+selectedHead+"&sortFlag="+sortFlag+"'>[마지막]</a>&nbsp;";
			}// end of if(!(pageNo > totalPage)){}----------------------
			
			request.setAttribute("pageBar", pageBar);
			
			String currentURL = MyUtil.getCurrentURL(request);
			currentURL = currentURL.replaceAll("&", " ");
			
			request.setAttribute("goBackURL", currentURL);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/manager/member/manageMember.jsp");
			
		} else {
			// 로그인하지 않았거나 일반 사용자로 로그인한 경우
			
			String message = "관리자만 접근할 수 있습니다.";
			String loc = request.getContextPath()+"/manager/signIn.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}// end of if(loginManager != null && "admin".equals(loginManager.getManagerid())){}
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception{}

}
