package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.filters.AddDefaultCharsetFilter;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.EachCouponVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductPurchaseDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//고객이 고른상품 and 보유쿠폰 보여주기
		
		String productid    = request.getParameter("productid");
		String productname  = request.getParameter("productname");
		String color        = request.getParameter("color");
		
		
		//////////////////////////////////////////////////////////
		
		String eachcouponcode = request.getParameter("eachcouponcode");
		String fk_couponcode = request.getParameter("fk_couponcode");
		
		//////////////////////////////////////////////////////
		// 로그인한 회원의 정보를 불러와 회원이 가지고 있는 쿠폰을 확인한다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int memberno = loginuser.getMemberno();
		
		//////////////////////////////////////////////////////
		
		
		
		
		InterProductDAO idao = new ProductDAO();
		
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("productid", productid);
	//	paraMap.put("productname", productname);
		paraMap.put("color", color);
		
		
		Map<String,String> paraMap2 = new HashMap<>();
		
		paraMap2.put("eachcouponcode", eachcouponcode);
		paraMap2.put("fk_couponcode", fk_couponcode);
		paraMap2.put("memberno", String.valueOf(memberno));
		
		
		List<ProductVO> purchaseList = idao.productPurchase(paraMap);
		List<EachCouponVO> couponList = idao.selectCoupon(paraMap2);
		
		// System.out.println(couponList.size());
		
		/*
		 * for(EachCouponVO ecvo : couponList) {
		 * System.out.println(ecvo.getCoupvo().getCouponname());
		 * System.out.println(ecvo.getCoupvo().getDiscount()); }
		 */
		
		
	//	ProductVO rProductVO = purchaseList.get(0);
		
		
		//제품상세
		request.setAttribute("purchaseList", purchaseList);
		request.setAttribute("couponList", couponList);
		//request.setAttribute("rProductVO", rProductVO);
		// request.setAttribute("color", color);
		
		//쿠폰
	//	request.setAttribute("eachcouponcode", eachcouponcode);
	//	request.setAttribute("fk_couponcode", fk_couponcode);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productbuy.jsp");
		
		
	}

}
