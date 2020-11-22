package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class FindLikeItemAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String flag = request.getParameter("flag");

		if ("search".equals(flag)) {
			// 취향 검사를 마치고 받은 키워드로 검색(ajax)
			
			String ans1 = request.getParameter("ans1");
			String ans2 = request.getParameter("ans2");
			String ans3 = request.getParameter("ans3");
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("ans1", ans1);
			paraMap.put("ans2", ans2);
			paraMap.put("ans3", ans3);
			
			// 사용자로부터 받은 키워드로 DB의 제품-특성에서 검색
			InterProductDAO pdao = new ProductDAO();
			String productid = pdao.selectLikeItem(paraMap);
			
			JSONObject jsobj = new JSONObject();
			
			if (productid == null) {
				jsobj.put("productid", "none");
			}else {
				jsobj.put("productid", productid);
			}
			
			String json = jsobj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		}else {
			// 처음 취향 추천 페이지에 들어왔을 때

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/main/findLikeItem.jsp");
		}
		

	}

}
