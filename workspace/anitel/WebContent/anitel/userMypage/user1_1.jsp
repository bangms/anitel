<%@page import="anitel.model.UserBoardDTO"%> 
<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.UsersDAO"%>
<%@page import="anitel.model.BoardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지(일반회원) -1:1 문의 관리 </title>
<link rel="stylesheet" href="../style/style.css">
<link rel="stylesheet" href="../style/reset.css">
<link rel="stylesheet" href="../style/search.css">
<link rel="stylesheet" href="../style/mypage.css">
<script type="text/javascript">
		function secret(board_num, pageNum, categ) {
			var url = "popCheckPw.jsp?pageNum=" + pageNum + "&board_num=" + board_num + "&categ=" + categ;
			window.open(url,"checkPw","toolbar=no, location=no, status=no, menubar=no, scrollbars=no resizeable=no, width=300, height=200");
		}
	</script>
</head>
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ %>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script> 
<%	}else{ 
	String id = (String) session.getAttribute("sid");
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO user = dao.getuser(id);
	System.out.println("user id : " + user.getId());	
	
	// 게시판 구분 코드
	//int categ= Integer.parseInt(request.getParameter("categ"));
	int categ = 1;
	System.out.println("categ.list:" + categ);

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
		// 전체 글의 갯수 가져오기
		count = bdao.getuserQnaCount(categ, user.getId());						// DB 전체 글의 갯수를 가져와 담기
		System.out.println("list.jsp - 등록된 총 게시글 수(count변수) : " + count + "개");
		// 게시글이 하나라도 잇으면 글을 가져오기
		if(count>0){										// 글 갯수가 0보다 크다면 글 번호 받기
			articleList = bdao.getuserQna(startRow, endRow, categ, user.getId()); 
		}
		number = count - (currentPage - 1) * pageSize;		// 가상의 글 번호 받기
	
		
	// 날짜 출력 형태 패턴 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
%>
<body>
	<div id="container">
		<div id="header">
			<div id="logo" onclick="window.location='../main.jsp'">
				<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
			</div>
			<div id="button">
				<button id="notice"
					onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
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
							<li class="menu"><a href="userQnA.jsp">나의 QnA</a></li>
							<li class="menu"><a href="userReview.jsp">나의 후기</a></li>
							<li class="menu"><a href="user1_1.jsp">1:1문의</a></li>

						</ul>
					</nav>
				</div>
			</div>
		</div>
		<!-- 여기서부터 콘텐츠 화면 입니다.  -->
		<div id="section" style="padding-left: 15%; margin-left: 40px;">

			<div class="table_wrap">
				<h2>1:1 문의</h2>
				<ul class="responsive-table">
					<%	if(count==0){ %>
					<li class="table-header">
						<div class="col col-1">No.</div>
						<div class="col col-2">제 목</div>
						<div class="col col-3">날 짜</div>
						<div class="col col-4">조회수</div>
						<div class="col col-5">답변여부</div>
						
					</li>
					<li>
						<div style="flex-basis: 100%;">게시글이 없습니다.</div>
					</li>
					<%	}else{ %>
					<li class="table-header">
						<div class="col col-1" style="flex-basis: 5%;">No.</div>
						<div class="col col-2" style="flex-basis: 30%;">제 목</div>
						<div class="col col-3" style="flex-basis: 30%;">날 짜</div>
						<div class="col col-4" style="flex-basis: 15%;">조회수</div>
						<div class="col col-5" style="flex-basis: 20%;">답변여부</div>
						
					</li>

					<%		for(int i=0; i< articleList.size(); i++){
								UserBoardDTO article = (UserBoardDTO)articleList.get(i); %>

					<li class="table-row">
						<div class="col col-1" style="flex-basis: 5%;"><%= number--%></div>
						<div class="col col-2" style="flex-basis: 30%;">
							<a class="list_subject"
								href="../board/content.jsp?board_num=<%= article.getBoard_num()%>&categ=<%=categ%>&pageNum=<%=pageNum%>"><%=article.getSubject() %></a>
						</div>
						<div class="col col-3" style="flex-basis: 30%;"><%= sdf.format(article.getReg_date()) %></div>
						<div class="col col-4" style="flex-basis: 15%;"><%= article.getReadcount()%></div>
						<div class="col col-5" style="flex-basis: 20%;">
							<%if(article.getComm()==1){ %>
								답변 완료
							<%}else{ %>
								답변중
							<%} %>
						</div>					
					</li>
					<%		} 
						}%>
				</ul>
			</div>

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
				
			
				// 왼쪽 꺾쇠 : startPage가 pageBlock(5)보다 크면 생성
					if(startPage > pageBlock){ %>
				<a
					href="userQnA.jsp?pageNum=<%= startPage-pageBlock %>&categ=<%=categ%>"
					class="pageNums"> &lt; </a>
				<%					}
				// 페이지 번호
					for(int i = startPage; i <= endPage; i++){ %>
				<a href="userQnA.jsp?pageNum=<%=i%>&categ=<%=categ%>" class="pageNums">
					&nbsp; [<%= i %>] &nbsp;
				</a>
				<%					}
				// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
				if(endPage < pageCount){%>
				<a
					href="userQnA.jsp?pageNum=<%=startPage + pageBlock%>&categ=<%=categ%>"
					class="pageNums"> &gt; </a>
				<%				}
			
	}%>
				<%-- 아이디 , 글제목 으로 검색 --%>
				<form action="list.jsp">

					<input type="hidden" name="categ" value="<%=categ%>" /><br/>
				
					<h3 style="color: black">
						현재 페이지 :
						<%=pageNum%></h3>
				</form>

			</div>
		</div>


		<!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->
		<div id="footer">
			<img src="../imgs/logo2.png" width=100px; height=50px;>
			<p>
				평일 10:00 - 17:00 | anitel@anitel.com <br /> 이용약관 | 취소정책 | 1:1문의 <br />
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.
			</p>
		</div>
	</div>
</body>
<%	} %>
</html>
