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
	

      	
    </style>

	</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	System.out.println("popupForm.jsp");

	String pop = request.getParameter("pop");
	System.out.println(pop);
	String id = request.getParameter("id");
	System.out.println(id);
%>
<script>
	function pop3(){ // pop : 3
		opener.document.location="/anitel/userMypage/userModifyForm.jsp";
		self.close();
	}
	function pop7(){ // pop : 7
		opener.document.location="/anitel/memberMypage/memberModifyForm.jsp?id";
		self.close();
	}
	
	function move() {
		console.log(opener.document.location);
		String url = "/anitel/popupPro.jsp";
		opener.document.location=url;
	} 
</script>
<body>
	<br/><br/><br/><br/>
	<form action="popupPro.jsp?pop=<%= pop %>" method="post">
	<table>
		<tr>
			<td>본인확인을 위하여 비밀번호를 입력해주세요. </td>
		</tr>
		<tr>
			<td><input type="password" name="user_pw"/><br/> </td>
		</tr>
		<tr>
			<td align="center"><br/>
				<input type="submit" value="확인" onclick="move()"/>&emsp;
				<!-- onclick="<% if(pop.equals("1")){}else if(pop.equals("2")){%><%}else if(pop.equals("3")){%>pop3()<%} else if(pop.equals("4")){} else if(pop.equals("5")){} else if(pop.equals("6")){} else if(pop.equals("7")){%> pop7() <%} %>" -->	 
				<input type="button" value="취소" onclick='window.close()'/>
			</td>
		</tr>
	</table> 
	</form>
</body>
</html>
</html>