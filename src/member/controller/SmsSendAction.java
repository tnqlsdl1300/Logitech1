package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import net.nurigo.java_sdk.api.Message;

public class SmsSendAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 6자리 숫자난수 생성
		int code = (int)Math.floor(Math.random() * 1000000)+100000;
		if(code>1000000){
			code = code - 100000;
		}
		
		//String api_key = "발급받은 본인의 API Key";  // 발급받은 본인 API Key
		String api_key = "NCSEYQLU3C7JDBBW";  // 박수빈꺼임
	  
	    //String api_secret = "발급받은 본인의 API Secret";  // 발급받은 본인 API Secret
		String api_secret = "H0DXCH64PCYNOSZZYRIWZ3R4REHXF0D2";  // 박수빈꺼임
		
		Message coolsms = new Message(api_key, api_secret);
		// net.nurigo.java_sdk.api.Message 임. 
		// 먼저 다운 받은  javaSDK-2.2.jar 를 /MyMVC/WebContent/WEB-INF/lib/ 안에 넣어서  build 시켜야 함.
				
		// view단에서 ajax로 보낸 파라미터를 받음
		String mobile = request.getParameter("mobile");
		
		// == 4개 파라미터(to, from, type, text)는 필수사항이다. == 
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("to", mobile); // 수신번호
		paraMap.put("from", "01077226318"); // 발신번호
		paraMap.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
		paraMap.put("text", "인증코드는 [" + code + "] 입니다."); // 문자내용    
		paraMap.put("code", Integer.toString(code));
		paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version
				
		//	 ==  아래의 파라미터는 필요에 따라 사용하는 선택사항이다. == 
		//	paraMap.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
		//	paraMap.put("image", "desert.jpg"); // image for MMS. type must be set as "MMS"
		//	paraMap.put("image_encoding", "binary"); // image encoding binary(default), base64 
		//	paraMap.put("delay", "10"); // 0~20사이의 값으로 전송지연 시간을 줄 수 있습니다.
		//	paraMap.put("force_sms", "true"); // 푸시 및 알림톡 이용시에도 강제로 SMS로 발송되도록 할 수 있습니다.
		//	paraMap.put("refname", ""); // Reference name
		//	paraMap.put("country", "KR"); // Korea(KR) Japan(JP) America(USA) China(CN) Default is Korea
		//	paraMap.put("sender_key", "5554025sa8e61072frrrd5d4cc2rrrr65e15bb64"); // 알림톡 사용을 위해 필요합니다. 신청방법 : http://www.coolsms.co.kr/AboutAlimTalk
		//	paraMap.put("template_code", "C004"); // 알림톡 template code 입니다. 자세한 설명은 http://www.coolsms.co.kr/AboutAlimTalk을 참조해주세요. 
		//	paraMap.put("datetime", "20140106153000"); // Format must be(YYYYMMDDHHMISS) 2014 01 06 15 30 00 (2014 Jan 06th 3pm 30 00)
		//	paraMap.put("mid", "mymsgid01"); // set message id. Server creates automatically if empty
		//	paraMap.put("gid", "mymsg_group_id01"); // set group id. Server creates automatically if empty
		//	paraMap.put("subject", "Message Title"); // set msg title for LMS and MMS
		//	paraMap.put("charset", "euckr"); // For Korean language, set euckr or utf-8
		//	paraMap.put("app_version", "Purplebook 4.1") // 어플리케이션 버전
		
		// 문자쓸때만 JSONObject의 import를 simple로 해줘야 한다!!!!!!!!!!!!!
		
		JSONObject jsobj = (JSONObject)coolsms.send(paraMap);

		String json = jsobj.toString();
		
		
		System.out.println("확인용 json: " + json);
		// 확인용 json: {"group_id":"R2G9SvjnjOSoI32T","success_count":1,"error_count":0}
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");

	}

}
