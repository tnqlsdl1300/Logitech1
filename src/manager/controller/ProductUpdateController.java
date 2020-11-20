package manager.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import myshop.model.ProductOptionVO;
import myshop.model.ProductVO;

public class ProductUpdateController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
			
			if(loginManager != null && "admin".equals(loginManager.getManagerid())) {
				String productid = request.getParameter("productid");
				String price = request.getParameter("price");
				
				InterManagerDAO mdao = new ManagerDAO();
				int n = 0;
				
				if(price != "") {
					Map<String, String> paraMap = new HashMap<String, String>();
					paraMap.put("productid", productid);
					paraMap.put("price", price);
					
					n = mdao.priceUpdate(paraMap);
				}// end of if(price != "") {}------------------------------
				
				String productserialid = request.getParameter("productserialid");
				String color = request.getParameter("color");
				String stock = request.getParameter("stock");
				
				ProductOptionVO povo = new ProductOptionVO();
				povo.setProductserialid(productserialid);
				povo.setColor(color);
				povo.setStock(Integer.parseInt(stock));				
				
				n += mdao.productOptionUpdate(povo);
			} else {
				// 로그인하지 않았거나 일반 사용자로 로그인한 경우
				String message = "관리자만 접근할 수 있습니다.";
				String loc = request.getContextPath()+"/manager/signIn.sg";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}// end of if(loginManager != null && "admin".equals(loginManager.getUserid())){}------------------
			
		} else {
			// ***** GET 방식으로 넘어온 경우 ***** //
			String message = "비정상적으로 접근할 수 없습니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if("POST".equalsIgnoreCase(method)){}------------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {}

}
