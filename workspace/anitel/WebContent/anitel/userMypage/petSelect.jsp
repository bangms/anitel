<%@page import="java.util.List"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="anitel.model.PetDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫 선택</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <%-- jquery 라이브러리 추가 --%>
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
	if(session.getAttribute("sid") == null){// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기

		String id = (String)session.getAttribute("sid");
		PetDAO dao = PetDAO.getInstance();
		List Petlist = dao.getPetName(id); //수정하나 : 펫이름들, 펫 고유번호들 
		PetDTO pet = null;
		
		/*
		//String selected = request.getParameter("selected"); 
		// 수정 : 해당 페이지 다시 불러올때 Pet_name 받아와서 검색하기 
			
		if(selected != null){
			pet = dao.getSearchPet(id, selected);
		}else{
			pet = dao.getPet(id);
		}
		System.out.println(pet.getPet_name());

		System.out.println("pet_name");
		*/
	
%>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='../main.jsp'">
			<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
			<button id="mypage" onclick="window.location='userMyPage.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
		</div>
	</div>	

	<!-- 여기서부터 사이드바 입니다.  -->
		<div id="sidebar">
      	<h1 class="menu_name">마이페이지</h1>
        <div class="sidebar_menu_wrap">
					<div class="nav-wrap">
					  <nav class="main-nav" role="navigation">
					    <ul class="unstyled list-hover-slide">
					      <li class="menu"><a href="userMyReserve.jsp">나의 예약 현황</a></li>
						    <li class="menu"><a href="userMyPage.jsp">나의 정보</a></li>
						    <li class="menu"><a href="userQnA.jsp">나의 Q&A</a></li>
						    <li class="menu"><a href="userReview.jsp">나의 후기</a></li>
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
	     <h1>내 반려동물의 정보</h1>
	     <hr align="left" width=800 color="black">
	     <br/>
	     <form action= "/anitel/anitel/userMyPage/petinfoModifyPro.jsp" method="post"> 
				<table>
					<tr>
						<td width=150>
							<h3>이름</h3>
						</td>
						<td>
							<select id="pet_num" name="pet_num" >
								<%for(int i = 0; i < Petlist.size(); i++){
								PetDTO petname = (PetDTO)Petlist.get(i);
								%>
								<option value="<%=petname.getPet_num()%>"><%=petname.getPet_name()%></option> 
								<%}%>								
							</select>
							<input type="button" id="select" value="선택" onclick="popupOpen()" />&emsp;
						</td>
					</tr>
				</table> <br/>
				<input type="button" value="추가하기" onclick="window.location='/anitel/anitel/userMyPage/petAddForm.jsp'"/>&emsp;
				<input type="button" value="뒤로가기" onclick="window.location='/anitel/anitel/userMyPage/userMyPage.jsp'"/>&emsp;
				<br/><br/>
		 </form>
     </div>
         
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
      <div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      이용약관 | 취소정책 | 1:1문의 <br/>
      COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
      			
     </div>
   </div>
	
</body>
<script type="text/javascript">
function popupOpen(){
	var pet_num_sel = $("#pet_num").val();
	//console.log(pet_num_sel);
	var popUrl = "popupForm.jsp?pop=9&pet_num=" + pet_num_sel;	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
</script>
<%} %>
</html>
