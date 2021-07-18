<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>logout page</title>
</head>
<body>
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
<%
if(session.getAttribute("sid") == null) { %>
<script type="text/javascript">
	alert("로그인 해주세요!");
	window.location="loginForm.jsp";
</script>
<%	} else {
	// 로그아웃 처리
	session.invalidate(); // 세션 속성 전체 삭제
	
	// 쿠키가 있으면 쿠키도 삭제
	Cookie[] coos = request.getCookies();
	if(coos != null) {
		for(Cookie c : coos) {
			if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")){
				c.setMaxAge(0);
				response.addCookie(c);				
			}
		}		
	}
	
	response.sendRedirect("main.jsp"); // 메인페이지로 이동
%>
</body>
<%} %>
</html>