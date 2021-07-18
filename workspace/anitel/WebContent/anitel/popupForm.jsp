<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<style>
     #button button{ 
      	font-weight:semi-bold;
      	border: none;
      	border-radius: 6px;
      	width: 110px;
      	height:40px;
      	font-size: 16px;
      	margin-top:30px;
      	position:relative;
      }
       #button button:hover{
      	background-color:#FF822B;
      	color:#ffffff;
      }
		input[type=text] { 
			border:1px solid black;
			border-radius:5px;
			height:30px;
			text-indent: 1em;
			
		 }
		 input[type=password] { 
			border:1px solid black;
			border-radius:5px;
			height:30px;
			width:300px;
			text-indent: 1em;
			
		 }
		input[type=button] { 
	      	border: none;
	      	border-radius: 6px;
	      	width: 110px;
	      	height:40px;	
		}

		input[type=submit] { 
	      	border: none;
	      	border-radius: 6px;
	      	width: 110px;
	      	height:40px;	
		}
		 input[type=submit]:hover{
      	background-color:#111111;
      	color:#ffffff;
      }
		
		   #withdraw{ 
      	border: none;
      	border-radius: 3px;
		width: 65px;
		height:25px;
		font-size: 12px;
      	margin-top:15px;
      	margin-left:600px;
      	position:relative;
      }
	// petSelect.jsp 				  -> petinfoModiform (pooh 10)
	//			-> popForm -> popPro 
	//   pooh(10)-> pooh(10)-> pooh(10) 
	// myReserve.jsp
      	
    </style>
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

	</head>
<%
	request.setCharacterEncoding("UTF-8");
	String pop = request.getParameter("pop");
	
	String pet_num = null; 
	if(request.getParameter("pet_num") != null){
		pet_num = request.getParameter("pet_num");
	}
	
	String booking_num= null;
	if(request.getParameter("booking_num") != null){
		booking_num = request.getParameter("booking_num");
	}
%>

<body>
	<br/><br/><br/><br/>
		<form action="popupPro.jsp?pop=<%= pop %>" method="post">
		<%if(pet_num != null){ %>
		<input type="hidden" name="pet_num" value="<%=pet_num%>" />
		<%} %>
	
		<%if(booking_num != null){ %>
			<input type="hidden" name="booking_num" value="<%=booking_num%>"/>
		<%} %>
 	
	<table>
		<tr>
			<td>본인확인을 위하여 비밀번호를 입력해주세요. </td>
		</tr>
		<tr>
			<td><input type="password" name="user_pw"/><br/> </td>
		</tr>
		<tr>
			<td align="center"><br/>
			<input type="submit" value="확인" />&emsp;	 
			<input type="button" value="취소" onclick='window.close()'/> </td>
		</tr>
	</table> 
	</form>
</body>
</html>
