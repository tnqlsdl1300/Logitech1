package product.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.InterProductOptionDAO;
import product.model.ProductDAO;
import product.model.ProductOptionVO;
import product.model.ProductVO;

public class ProductViewPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productid = request.getParameter("productid");
		//String color = request.getParameter("color");
		//System.out.println(color);
		
		InterProductDAO idao = new ProductDAO();
		
		List<ProductVO> detailProductList = idao.selectOne(productid);
		
		ProductVO rProductVO = detailProductList.get(0); 
		// new ProductVO(); idao.selectOne()
		
		//pvo
		
		request.setAttribute("detailProductList", detailProductList);
		request.setAttribute("rProductVO", rProductVO);
		
		
		//<ProductVO> colorProductList = idao.selectColor(color);
		
		//request.setAttribute("colorProductList", colorProductList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productsingle.jsp");
	}

}
