package mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.controller.AbstractController;
import product.model.*;

public class OrderCart extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        InterProductDAO pdao = new ProductDAO();
        
        ArrayList<ProductVO> cartprolist = pdao.selectCartProduct();
        ArrayList<ArrayList<String>> colorlist = new ArrayList<>();
        ArrayList<String> idlist = new ArrayList<>();
        request.setAttribute("cartprolist", cartprolist);
       
		
		for(int i=0; i<cartprolist.size(); i++){
			ArrayList<String> arrlist = pdao.selectcolor(cartprolist.get(i).getPcvo().getFk_productid());
			colorlist.add(arrlist);
			//idlist.add(e)
		}
		request.setAttribute("colorlist", colorlist);
		
		//ArrayList<String> seqcartlist = new ArrayList<>();
		
		String seqcart = request.getParameter("seqcart");
		if(seqcart != null){
			System.out.println(seqcart);
			String[] seqcartarr = seqcart.split(",");
			
			for(int i=0; i<seqcartarr.length; i++){
				pdao.deleteCart(seqcartarr[i]);
			}
		}
		
		//System.out.println(seqcart);
		
		
		
		
		//pdao.deleteCart(seqcart);
		//System.out.println(hiddennum);
		
		//System.out.println(hiddencolor);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_cart.jsp");
		
	}

}
