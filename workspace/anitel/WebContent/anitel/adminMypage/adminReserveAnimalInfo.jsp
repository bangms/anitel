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
			width: 100%;
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
	PetDTO pet = new PetDTO();	
	pet = dao.getPetInfo(petNum);
%>
<body>
	<br/>
		<form method="get"> 
				<table align="center">
					<tr>
						<th><h4>이름</h4></th>
						<td><%=pet.getPet_name()%></td>
					</tr>
					<tr>
						<th><h4>종</h4></th>
						<td>
							<%if(pet.getPet_type() == 1){ %>강아지
							<%}else if(pet.getPet_type() == 2){ %>고양이
							<%}else if(pet.getPet_type() == 0){ %> 강아지, 고양이 외 기타동물
							<%}%>
						</td>
					</tr>
					 <tr> 
					 	<th><h4>성별</h4></th>
               			<td>
                   			<%if(pet.getPet_gender() == 0){ %>암컷
							<%}else if(pet.getPet_gender() == 1){ %>수컷<%}%>
              			</td>
           			</tr> 
					<tr>	
						<th><h4>중성화 여부</h4></th>
						<td>
							<%if(pet.getPet_operation() == 0){ %>중성화 O
							<%}else if(pet.getPet_operation() == 1){ %>중성화 X<%}%>					
						</td>
					</tr>
					<tr>
						<th><h4>나이</h4></th>
						<td><%=pet.getPet_age()%> 살</td>
					</tr>
					<tr>	
						<th><h4>대형동물여부</h4></th>
						<td>
							<%if(pet.getPet_big() == 0){ %>소형
							<%}else if(pet.getPet_big() == 1){ %>대형<%}%>		
						</td>
					</tr>
				</table>
		</form>
</body>
</html>