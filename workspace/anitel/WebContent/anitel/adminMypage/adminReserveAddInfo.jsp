<%@page import="anitel.model.BookingDTO"%>
<%@page import="anitel.model.AdminDAO"%>
<%@page import="anitel.model.PetDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title> 
	<style>
	    table {
			width: 70%;
			border: 2px solid #444444;
			border-collapse: collapse;
		}        	
		th {
			border: 1px solid #444444;
		    background-color: #EBDDCA;
		}
		td {
		    border: 1px solid #444444;
		    padding-left:10px;
		}	
	</style>
</head>
<%
	String petNum = request.getParameter("petnum");
	
	AdminDAO dao = AdminDAO.getInstance();
	BookingDTO add = new BookingDTO();
	add = dao.getAddInfo(petNum);
%>
<body>
	<br/>
		<form method="get"> 
				<table align="center">
					<tr>
						<th><h4>세부/추가 요청사항</h4></th>
						<td><%=add.getRequests() %></td>
					</tr>
					<tr>
						<th><h4>목욕 유료서비스 이용여부</h4></th>
						<td>
							<%if(add.getPaid_bath() == 0){ %>이용 X
							<%}else if(add.getPaid_bath() == 1){ %>이용O
							<%}%>
						</td>
					</tr>
					 <tr> 
					 	<th><h4>미용 유료서비스 이용여부</h4></th>
               			<td>
                   			<%if(add.getPaid_beauty() == 0){ %>이용 X
							<%}else if(add.getPaid_beauty() == 1){ %>이용O
							<%}%>
              			</td>
           			</tr> 
					<tr>	
						<th><h4>병원 유료서비스 이용여부</h4></th>
						<td>
							<%if(add.getPaid_medi() == 0){ %>이용 X
							<%}else if(add.getPaid_medi() == 1){ %>이용O
							<%}%>					
						</td>
					</tr>
				</table>
		</form>
</body>
</html>