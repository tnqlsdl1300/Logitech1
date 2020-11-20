package mypage.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;

import common.controller.AbstractController;
import product.model.*;

public class OrderHeart extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = "9";
		
		ArrayList<ProductVO> likelist = new ArrayList<>();
		ArrayList<LikeProductVO> likeonelist = new ArrayList<>();
		ArrayList<String> templist = new ArrayList<>();
		ArrayList<ArrayList<String>> colorlist = new ArrayList<>();
		String str ="";
		String method = request.getMethod();
		InterProductDAO pdao = new ProductDAO(); 
		if(method.equalsIgnoreCase("GET")){
		
			
			likelist = pdao.selectProduct(userid);
			likeonelist = pdao.selectOptionProduct(userid);
			
			for(int i =0; i<likelist.size(); i++){
				templist = pdao.selectColorProduct(likelist.get(i).getProductid());
				colorlist.add(templist);
			}
			request.setAttribute("likelist", likelist);
			request.setAttribute("colorlist", colorlist);
			String seq = request.getParameter("seq");
			
			if(seq != null){
				//System.out.println(seqcart);
				String[] seqarr = seq.split(",");
				
				for(int i=0; i<seqarr.length; i++){
					pdao.deleteLikeCart(seqarr[i]);
				}
			}
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/mypage/mypage_heart.jsp");
			
		}
		
		else{
			pdao = new ProductDAO();
			
			String str_arrObj = request.getParameter("str_arrObj");	//view단에서 넘겨준 데이터를 저장해준다.
			// System.out.println("~~~~~~ 확인용  : " + str_arrObj);
			// ~~~~~~ 확인용 : [{"productid":"X50","price":"210000","color":"yellow"},{"productid":"Logitech Pebble M350","price":"32000","color":"blue"}]
			
			// 객체 문자열을 실제 객체 클래스로 변환해주기 위해서 반드시 있어야 하는 라이브러리이다.
			// 라이브러리를 lib에 추가해야 한다. gson-2.8.5.jar 파일 추가!
			Gson gson = new Gson();
			
			// {"name":"은지"} 이 객체 하나를 클래스 객체로 변환해주기 위한 코드이다.
			// PurchaseProductVO arrPcvo = gson.fromJson(str_arrObj, PurchaseProductVO.class);
			
			// [{"name":"은지"}, {"name":"민지"}] 이렇게 객체 배열을 넘겨주기 위한 코드이다.
			PurchaseProductVO[] arr_Pcvo = gson.fromJson(str_arrObj, PurchaseProductVO[].class); 
			
			ArrayList<PurchaseProductVO> pcvoList = new ArrayList<>();
			
			for(PurchaseProductVO pcvo : arr_Pcvo) {
				pcvoList.add(pcvo);
			}
			
			// 확인용!----------------------------------------------------------------
			
			boolean isFail = false;
			
			int nsize = pcvoList.size();  // 예: nsize ==> 3
			int n = 0;
			ArrayList<String> id = new ArrayList<>();
			ArrayList<String> color = new ArrayList<>();
			ArrayList<String> img = new ArrayList<>();
			String strs = "";
			for(int i=0; i<pcvoList.size(); i++){
				int nresult = pdao.insertCart(pcvoList.get(i));
			    n += nresult;
			    if(nresult==0){
			    	id.add(pcvoList.get(i).getFk_productid());
			    	color.add(pcvoList.get(i).getSelectcolor());
			    	img.add(pdao.selectImgFile(pcvoList.get(i).getFk_productid()));			    	
			    }
			}// end of for-----------------------------
			//System.out.println(id.get(0));
			
			//String message = "";
			boolean bl = true;		
			if(nsize == n) {
				//	out.println("<script>alert('장바구니에 모두 등록되었습니다.');</script>");
				//message = "장바구니에 모두 등록되었습니다.";
				bl = true;
			}
			else {
				//out.println("<script>alert('장바구니에 등록하신 제품이 이미 존재하는 것은 장바구니 등록이 실패 되었습니다.');</script>");
				//message = "일부 제품이 장바구니에  등록되지 않았습니다.";
				bl = false;
			}
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("bl", bl);
			jsonObj.put("id", id);
			jsonObj.put("color", color);
			jsonObj.put("img", img);

			String json = jsonObj.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			// ----------------------------------------------------------------------
			// 장바구니에 insert 해주기!
		}
		
	}

}
