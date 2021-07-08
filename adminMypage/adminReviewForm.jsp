<%@page import="anitel.model.ReviewDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BoardDTO"%>
<%@page import="anitel.model.AdminDAO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<% 
	request.setCharacterEncoding("UTF-8");

	int pageSize = 10; // 한 페이지에 보여줄 정보의 수, 10개 출력할꺼니까 10
	
	
	
		//페이지 재호출하면 현재페이지 번호 요청함
	String pageNum = request.getParameter("pageNum"); 
	
	if(pageNum == null){ //adminReviewForm.jsp라고만 요청하여 pageNum 파라미터가 안넘어왔을때.
		pageNum = "1";
	}
	
	//현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage -1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
			
	int count = 0; 
				
	String selected = request.getParameter("selected");
	String search = request.getParameter("search");
	
	AdminDAO dao = AdminDAO.getInstance();
	
	List reviewList = null;
	
	
	
	if(selected != null && search != null){ // selected와 search가 null(파라미터 없음)이 아니면
		
		count = dao.getReviewSearchCount(selected, search);//검색조건으로 갯수받아옴
		if(count > 0){
			reviewList = dao.getSearchReview(startRow, endRow, selected, search);
		} // 끝번호 시작번호, 검색조건으로 출력
		
	}else{//selected와 search가 null이면
		count = dao.getReviewCount(); // 갯수 받아옴
		if(count > 0){
			reviewList = dao.getReview(startRow, endRow); // 끝번호 시작번호만으로 출력
		}
	}

	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		
%>
<script>
		function chkReview() {
			obj = document.getElementsByName("info");	
			
			var cnt = 0;
			for(var i = 0; i < obj.length; i++) {
                if (obj[i].checked) {
                    cnt++;
                }
            }
			if(cnt == 0){
				alert("선택된 회원 정보가 없습니다.");
				return;
			}else{
				var frm = document.frmReviewInfo		
				var url ="/anitel/anitel/adminMypage/adminReviewDeleteForm.jsp";
				window.open('','reviewdelete','width=500,height=300,location=no,status=no,scrollbars=yes');
				
				frmReviewInfo.action = url;
				frmReviewInfo.target = 'reviewdelete'
				frmReviewInfo.submit();
			}			
		}
</script>


<body>
 <div id="header">
      	<div id="logo">
       		 <img src="imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       		 <div id="button">
        		<button id="notice" onclick="window.location='list.jsp'">공지사항</button>
        		<button id="signin" onclick="window.location='/anitel/signinUserForm.jsp'">회원가입</button>
   	     		<button id="login" onclick="window.location='/anitel/userLoginForm.jsp'">로그인</button>
       		 </div>
        </section>
      </div>

	<!-- 여기서부터 사이드바 입니다.  -->
       <div id="main">
	      <div id="sidebar">
	        <h1>관리자 페이지</h1>
	        <ul>
	          <a href="adminUserForm.jsp"><li>회원관리</li></a>
	          <a href="adminMemberForm.jsp"><li>사업자 관리</li></a>
	          <a href="adminReserveForm.jsp"><li>예약 관리</li></a>
	          <a href="adminReviewForm.jsp"><li>후기 관리</li></a>
	          <a href=""><li>공지사항</li></a>
	          <a href="adminMemberQnAForm.jsp"><li>사업자 1:1문의</li></a>
	          <a href="adminUserQnAForm.jsp"><li>일반회원 1:1문의</li></a>
	        </ul>
	      </div>
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      
    <div id="content">
    
<%if(count == 0) {%>
<h3 align="center"> 표시할 내용이 없습니다. </h3>
<%}else{%>
<form action="adminReviewForm.jsp" name="frmReviewInfo" method="post">
<table>
	<tr>
		<td><%--체크박스용 빈칸--%></td>
		<td>작성일</td>
		<td>아이디</td>
		<td>후기호텔</td>
		<td>제목</td>
		<td>상태</td>
		<td>답변 여부</td>
	</tr>
	<% // 반복문으로 게시판처럼 회원의 정보를 출력함. 
	int i;
		for(i = 0;i < reviewList.size(); i++){
			ReviewDTO review = (ReviewDTO)reviewList.get(i);
	%>
	<tr>
		<td><input type="checkbox" name="info" value="<%=review.getBoard_num()%>" /></td>
		<td><%=sdf.format(review.getReg_date())%></td>
		<td><%=review.getId()%></td>
		<td><%=review.getHotel_name()%></td>
		<td><%=review.getSubject()%></td>
		<td><%if(review.getComm() == 0){%>답변중
		<%}else if(review.getComm() == 1){%>답변완료<%}%></td>
		<td><%if(review.getComm() == 0){%><button>답변완료</button>
		<%}else if(review.getComm() == 1){%><button onclick="<%-- 답변페이지 --%>">답변하기</button><%}%></td>
	</tr>
	<%}//후기 정보 출력리스트반복문 닫기%>

</table>

<% if(count > 10){
		
		int pageBlock = 10;
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
		int endPage = startPage * pageBlock -1;

		//전체 페이지수(pageCount)가 위에서 계산한 endPage(10단위씩)보다 작으면
		//전체 페이지수가  endPage가 된다.
		if(endPage > pageCount) endPage = pageCount;
		
		//왼쪽 꺾쇄 : StartPage가 pageBlock(10)보다 크면
		if(startPage > pageBlock){ %>
		<a href="adminReviewForm.jsp?pageNum=<%=startPage-pageBlock %>"> &lt; </a>
		&nbsp; &nbsp;
	<% } 
		
		//페이지 번호 뿌리기
		for(i = startPage; i <= endPage; i++){ %>
			<a href="adminReviewForm.jsp?pageNum=<%=i%>" class="pageNums"><%=i%></a>
			&nbsp; &nbsp;
	<%	}
		
		//오른쪽 꺾쇄 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막번호)보다 크면
		if(endPage < pageCount) { %>
			<a href="adminReviewForm.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
		&nbsp; &nbsp; 
	<% 	}
	
	}%>
<br />
<select size="1" name="selected">
	<option value="id" selected>작성자</option>
	<option value="hotel_name">호텔명</option>
</select>

<input type="text" name="search">
<input type="submit" value="검색" >
<button type="button" onclick="chkReview()" >삭제</button>

 

<%}//count이 0이 아닐때 if문 닫기%>
		</form>
	</div>
</div>


	<div id="footer">
      <img src="imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      	이용약관 | 취소정책 | 1:1문의 <br/>
      	COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>  			
    </div>
</body>
</html>