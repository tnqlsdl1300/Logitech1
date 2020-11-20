package mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;
import product.model.PurchaseProductVO;

public class OrderCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_productid = request.getParameter("fk_productid");
		String color = request.getParameter("color");
		int price = Integer.parseInt(request.getParameter("price"));
		String cartpronum = request.getParameter("cartpronum");
		
		System.out.println(cartpronum);
	//	System.out.println(fk_productid+" "+color + " " + price);
		
		//int fk_memberno = Integer.parseInt(request.getParameter("fk_memberno"));
		//int sq_cart = Integer.parseInt(request.getParameter("sq_cart"));
		
		
		InterProductDAO idao = new ProductDAO();
		
		PurchaseProductVO ppvo = new PurchaseProductVO(); 
		
		ppvo.setFk_productid(fk_productid);
		ppvo.setPrice(price);
		ppvo.setSelectcolor(color);
		ppvo.setCartpronum(cartpronum);
		
		
		//ppvo.setFk_memberno(fk_memberno);
		//ppvo.setSq_cart(sq_cart);
		
				
		int result = idao.intoCart(ppvo);
		//System.out.println(result);
		
		request.setAttribute("result", result);
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_cart.jsp");
	}

}
