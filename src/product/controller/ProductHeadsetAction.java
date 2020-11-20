package product.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductHeadsetAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO idao = new ProductDAO();
		
		List<ProductVO> productList = new ArrayList<>();
		
		productList = idao.selectAll("headset");
		
		request.setAttribute("productList", productList);
		
		
		
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/speaker.jsp");
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/headset.jsp");
		
	}

}
