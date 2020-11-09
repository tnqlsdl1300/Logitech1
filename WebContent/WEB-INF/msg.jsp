<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	// 회원가입 성공/실패 유무를 받아서 alert로 보여준 뒤 페이지를 이동시키는 자바스크립트 코드를 실행시키기 위해 만들어진 jsp 파일이다(거치기 용)

	alert("${ message }");
	
	location.href = "${ loc }"	// 페이지 이동
	
	// 팝업창 닫기
	self.close();
	
/*	
	location.href="javascript:history.go(-2);";  // 이전이전 페이지로 이동 
 	location.href="javascript:history.go(-1);";  // 이전 페이지로 이동
 	location.href="javascript:history.go(0);";   // 현재 페이지로 이동(==새로고침) 캐시에서 읽어옴.
 	location.href="javascript:history.go(1);";   // 다음 페이지로 이동.
 	
 	location.href="javascript:history.back();";       // 이전 페이지로 이동 
 	location.href="javascript:location.reload(true)"; // 현재 페이지로 이동(==새로고침) 서버에 가서 다시 읽어옴. 
 	location.href="javascript:history.forward();";    // 다음 페이지로 이동.
*/
</script>