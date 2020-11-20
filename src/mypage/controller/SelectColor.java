package mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class SelectColor extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterProductDAO pdao = new ProductDAO();
		String hiddencolor = request.getParameter("hiddencolor");
		String hiddenseq = request.getParameter("hiddenseq");
		
		pdao.updateOption(hiddencolor, hiddenseq);
		String color = pdao.selectChangeColor(hiddenseq);
		
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("color", color);
		String json = jsonobj.toString();
		
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
