package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductSelectColorAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String color = request.getParameter("color");
		
		String productid = request.getParameter("productid");
		
		InterProductDAO idao = new ProductDAO();
		
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("productid", productid);
		paraMap.put("color", color);
		//paraMap.put("productserialid", productserialid);
		
		
		List<ProductVO> colorList = idao.selectOneColor(paraMap);
	
		
		request.setAttribute("colorList", colorList);
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productbuy.jsp");
	}

}
