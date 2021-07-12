<%@page import="anitel.model.BoardDTO"%> 
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.BoardDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
 	<link rel="stylesheet" href="../style/style.css">
 	<link rel="stylesheet" href="../style/reset.css">
	<link rel="stylesheet" href="../style/search.css">
</head>


<%
	String id =(String)session.getAttribute("sid");

	// ** 게시글 페이지 관련 정보 세팅 ** 
	// 한페이지에 보여줄 게시글의 수 
	
	// 게시판 구분 코드
	int categ= Integer.parseInt(request.getParameter("categ"));
	System.out.println("categ.list:" + categ);
	 
 	//categ =2 일때는 1을 들고 올것임 ( 비밀글 안들고 오니까 임의로 지정 ~
 	//int hidden_content = Integer.parseInt(request.getParameter("hidden_content"));
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
	BoardDAO dao = BoardDAO.getInstance(); 
	
	// 사업자, 일반회원인지 체크
	int checkID = dao.idCk(id);
	System.out.println("아이디 체크 - 사업자면 2, 일반회원이면 1 : " + checkID);
	
	List articleList = null;							// 전체(or검색된) 게시글들을 담을 list변수
	int count = 0;										// DB에 저장되어 있는 전체(or검색된) 글의 개수 보관
	int number = 0;										// 게시판 목록에 뿌려줄 가상의 글 번호
	
	
	// 검색했을 때 유효한 파라미터 호출
	String sel = request.getParameter("sel");
	System.out.println("list.sel=" +sel);
	String search = request.getParameter("search");
	System.out.println("list.search=" +search);
	if(sel != null && search != null){				// 검색한 경우
		// 검색한 글의 갯수 가져오기
		count = dao.getSearchArticleCount(categ, sel, search);		// 검색된 글의 총 갯수
		System.out.println("list.jsp - 검색된 총 게시글 수(count변수) : " + count + "개"); 
		if(count>0){										// 글 갯수가 0보다 크다면 글 번호 받기
			articleList = dao.getSearchArticles(categ, startRow, endRow, sel, search);  
		}
		number = count - (currentPage - 1) * pageSize;		// 가상의 글 번호 받기
	}else{											// 검색하지 않은 경우
		// 전체 글의 갯수 가져오기
		count = dao.getArticleCount(categ);						// DB 전체 글의 갯수를 가져와 담기
		System.out.println("list.jsp - 등록된 총 게시글 수(count변수) : " + count + "개");
	
		// 게시글이 하나라도 잇으면 글을 가져오기
		if(count>0){										// 글 갯수가 0보다 크다면 글 번호 받기
			articleList = dao.getArticles(startRow, endRow, categ); 
		}
		number = count - (currentPage - 1) * pageSize;		// 가상의 글 번호 받기
		
	}
	
	// 날짜 출력 형태 패턴 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	System.out.println("list.jsp - 세션이름 : " + session.getAttribute("sid"));
	
	
 %>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='../main.jsp'">
			<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='list.jsp?categ=0'">공지사항</button>
<% 	
	if(id == null){ 
%>
			<button id="signin" onclick="window.location='../signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='../loginForm.jsp'">로그인</button>
			
<%}else{ 
	if(checkID == 1) { 
		if(session.getAttribute("sid").equals("admin")) { %><%-- 관리자 일 때 --%>
			<button id="mypage" onclick="window.location='../adminMypage/adminMemberForm.jsp'">마이페이지</button>
	<%} else { %>
		<button id="mypage" onclick="window.location='../userMypage/userMyPage.jsp'">마이페이지</button>
	<%}
	}
	if(checkID == 2) { %><%-- 사업자 일 때 --%>
		<button id="mypage" onclick="window.location='../memberMypage/memberMyPage.jsp'">마이페이지</button>
<%}%>	
		<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
<%}%>

		</div>
	</div>	
	 <div id="section" align="center">
		<div id = "boardName" style="font-size:20px; font-weight: bold; color:black; padding:10px;">
		<!-- 게시판 이름 분기처리  -->
 		<% if (categ == 0){ %>
			<p align="center" > 공지사항 </h1>
		<%} else if(categ == 1){ %>
			<p align="center" > 1:1 문의 </h1>
		<%} else if(categ == 2){ %>
			<p align="center" > 호텔Q&A </h1>
		<%} else if(categ == 3){ %>
			<p align="center" > 후기 </h1>
		<% } %>
		</div>
 	 
	<%-- 게시글이 없는 경우 --%>
 	<%
 	boolean check = false;
 	if(count==0){ %>
	 <table>
		<tr>
			<td align="center"> 게시글이 없습니다. </td>
		</tr>
<% 		if(categ == 0) { /* 공지사항 */
			if("admin".equals(id)) {%><%-- 관리자만 글쓰기 가능 --%>
				<tr>
					<td><button onclick="window.location='writeForm.jsp?categ=<%=categ%>'"> 글쓰기 </button></td>
				</tr>
<%			} %>
<%		} else if(categ == 1) { /* 1:1 문의 */%>
			<tr>
				<td><button onclick="window.location='writeForm.jsp?categ=<%=categ%>'"> 글쓰기 </button></td>
			</tr>
<%		} else if(categ == 2) { /* 호텔 QNA */ 
			if(checkID == 1) {%><%-- 고객만 글쓰기 가능 / 무슨 호텔인지 보내주기 &reg_num=<%=reg_num%> --%>
				<tr>
					<td><button onclick="window.location='writeForm.jsp?categ=<%=categ%>'"> 글쓰기 </button></td>
				</tr>
		<%  } %>
<%		} else if(categ == 3) { /* 호텔 후기 */
			check = dao.paymentUserCk(id,"000-000-000001");
			if(check) { %>
				<tr>
					<td><button onclick="window.location='writeForm.jsp?categ=<%=categ%>'"> 글쓰기 </button></td>
				</tr>
<%			} %>
<%		} %>
	</table>
	 
	<% }else{ %> 		
			<div class="table_wrap">
				  <ul class="responsive-table">
				    <li class="table-header">
				      <div class="col col-1" style="flex-basis: 5%;">No.</div>
				      <div class="col col-2" style="flex-basis: 45%;">제목</div>
				      <div class="col col-3" style="flex-basis: 20%;">작성자</div>
				      <div class="col col-4" style="flex-basis: 20%;">날짜</div>
				      <div class="col col-5" style="flex-basis: 10%;">조회수</div>
				    </li>
		
		<%for(int i=0; i< articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i); %>  

			<script type="text/javascript">
	         function secret(board_num, pageNum, categ) {
	            var url = "popCheckPw.jsp?pageNum=" + pageNum + "&board_num=" + board_num + "&categ=" + categ;
	            window.open(url,"checkPw","toolbar=no, location=no, status=no, menubar=no, scrollbars=no resizeable=no, width=300, height=200");
	         }
			</script>
       	
			<li class="table-row">
				<div class="col col-1" style="flex-basis: 5%;"><%= number--%></div>
				<div class="col col-2" style="flex-basis: 45%;">
<% 					if(categ == 0) {%> <%-- 공지사항 --%>
								<a class="list_subject" href="content.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=<%=categ%>"><%=article.getSubject() %></a>
<%					} else if(categ == 1 || categ == 2) { /* 1:1 문의(1) / 호텔 QNA (2) */ 
								if(hidden_content == 0) { %> <%-- 비밀글이 아니면 --%>
									<a class="list_subject" href="content.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=<%=categ%>"><%= article.getSubject() %></a>
<%							} else { // 비밀글이면
										if("admin".equals(id)) {%> <%-- 관리자는 그냥 볼 수 있게 --%>
												<a class="list_subject" href="content.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=<%=categ%>">[비밀글]<%= article.getSubject() %></a>
<%									} else { %>
												<a class="list_subject" href="#" onclick="secret(<%=article.getBoard_num()%>, <%=pageNum%>, <%=categ%>); return false;">[비밀글]<%= article.getSubject() %></a>
<%									}
								}
						} else if(categ == 3) { %> <%-- 호텔 후기--%>
								<a class="list_subject" href="content.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=<%=categ%>"><%= article.getSubject() %></a>
<%					} %>
				</div>
				<div class="col col-3" style="flex-basis: 20%;"><%= article.getId()%></div>
	      <div class="col col-4" style="flex-basis: 20%;"><%= sdf.format(article.getReg_date()) %></div>
	      <div class="col col-5" style="flex-basis: 10%;"><%= article.getReadcount()%></div>
			</li>
		<%} %>
		
				<!-- TODO 페이지랑 연결 후 지울 부분  -->
		<% 		if(categ == 0) { /* 공지사항 */
						if("admin".equals(id)) {%><%-- 관리자만 글쓰기 가능 --%>
							<input class="write_btn btn" type="button" onclick="window.location='writeForm.jsp?categ=<%=categ%>&pageNum=<%=pageNum %>'" value="글쓰기">
		<%			} %>
		<%		} else if(categ == 1) { /* 1:1 문의 */
						if(id != null) {%>
						<input class="write_btn btn" type="button" onclick="window.location='writeForm.jsp?categ=<%=categ%>&pageNum=<%=pageNum %>'" value="글쓰기">
					<%	} %>
			<%		} else if(categ == 2) { /* 호텔 QNA */ 
						if(checkID == 1) {%><%-- 고객만 글쓰기 가능 / 무슨 호텔인지 보내주기 &reg_num=<%=reg_num%> --%>
							<input class="write_btn btn" type="button" onclick="window.location='writeForm.jsp?categ=<%=categ%>&pageNum=<%=pageNum %>'" value="글쓰기">
					<%  } %>
			<%		} else if(categ == 3) { /* 호텔 후기 결제고객 전용 */
						check = dao.paymentUserCk(id,"000-000-000001");
						if(check) { %>
							<input class="write_btn btn" type="button" onclick="window.location='writeForm.jsp?categ=<%=categ%>&pageNum=<%=pageNum %>'" value="글쓰기">
			<%			} %>
			<%		} %>	
				<button onclick="window.location='category.jsp'"> 카테고리</button>
			</ul>
		</div>
		<%} %>
		
	  <%-- 페이지 번호 --%>
		<div align="center">
		<%	if(count>0){
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
		<%			}
				
					// 페이지 번호
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="list.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>" class="pageNums"> &nbsp; [<%= i %>] &nbsp; </a>
		<%			}
				
					// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
					if(endPage < pageCount){%>
						<a href="list.jsp?pageNum=<%=startPage + pageBlock%>&sel=<%=sel%>&search=<%=search%>&categ=<%=categ%>" class="pageNums"> &gt; </a>
		<%			}
				}else{
			
					// 왼쪽 꺾쇠 : startPage가 pageBlock(5)보다 크면 생성
					if(startPage > pageBlock){ %>
						<a href="list.jsp?pageNum=<%= startPage-pageBlock %>&categ=<%=categ%>" class="pageNums"> &lt; </a>
		<%			}
				
					// 페이지 번호
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="list.jsp?pageNum=<%=i%>&categ=<%=categ%>" class="pageNums"> &nbsp; [<%= i %>] &nbsp; </a>
		<%			}
				
					// 오른쪽 꺾쇠 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막 번호) 보다 크면
					if(endPage < pageCount){%>
						<a href="list.jsp?pageNum=<%=startPage + pageBlock%>&categ=<%=categ%>" class="pageNums"> &gt; </a>
		<%			}
				}
			}%>
			
			<%-- 아이디 , 글제목 으로 검색 --%>
			<form action="list.jsp"> 
			
				<input type="hidden" name="categ" value="<%=categ%>"/>
				<div class="search_wrap">
					<div id="sel" class="select-box">
					  <div class="select-box_current" tabindex="1">
					    <div class="select-box_value">
					      <input class="select-box_input" type="radio" id="id" value="id" name="sel" checked="checked"/>
					      <p class="select-box_input-text">아이디</p>
					    </div>
					    <div class="select-box_value">
					      <input class="select-box_input" type="radio" id="subject" value="subject" name="sel"/>
					      <p class="select-box_input-text">글제목</p>
					    </div>
					    <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
					  </div>
					  <ul class="select-box_list">
					    <li>
					      <label class="select-box_option" for="id" aria-hidden="aria-hidden">아이디</label>
					    </li>
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
			 <img src="../imgs/logo2.png" width=100px; height=50px;>
			 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
			 이용약관 | 취소정책 | 1:1문의 <br/>
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
			</div>
  </div>
</body>
</html>