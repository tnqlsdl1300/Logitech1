package product.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ProductViewPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productid = request.getParameter("productid");
		
		
		InterProductDAO idao = new ProductDAO();
		
		List<ProductVO> detailProductList = idao.selectOne(productid);
		
		ProductVO rProductVO = detailProductList.get(0); 
		
		
		request.setAttribute("detailProductList", detailProductList);
		request.setAttribute("rProductVO", rProductVO);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productsingle.jsp");
	}

}
