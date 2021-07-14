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
	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/search.css">
	<link rel="stylesheet" href="style/datepicker.min.css">
	<script src="js/jquery-3.1.1.min.js"></script>
 	<script src="js/datepicker.min.js"></script>
 	<script src="js/datepicker.ko.js"></script>
	<script type="text/javascript" src="js/search.js"></script>
	<title> 디테일페이지</title>
</head>
<style>
/* 메인페이지 height 100% 옵션주기 위한 div */
.box {
	height: 140px;
}

.main_form {
	width: 80%;
	position: absolute;
	left: 50%;
	transform: translate(-50%, 0);
	margin-top: 30px;
	text-align: center;
}

.search_bar {
	display:inline-flex;
}

</style>

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
			<button id="notice">공지사항</button>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
		</div>
	</div>	
  <div id="section" class="detail_wrapper">
        	<h1><%=hotel_name %> 님의 후기</h1>
      		<hr align="left" width=800 color="black">
      		<br/>
      		
<%	if(count==0){ %>
	<table>
		<tr>
			<td align="center"> 게시글이 없습니다. </td>
		</tr>
	</table>
<%	}else{ %> 
	<table border="1" width="80%">
		<tr>
			<td> No. </td>
			<td> 제 목 </td>
			<td> 작성자 </td>
			<td> 날 짜 </td>	 		
			<td> 조회수 </td>
		</tr>
		
<%		for(int i=0; i< articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i); %>
			<tr><!-- 제목 부분 -->
				<td><%= number--%></td>
 				<td><a class="list_subject" href="../anitel/board/content.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=<%=categ%>"><%=article.getSubject() %> </a></td>
				<td> 익 명 </td>
				<td><%= sdf.format(article.getReg_date()) %></td>
				<td><%= article.getReadcount()%></td>
			</tr>
<%		} %>	
		</table>
		<br /><br />
<%	} %>

	<input type="button" value="뒤로가기" onclick="history.back()"/>
		
		
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
					<a href="list.jsp?pageNum=<%= startPage-pageBlock %>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>" class="pageNums"> &lt; </a>
<%				}
				// 페이지 번호
				for(int i = startPage; i <= endPage; i++){ %>
					<a href="list.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>" class="pageNums"> &nbsp; [<%= i %>] &nbsp; </a>
<%				}
				// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
				if(endPage < pageCount){%>
					<a href="list.jsp?pageNum=<%=startPage + pageBlock%>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>" class="pageNums"> &gt; </a>
<%				}
			}else{
				// 왼쪽 꺾쇠 : startPage가 pageBlock(5)보다 크면 생성
					if(startPage > pageBlock){ %>
						<a href="list.jsp?pageNum=<%= startPage-pageBlock %>&categ=<%=categ%>" class="pageNums"> &lt; </a>
<%					}
				// 페이지 번호
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="list.jsp?pageNum=<%=i%>&categ=<%=categ%>" class="pageNums"> &nbsp; [<%= i %>] &nbsp; </a>
<%					}
				// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
				if(endPage < pageCount){%>
					<a href="list.jsp?pageNum=<%=startPage + pageBlock%>&categ=<%=categ%>" class="pageNums"> &gt; </a>
<%				}
			}
	}%>		
		<br/><br/>
			<%-- 아이디 , 글제목 으로 검색 --%>
			<form action="list.jsp"> 
				<input type="hidden" name="categ" value="<%=categ%>"/>
				<select name="sel">
					<option value="id">아이디</option>
					<option value="subject">글제목</option> 
				</select>
				<input type="text" name="search"/>
				<input type="submit" value="검색"/>
			</form>
			
			<h3 style="color:black">현재 페이지 : <%=pageNum%></h3>
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