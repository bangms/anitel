<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
   function closePopup() {
      self.close(); // 팝업창 닫기
   }
</script>
<%
    String strReferer = request.getHeader("referer");
    
    if(strReferer == null){
   %>
    <script language="javascript">
     alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
     document.location.href="main.jsp";
    </script>
   <%
     return;
    }
   %>
<body>
	<%
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	int categ = Integer.parseInt(request.getParameter("categ"));
	
	//reg_num 이 넘어올때 
	String reg_num = request.getParameter("reg_num");
	System.out.println("pwcheck reg_num=" +reg_num);
	
 
	
	
	if (session.getAttribute("sid") == null) {
	%>
		<script type="text/javascript">
	      alert("로그인이 필요한 페이지입니다!");
	      window.close();
	      move(board_num);
	   </script>
	<%
	} else {
	%>
	<h3>비밀글입니다. 비밀번호를 입력하세요</h3>
	<form action="popCheckPwPro.jsp?pageNum=<%=pageNum%>" method="post">
		<input type="hidden" name="board_num" value="<%=board_num%>" />
		<input type="hidden" name="categ" value="<%=categ%>" />
		<input type="hidden" name="reg_num" value="<%=reg_num%>" />
		 
		
		<table align="center" style="margin:  0 auto;">
			<tr>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="확인" /> 
					<input type="button" value="닫기" onclick="closePopup()"/>
				</td>
			</tr>
		</table>
	</form>

</body>
<%
}
%>
</html>
