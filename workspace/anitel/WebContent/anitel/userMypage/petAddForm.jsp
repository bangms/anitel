<%@page import="anitel.model.PetDTO"%>
<%@page import="anitel.model.PetDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려동물 추가폼</title>
</head>
<%	request.setCharacterEncoding("UTF-8");	
	if(session.getAttribute("sid")==null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
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
		 <h1>반려동물 추가</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
			<form action= "/anitel/anitel/userMyPage/petAddPro.jsp" method="post" name="inputForm" onsubmit="return check()"> 
				<table>
					<tr>
						<td width=150><h3>이름</h3></td>
						<td><input type="text" name="pet_name" style="width:300px;"/></td>
					</tr>
					<tr>
						<td width=150><h3>종</h3></td>
						<td>
							<select id="pet_type" name="pet_type">
								<option value="" disabled selected>선택	</option>
								<option value="1">강아지</option>
								<option value="2">고양이</option>
								<option value="0">기타동물</option>
							</select>
						<input type="text" name="pet_etctype" style="height:30px;" placeholder="기타동물 입력란"/></td>
						
					</tr>
					 <tr> 
					 	<td><h3>반려동물 성별</h3></td>
               				<td> 
                   			<input type="radio" name='pet_gender' value="1"/> 수컷 
                   			<input type="radio" name='pet_gender' value="0"/> 암컷     
              				</td>
           			</tr> 
					<tr>	
						<td width=150><h3>중성화 여부</h3></td>
						<td>
							<input type="radio" name="pet_operation" value="1">예 
							<input type="radio" name="pet_operation" value="0">아니오							
						</td>
					</tr>
					<tr>
						<td width=150><h3>나이</h3></td>
						<td><input type="text" name="pet_age" style="width:300px; "/></td>
					</tr>
					<tr>	
						<td width=150><h3>대형동물	</h3></td>
						<td>
							<input type="checkbox" name="pet_big" value="1"> 20kg 이상일 경우 체크해주세요.
						</td>
					</tr>
				</table>
	
	  		    <br/>
	      		<input type="submit" value="추가하기" />&emsp;
				<input type="button" value="돌아가기" onclick="window.location='/anitel/anitel/userMyPage/petSelect.jsp'"/>&emsp;
				
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
