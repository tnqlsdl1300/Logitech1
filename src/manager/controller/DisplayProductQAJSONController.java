package manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import myshop.model.OneQueryVO;
import myshop.model.ProductQAVO;

public class DisplayProductQAJSONController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String today = request.getParameter("today");
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("today", today);
		paraMap.put("start", start);
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);
		
		InterManagerDAO mdao = new ManagerDAO();
		List<ProductQAVO> pqaList = mdao.selectPQAByWriteday(paraMap);
		
		// 복수 행(객체)을 배열의 형태로 보내야 한다.
		JSONArray jsonArr = new JSONArray();
		
		if(pqaList.size() > 0) {
			
			for(ProductQAVO pqavo : pqaList) {
				JSONObject jsonObj = new JSONObject();  // 하나하나의 행을 JSON 타입으로 만든다.
				jsonObj.put("seq_qa", pqavo.getSeq_qa());
				jsonObj.put("userid", pqavo.getMvo().getUserid());
				jsonObj.put("fk_productid", pqavo.getFk_productid());
				jsonObj.put("content", pqavo.getContent());
				
				String strStatus = "";
				
				if(pqavo.getStatus() == 0) {
					strStatus = "대기";
				} else {
					strStatus = "완료";
				}// end of if(oqvo.getAnswerstatus() == 0) {}----------------------------
				
				// System.out.println(strAnswerstatus);
				
				jsonObj.put("status", strStatus);
				
				jsonArr.put(jsonObj);  // JSON 타입의 객체를 JSON 배열에 담는다.
			}// end of for(ProductQAVO pqavo : pqaList){}-------------------------------
			
		}// end of if(pqaList.size() > 0){}----------------------------------
		
		String json = jsonArr.toString();  // 문자열로 변환한다.
		
		// System.out.println("~~~ 확인용 json ==> " + json);
		// ~~~ 확인용 json ==> [{"category":"고객등급","title":"일대일문의","userid":"hjun34"}]
		// 만약 select 결과가 없다면 ==> [] 로 나오므로 null 이 아닌 요소가 없는 빈 배열이다.
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
