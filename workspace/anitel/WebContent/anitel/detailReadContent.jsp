<%-- 컨텐츠 보기 --%>
<%@page import="anitel.model.BoardDAO"%>
<%@page import="anitel.model.BoardDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	BoardDAO b_dao = BoardDAO.getInstance(); 

	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println(board_num);
	
	BoardDTO content = b_dao.getArticle(board_num); 
	JSONObject obj = new JSONObject();
	
	obj.put("board_num", content.getBoard_num());
	obj.put("id", content.getId());
	obj.put("reg_num", content.getReg_num());
	obj.put("categ", content.getCateg());
	obj.put("subject", content.getSubject());
	obj.put("pw", content.getPw());
	obj.put("ctt", content.getCtt());
	obj.put("img", content.getImg());
	obj.put("reg_date", content.getReg_date());
	obj.put("reg_date", content.getReply_date());
	obj.put("reg_date", content.getReply_content());
	obj.put("reg_date", content.getReadcount());
	obj.put("reg_date", content.getComm());
	obj.put("reg_date", content.getHidden_content());
	
	System.out.println(obj.toJSONString());
	String result = obj.toJSONString();
	System.out.println(result);	
	response.setContentType("application/json; charset=UTF-8");
%>

<%= result %>
