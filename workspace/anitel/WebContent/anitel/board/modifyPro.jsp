<%@page import="java.sql.Timestamp"%>
<%@page import="anitel.model.BoardDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
  	<link rel="stylesheet" href="../style/init.css">	
</head>
<%
	request.setCharacterEncoding("UTF-8");

	//컨텐츠에서 보고 있던 페이지 번호 뽑아오기 
	String pageNum = request.getParameter("pageNum"); 
 
	String id = (String)session.getAttribute("sid");
	System.out.println("sid=" + id);	

	String path = request.getRealPath("upload");
	System.out.println(path);
	
	int max = 1024*1024*5; //5m
 	String enc ="UTF-8";	//인코딩 
 	
 
 	//덮어쓰기 방지 객체 : 중복이름으로 파일 저장시 파일 자동으로 이름 생성 
 	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
 	// MultipartRequest 객체생성
 	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
 	
 	int board_num = Integer.parseInt(mr.getParameter("board_num"));
 	System.out.println("board_num=" + board_num);
 	int categ = Integer.parseInt(mr.getParameter("categ"));
 	System.out.println("categ=" + categ);
  
 	String subject = mr.getParameter("subject");
 	System.out.println("subject=" + subject); 
 	String ctt = mr.getParameter("ctt");
 	System.out.println("ctt=" + ctt);
 	String pw = mr.getParameter("pw");
 	System.out.println("pw=" + pw);
 	
	String sysName = mr.getFilesystemName("img"); // 파일 넘어오는 이름 
	String orgName = mr.getOriginalFileName("img"); // 파일 원본 이름 
 	String contentT = mr.getContentType("img"); 
	
 	System.out.println("img=" + sysName);
 	
 	if(sysName != null){
		String[] ct = contentT.split("/");
		if(!(ct[0].equals("image"))){
			File f = new File(sysName);
			f.delete();
		%>
			<script type="text/javascript">
				alert("이미지 파일이 아닙니다. 이미지 파일을 업로드해주세요.");
				history.go(-1);
			</script>		
		<%	
		}
	}
 	
 %>
 <%
 	
	BoardDTO dto = new BoardDTO();
	dto.setBoard_num(board_num);
	dto.setId(id);
	dto.setCateg(categ); 
 	dto.setSubject(subject);
 	dto.setPw(pw); 
 	dto.setCtt(ctt);
 	dto.setImg(sysName);
 	dto.setReg_date(new Timestamp(System.currentTimeMillis()));
 	dto.setReadcount(0);  
 	dto.setComm(0);
 	dto.setHidden_content(0);
 	

 	BoardDAO dao = BoardDAO.getInstance();
 	int result = dao.updateArticle(dto, categ);
 	
 	if(result == 1){
 		response.sendRedirect("content.jsp?board_num=" + dto.getBoard_num() + "&pageNum=" + pageNum + "&categ=" + categ);
	}else{ %>
		<script>
			alert("비밀번호가 맞지 않습니다 ");
			history.go(-1);
		</script>
<%} 
%>
 
<body>
	
</body>
</html>