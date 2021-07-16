<%@page import="java.util.ArrayList"%>
<%@page import="anitel.model.DetailDAO"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" content="no-cache">
<meta name="viewport" content="width=device-width, initial-scale=1" content="no-cache">
<title>JSP AJAX</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="dto" class="anitel.model.UsersDTO" />
	<jsp:setProperty property="*" name="dto"/>

<script type="text/javascript">
$(document).ready(function() {
	var pet_num = $("#pet").val();
	 
	$("#pet").change(function() {
		pet_num = $(this).val();
		$.ajax({
			url : "testPro.jsp",
			type : "POST",
			data : "pet_num=" + pet_num,
			dataType: "json",
			success : function(data){
				var list = "<table  border ='1' rules='none'>"+
									"<tr>"+
										"<td>"+data.pet_name+"</td>"+
									"</tr>"+
									"<tr>"+
										"<td>"+data.pet_type+"</td>"+
									"</tr>"+
									"<tr>"+
										"<td>"+data.pet_age+"</td>"+
									"</tr>"+
									"<tr>"+
										"<td style='text-align:center;'>제목 : "+data.pet_gender+"</td>"+
									"</tr>"+
									"<tr>"+
										"<td style='text-align:center;'><button onclick='goaway("+data+")'>자세히보기</button></td>"+
									"</tr>"+
								"</table>";
				$("#rs").empty();
				$("#rs").append(list);
				$("#rs").show();	
			},
			error : function(request,status,error){
				        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				      }
		   
		});
		
	});
		 
});

</script>
</head>
<body>
	<select name="pet" id="pet">  
		<option value ="29">방갑</option>
		<option value ="20">냥냥이</option>
		<option value ="31">푸우</option>
		<option value ="32">태호</option>
 	</select>
  <div>
  	<input id="btn" type="button" value="조아" />
  </div>
  <div id = "rs"></div>
</body>
</html>
