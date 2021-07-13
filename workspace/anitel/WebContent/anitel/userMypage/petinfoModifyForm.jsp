
<%@page import="java.util.List"%>
<%@page import="anitel.model.PetDAO"%>
<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.PetDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려동물 수정폼</title>
  <style>
      #container {
        width: 100%;
        margin: 0px auto;
        padding: 20px;
      }
      #header {
       height:100px;
      
     	width:100%;
        padding: 20px;
        margin-bottom: 20px;
        height: 100px;
      	top:0;
      	display: flex;
 	justify-content: space-between;
 	background-color:white;
 	position: sticky;
	top: 0;
      }
      #header logo{
      	width: 300px;
      	height:100px;
      }
      #header section{
     	width:1100px;
     	height:100px;
     	margin-right:300px;
      }
      #main{
      	position:relative;
      	width:100%;
      	overflow: auto;
      	height:500px;
   	
      }
      #content {
        width: 65%;
       	height:100%;
        padding: 20px;
        margin-bottom: 20px;
        margin-left:300px;
        margin-right:200px;
        padding-left:100px;
        padding-right:100px;
        float: left;
	padding-bottom:100px;
	z-index:3
      }
      #sidebar {
        width: 230px;
        padding: 20px;
        float: left;
        clear:both;
        background-color:#EBDDCA;
        margin-right:50px;
        margin-left:70px;
        position:fixed;
      }
      #footer {
      	height:80px;
      	width:100%;
        clear: both;
        padding: 20px;
        margin-left:-50px;
	padding-left:100px;
        left:0;
        bottom:0;
	background-color:black;
	color:white;
	overflow-y:hidden;
	overflow-x:hidden;
      }
      p{
      	margin-top:10px;
      	font-size: 13px;
      	margin-left : 200px;
      	
      }
      img {
      	float:left; 
      	padding: 20px;
      	margin-top:-15px;
      	margin-left:40px;
      }
      ul{
      	font-size:20px
      }
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
    
      #login{
     	background-color:#FFA742;
      	color:white;
   	float : right;   
   	margin-right: 5px;    	
   		
      }
      #signin{
     	background-color:#FFA742;
      	color:white;
     	float : right;
     	margin-right: 5px;    	
     	
      }
      #notice{
      	float : right;
      	margin-right: 5px;    	
      	background-color:#ffffff;
      	color:black;
      	
      }
     A{
      text-decoration:none;
      color: black;
      }
    li{
      list-style:none;
      margin-bottom:10px;		
      }
    #select{
      background-color:#FFA742;
      color:white;
      border: none;
      border-radius: 6px;
      width: 70px;
      height:40px;	
    }
    #select:hover{
      background-color:#FF822B;
      color:#ffffff;
    }
    input[type=text] { 
      border:1px solid black;
      border-radius:5px;
      height:30px;
      text-indent: 1em;		
    }
    input[type=button] { 
      background-color:#FFA742;
      color:white;
      border: none;
      border-radius: 6px;
      width: 180px;
      height:40px;	
    }
    input[type=button]:hover{
      background-color:#FF822B;
      color:#ffffff;
    }
    select, option{
      width:150px; 
      height:35px;
      border:1px solid black;
      border-radius:5px;
    }  
	
      	
    </style>
</head>
  
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")!=null){// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/anitel/loginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기

	//String id = (String)session.getAttribute("sid");
	String id = (String)request.getParameter("id");
	int pet_num = Integer.parseInt(request.getParameter("pet_num"));
	PetDAO dao = PetDAO.getInstance();
	PetDTO pet = dao.getPet(id, pet_num); 
		

	
%>

<script type="text/javascript">
function popupOpen(){
	var popUrl = "/anitel/anitel/popupForm.jsp?pop=8";	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
}
//function setValues(){
//	var name=document.getElementById("pet_name");
//	var age=document.getElementById("pet_age");
//	var gender=document.getElementById("pet_gender");
//	var type=document.getElementById("pet_type");
	

//	age.value=name.option[name.selectedIndex].text;
//	gender.value=name.option[name.selectedIndex].radio;

//}



</script>
<body>

    <div id="container">
    
 <!-- 여기서부터 헤더  입니다.  -->
 	
      <div id="header">
      	<div id="logo">
       		 <img src="/anitel/anitel/imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       		 <div id="button">
        		<button id="notice" onclick="window.location='/anitel/anitel/list.jsp'">공지사항</button>
        		<button id="signin" onclick="window.location='/anitel/anitel/signinUserForm.jsp'">회원가입</button>
   	     		<button id="login" onclick="window.location='/anitel/anitel/loginForm.jsp'">로그인</button>
       		 </div>
        </section>
      </div>
      
	<div id="main">
	
	<!-- 여기서부터 사이드바 입니다.  -->
      <div id="sidebar">
        <h1>마이페이지</h1>
	        <ul>
	      	 	<li><a href="/anitel/anitel/userMyPage/userMyReserve.jsp">나의 예약현황</a></li>
	          	<li><a href="/anitel/anitel/userMyPage/userMyPage.jsp">나의 정보</a></li>
	          	<li><a href="/anitel/anitel/userMyPage/userQnA.jsp">나의 Q&A</a></li>
	          	<li><a href="/anitel/anitel/userMyPage/userReview.jsp">나의 후기</a></li>
	        </ul>
      </div>
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      
     <div id="content">
     	<h1> <%=pet.getPet_name()%>의 정보</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
     <form action= "/anitel/anitel/userMyPage/petinfoModifyPro.jsp" method="post"> 
     	<input type="hidden" name="pet_num" value="<%=pet_num%>" />
				<table>
					<tr>
						<td width=150><h3>이름</h3></td>
						<td>
							<input type="text" name="pet_name" style="width:150px;" value="<%= pet.getPet_name()%>"/>
						</td> 					
					</tr>
					<tr>
						<td width=150><h3>종</h3></td> 
						<td>
							<select id="pet_type" name="pet_type">
								<option value="" disabled selected >선택	</option>								
								<option value="1" <%=1==(pet.getPet_type())? "selected":"" %>>강아지</option>								
								<option value="2" <%=2==(pet.getPet_type())? "selected":"" %>>고양이</option>
								<option value="0" <%=0==(pet.getPet_type())? "selected":"" %>>기타동물</option>
							</select>
							<input type="text" id="pet_etctype" name="pet_etctype" value="<%= pet.getPet_etctype() == null ? "" : pet.getPet_etctype() %>" style="height:30px;" placeholder="기타동물 입력란"/>
						</td>
					</tr>
					 <tr> 
					 	<td><h3>반려동물 성별</h3></td>
               			<td> 
                   			<input type="radio" name="pet_gender" value="1" <%=1==(pet.getPet_gender())? "checked":"" %>> 수컷                    			
                   			<input type="radio" name="pet_gender" value="0" <%=0==(pet.getPet_gender())? "checked":"" %>> 암컷     
              			</td>
           			</tr> 
					<tr>	
						<td width=150><h3>중성화 여부</h3></td>
						<td>
							<input type="radio" name="pet_operation" value="1" <%=1==(pet.getPet_operation())? "checked":"" %>>예 
							<input type="radio" name="pet_operation" value="0" <%=0==(pet.getPet_operation())? "checked":"" %>>아니오							
						</td>
					</tr>
					<tr>
						<td width=150><h3>나이</h3></td>
						<td>
							<input type="text" name="pet_age" style="width:300px;" value="<%= pet.getPet_age() == null ? "" : pet.getPet_age() %>"/>
						</td> 
					</tr>
					<tr>
						<td width=150><h3>대형동물	</h3></td>
						<td>
							<input type="checkbox" name="pet_big" value="1"<%=1==(pet.getPet_big())? "checked":"" %>> 20kg 이상일 경우 체크해주세요.
						</td>
					</tr>
				</table>
	
	  		    <br/>
	      		<input type="submit" value="수정하기" />&emsp;
				<input type="button" value="삭제하기" onclick="popupOpen()"/>&emsp;
				<input type="button" value="뒤로가기" onclick="window.location='/anitel/anitel/userMyPage/petSelect.jsp'"/>&emsp;
				
				<br/><br/>
			</form>
				
 
     </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
      <div id="footer">
      <img src="imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      이용약관 | 취소정책 | 1:1문의 <br/>
      COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
      			
      </div>
    </div>
	
</body>

<%} %>


</html>
