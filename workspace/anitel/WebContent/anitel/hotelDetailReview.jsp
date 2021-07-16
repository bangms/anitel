<%@page import="anitel.model.BoardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.BoardDAO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> HotelQA 게시판</title>
 	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/search.css">
</head>
 

<%	
	request.setCharacterEncoding("UTF-8");


	String id = (String)session.getAttribute("sid");
	
	String memId = request.getParameter("memId");
	System.out.println("hdqa =" + memId);
	
	String reg_num = request.getParameter("reg_num");
	System.out.println("hdqa =" + reg_num);
	
	String hotel_name = request.getParameter("hotel_name");
	System.out.println("hdqa =" + hotel_name);
	
	
	MemberDAO dao = MemberDAO.getInstance();
	
	// 게시판 구분 코드
	//int categ= Integer.parseInt(request.getParameter("categ"));
	int categ = 3;
	System.out.println("categ.list:" + categ);
	
	int hidden_content = 0;
	if (categ == 2){
		hidden_content = 1;
	}
	int pageSize = 5; 
	
	//현재 페이지 번호
		String pageNum = request.getParameter("pageNum");  
		if(pageNum == null) {  
			pageNum = "1"; 
		}
	
	// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅 
	int currentPage = Integer.parseInt(pageNum);		// 계산용 형변환
	int startRow = (currentPage - 1) * pageSize + 1;	// 페이지 시작 글 번호
	int endRow = currentPage * pageSize;
	
	
	//게시판 글가져오기
	BoardDAO bdao = BoardDAO.getInstance(); 
	boolean check = false;
	
	// 사업자, 일반회원인지 체크
	int checkID = bdao.idCk(id);
	System.out.println("아이디 체크 - 사업자면 2, 일반회원이면 1 : " + checkID);
	
	
		
	List articleList = null;							// 전체(or검색된) 게시글들을 담을 list변수
	int count = 0;										// DB에 저장되어 있는 전체(or검색된) 글의 개수 보관
	int number = 0;										// 게시판 목록에 뿌려줄 가상의 글 번호
		
	// 검색했을 때 유효한 파라미터 호출
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	if(sel != null && search != null){					// 검색한 경우
		// 검색한 글의 갯수 가져오기
		count = bdao.getSearchQnaArticleCount(categ, sel, search, reg_num);		// 검색된 글의 총 갯수   
		System.out.println("list.jsp - 검색된 총 게시글 수(count변수) : " + count + "개"); 
		if(count>0){										// 글 갯수가 0보다 크다면 글 번호 받기
			articleList = bdao.getSearchQnaArticles(categ, startRow, endRow, sel, search, reg_num);  
		}
		number = count - (currentPage - 1) * pageSize;		// 가상의 글 번호 받기
	}else{											// 검색하지 않은 경우
		// 전체 글의 갯수 가져오기
		count = bdao.getQnaArticleCount(categ, reg_num);						// DB 전체 글의 갯수를 가져와 담기
		System.out.println("list.jsp - 등록된 총 게시글 수(count변수) : " + count + "개");
		// 게시글이 하나라도 잇으면 글을 가져오기
		if(count>0){										// 글 갯수가 0보다 크다면 글 번호 받기
			articleList = bdao.getQnaArticles(startRow, endRow, categ, reg_num); 
		}
		number = count - (currentPage - 1) * pageSize;		// 가상의 글 번호 받기
	}
		
	// 날짜 출력 형태 패턴 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
%>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
<% 	
	if(id == null){ 
%>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
			
<%}else{ 
	if(checkID == 1) { 
		if(session.getAttribute("sid").equals("admin")) { %><%-- 관리자 일 때 --%>
			<button id="mypage" onclick="window.location='adminMypage/adminUserForm.jsp'">마이페이지</button>
	<%} else { %>
		<button id="mypage" onclick="window.location='userMypage/userMyPage.jsp'">마이페이지</button>
	<%}
	}
	if(checkID == 2) { %><%-- 사업자 일 때 --%>
		<button id="mypage" onclick="window.location='memberMypage/memberMyPage.jsp'">마이페이지</button>
<%}%>	
		<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
<%}%>

		</div>
	</div>	
	 <div id="section" align="center">
		 <div id = "boardName" style="font-size:20px; font-weight: bold; color:black; padding:10px;">
        	<p><%=hotel_name %> 님의 후기</p>
      	</div>
<%	if(count==0){ %>
	<table>
		<tr>
			<td align="center"> 게시글이 없습니다. </td>
		</tr>
	</table>
<%}else{ %> 
	<div class="table_wrap">
				  <ul class="responsive-table">
				    <li class="table-header">
				      <div class="col col-1" style="flex-basis: 5%;">No.</div>
				      <div class="col col-2" style="flex-basis: 45%;">제목</div>
				      <div class="col col-3" style="flex-basis: 20%;">아이디</div>
				      <div class="col col-4" style="flex-basis: 20%;">날짜</div>
				      <div class="col col-5" style="flex-basis: 10%;">조회수</div>
				    </li>
		
			<%for(int i=0; i< articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i); %>
				<li class="table-row">
					<div class="col col-1" style="flex-basis: 5%;"><%= number--%></div>
 				<div class="col col-2" style="flex-basis: 45%;"> <a class="list_subject" href="board/content.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=<%=categ%>"><%=article.getSubject() %> </a>
				</div>
				<div class="col col-3" style="flex-basis: 20%;">  익 명  </div>
		     	<div class="col col-4" style="flex-basis: 20%;"><%= sdf.format(article.getReg_date()) %></div>
	      		<div class="col col-5" style="flex-basis: 10%;"><%= article.getReadcount()%></div>
			</li>
			<%}%>	
	
			<input class="write_btn btn"  type="button" value="뒤로가기" onclick="history.back()"/>
			
			<% check = bdao.paymentUserCk(id,reg_num); 
				if(check) { %> 
			<input class="write_btn btn" type="button" value="글쓰기" onclick="window.location='../anitel/board/writeForm.jsp?categ=3&amp;reg_num=<%=reg_num%>'" /> 
			<%} %>
			
		</ul>
	</div>	 
<%}%>

		
	  <%-- 페이지 번호 --%>
		<div align="center">
<%		if(count>0){
			// 페이지 번호를 몇개까지보여줄 것인지 지정
			int pageBlock=5;
			// 총 몇 페이지가 나오는지 계산
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			System.out.println("list.jsp - 전체 페이지 수 : " + pageCount);
			// 현재 페이지에서 보여줄 첫 번째 페이지 번호
			int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
			System.out.println("list.jsp - 시작 페이지 : " + startPage);
			// 현재 페이지에서 보여줄 마지막 페이지번호( ~10, ~20, ~30)
			int endPage = startPage + pageBlock - 1;
			System.out.println("list.jsp - 끝 페이지 : " + endPage);
			// 마지막에 보여줄 페이지 번호는 페이지 수에 따라 달라질 수 있다.
			// 전체 페이지 수가 endPage보다 적으면 전체 페이지 수가 endPage로 계산
			if(endPage > pageCount){
				endPage = pageCount;
			}
				
			if(sel != null && search != null){
				// 왼쪽 꺾쇠 : startPage가 pageBlock(5)보다 크면 생성
				if(startPage > pageBlock){ %>
					<a href="hotelDetailReview.jsp?pageNum=<%= startPage-pageBlock %>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>&amp;reg_num=<%=reg_num%>&memId=<%=memId%>&hotel_name=<%=hotel_name %>" class="pageNums"> &lt; </a>
<%				}
				// 페이지 번호
				for(int i = startPage; i <= endPage; i++){ %>
					<a href="hotelDetailReview.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>&amp;reg_num=<%=reg_num%>&memId=<%=memId%>&hotel_name=<%=hotel_name %>" class="pageNums"> &nbsp; [<%= i %>] &nbsp; </a>
<%				}
				// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
				if(endPage < pageCount){%>
					<a href="hotelDetailReview.jsp?pageNum=<%=startPage + pageBlock%>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>&amp;reg_num=<%=reg_num%>&memId=<%=memId%>&hotel_name=<%=hotel_name %>" class="pageNums"> &gt; </a>
<%				}
			}else{
				// 왼쪽 꺾쇠 : startPage가 pageBlock(5)보다 크면 생성
					if(startPage > pageBlock){ %>
						<a href="hotelDetailReview.jsp?pageNum=<%= startPage-pageBlock %>&categ=<%=categ%>&amp;reg_num=<%=reg_num%>&memId=<%=memId%>&hotel_name=<%=hotel_name %>" class="pageNums"> &lt; </a>
<%					}
				// 페이지 번호
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="hotelDetailReview.jsp?pageNum=<%=i%>&categ=<%=categ%>&amp;reg_num=<%=reg_num%>&memId=<%=memId%>&hotel_name=<%=hotel_name %>" class="pageNums"> &nbsp; [<%= i %>] &nbsp; </a>
<%					}
				// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
				if(endPage < pageCount){%>
					<a href="hotelDetailReview.jsp?pageNum=<%=startPage + pageBlock%>&categ=<%=categ%>&amp;reg_num=<%=reg_num%>&memId=<%=memId%>&hotel_name=<%=hotel_name %>" class="pageNums"> &gt; </a>
<%				}
			}
	}%>		

			 <br />
			 <br />
			<h3 style="color:black">현재 페이지 : <%=pageNum%></h3>
			<%-- 아이디 , 글제목 으로 검색 --%>
			<form action="hotelDetailReview.jsp"> 
				<input type="hidden" name="categ" value="<%=categ%>"/>
				<input type="hidden" name="reg_num" value="<%=reg_num%>"/>
				<input type="hidden" name="memId" value="<%=memId%>"/>
				<input type="hidden" name="hotel_name" value="<%=hotel_name%>"/>
				<div class="search_wrap">
					<div id="sel" class="select-box">
					  <div class="select-box_current" tabindex="1">
					    
					    <div class="select-box_value">
					      <input class="select-box_input" type="radio" id="subject" value="subject" name="sel" checked="checked"/>
					      <p class="select-box_input-text">글제목</p>
					    </div>
					    <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
					  </div>
					  <ul class="select-box_list">
					  
					    <li>
					      <label class="select-box_option" for="subject" aria-hidden="aria-hidden">글제목</label>
					    </li>
					  </ul>
					</div>
					<input class="search" type="text" name="search" />
					<input class="btn" type="submit" value="검색" />
				</div>
			</form>
			
				
		</div>
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
</html>
 
</html>