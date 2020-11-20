<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	</div>
</div>

</body>

<script type="text/javascript">
    function func_height() {
      var content_height = $("div#content").height(); 
      // header.jsp 의 하단에 표시된 div content 의 height 값
      
      $("div#sideMenu").height(content_height);
      // header.jsp 의 div sideinfo 의 height 값으로 설정하기 
    }
</script>

</html>