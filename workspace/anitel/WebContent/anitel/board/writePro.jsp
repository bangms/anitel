<%@page import="javax.websocket.SendResult"%>
<%@page import="anitel.model.BoardDTO"%> 
<%@page import="java.sql.Timestamp"%> 
<%@page import="anitel.model.BoardDAO"%> 
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
 
	String id = (String)session.getAttribute("sid");
	System.out.println("sid=" + id);	

	String path = request.getRealPath("save");
	System.out.println(path);
	
	int max = 1024*1024*5; //5m
 	String enc ="UTF-8";	//인코딩 
 	
 
 	//덮어쓰기 방지 객체 : 중복이름으로 파일 저장시 파일 자동으로 이름 생성 
 	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
 	// MultipartRequest 객체생성
 	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
 	
 	//넘어온 파라미터 꺼내기
 	//int num = Integer.parseInt(mr.getParameter("num"));
	//String categ = mr.getParameter("categ");
 	
	System.out.println("-writePro.jsp-");
	
 	String subject = mr.getParameter("subject");
 	System.out.println("subject=" + subject);
 	
 	String pw = mr.getParameter("pw");
 	System.out.println("pw=" + pw);
 	
 	String ctt = mr.getParameter("ctt");
 	System.out.println("ctt=" + ctt);
 	
 	int board_num = Integer.parseInt(mr.getParameter("board_num"));
 	System.out.println("board_num=" + board_num);
 	
 	int categ = Integer.parseInt(mr.getParameter("categ"));
 	System.out.println("categ=" + categ);
 	
 	//categ =2 일때는 1을 들고 올것임 ( 비밀글 )
 	int hidden_content = Integer.parseInt(mr.getParameter("hidden_content"));
 	System.out.println("hiddenWP=" + hidden_content);
 	
 
 	String sysName = mr.getFilesystemName("img"); // 파일 넘어오는 이름 
	String orgName = mr.getOriginalFileName("img"); // 파일 원본 이름 
 	String contentT = mr.getContentType("img"); // 파일 종류 
 	
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
 	dto.setHidden_content(hidden_content);
 	

 	BoardDAO dao = BoardDAO.getInstance();
 	dao.insertArticle(dto);
 
 
 	response.sendRedirect("list.jsp?categ="+categ);

%>

<body>

</body>
</html>