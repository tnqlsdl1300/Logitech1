package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import myshop.model.OneQueryVO;
import myshop.model.ProductQAVO;

public class OneQueryAnswerEmailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		String path = "";
		
		if("POST".equalsIgnoreCase(method)) {
			String seq_oq = request.getParameter("seq_oq");
			String seq_qa = request.getParameter("seq_qa");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String emailContent = request.getParameter("emailContent");
			
			boolean sendMailSuccess = true;  // 메일이 정상적으로 전송되었는지 확인하기 위한 용도이다.
			
			GoogleMail mail = new GoogleMail();
			
			try {
				mail.sendmail(name, email, emailContent);
			} catch (Exception e) {
				// 메일 전송 실패한 경우
				e.printStackTrace();
				sendMailSuccess = false;
			}
			
			InterManagerDAO mdao = new ManagerDAO();
			
			if(seq_oq != null) {
				OneQueryVO oqvo = mdao.oneQueryDetail(seq_oq);
				
				request.setAttribute("oqvo", oqvo);
				path = "/WEB-INF/manager/support/oneQueryDetail.jsp";
			}
			
			if(seq_qa != null) {
				ProductQAVO pqavo = mdao.productQADetail(seq_qa);
				
				request.setAttribute("pqavo", pqavo);
				path = "/WEB-INF/manager/support/productQADetail.jsp";
			}
			
			String answerType = request.getParameter("answerType");
			
			request.setAttribute("name", name);
			request.setAttribute("email", email);
			request.setAttribute("sendMailSuccess", sendMailSuccess);
			request.setAttribute("answerType", answerType);
		}// end of if("POST".equalsIgnoreCase(method)){}------------------------
		
		request.setAttribute("method", method);
		
		super.setRedirect(false);
		super.setViewPage(path);
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception

}
