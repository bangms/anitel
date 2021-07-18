<%@page import="anitel.model.BookingDAO"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
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
	BookingDAO dao = BookingDAO.getInstance();
	String id =(String)session.getAttribute("sid");
	System.out.println(id);
	int pet_num = Integer.parseInt(request.getParameter("pet_num"));
	System.out.println(pet_num);
	
	PetDTO pet = dao.getReservePetSel(id, pet_num);
	JSONObject obj = new JSONObject();
		
	obj.put("pet_num", pet.getPet_num());
	obj.put("id", pet.getId());
	obj.put("pet_name", pet.getPet_name());
	obj.put("pet_type", pet.getPet_type());
	obj.put("pet_etctype", pet.getPet_etctype());
	obj.put("pet_gender", pet.getPet_gender());
	obj.put("pet_operation", pet.getPet_operation());
	obj.put("pet_age", pet.getPet_age());
	obj.put("pet_big", pet.getPet_big());
	 
	String result = obj.toJSONString();
	
	response.setContentType("application/json; charset=UTF-8");
%>			
<%= result %>
	