<%@page import="anitel.model.BookingDAO"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="anitel.model.DetailDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	DetailDAO dao = DetailDAO.getInstance();
	String id = "java04";
	int pet_num = Integer.parseInt(request.getParameter("pet_num"));
	System.out.println(pet_num);
	//String id = request.getParameter("id");
	
	PetDTO pet = dao.getReservePetInfo(id, pet_num); 
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
	