package product.controller;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductSpeakerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		
		
		InterProductDAO idao = new ProductDAO();
		
		List<ProductVO> productList = idao.selectAll("speaker");
		
		//System.out.println(productList.size()); 4
		
		request.setAttribute("productList", productList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/speaker.jsp");
		
	}

}
