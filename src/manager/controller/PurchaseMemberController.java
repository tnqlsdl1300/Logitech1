package manager.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import myshop.model.PurchaseDetailVO;
import myshop.model.PurchaseVO;

public class PurchaseMemberController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다. @@
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
			// 관리자(admin)로 로그인한 경우
			String fk_purchaseno = request.getParameter("fk_purchaseno");
			
			String detailtotalpay = request.getParameter("detailtotalpay");
			String discount = request.getParameter("discount");
			
			InterManagerDAO mdao = new ManagerDAO();
			// 주문자 정보 가져오기
			PurchaseVO purcvo = mdao.purchaseByMember(fk_purchaseno);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("purchaseno", purcvo.getPurchaseno());
			jsonObj.put("name", purcvo.getMvo().getName());
			jsonObj.put("receiver", purcvo.getReceiver());
			jsonObj.put("postcode", purcvo.getPostcode());
			jsonObj.put("address", purcvo.getAddress());
			jsonObj.put("detailaddress", purcvo.getDetailaddress());
			jsonObj.put("extraaddress", purcvo.getExtraaddress());
			jsonObj.put("payment", purcvo.getPayment());
			jsonObj.put("totalprice", purcvo.getTotalprice());
			jsonObj.put("purchaseday", purcvo.getPurchaseday());
			jsonObj.put("detailtotalpay", detailtotalpay);
			jsonObj.put("discount", discount);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		} else {
			// 로그인하지 않았거나 일반 사용자로 로그인한 경우
			String message = "관리자만 접근할 수 있습니다.";
			String loc = request.getContextPath()+"/manager/signIn.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if(loginManager != null && "admin".equals(loginManager.getUserid())){}------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {}

}
