<%@page import="anitel.model.BoardDAO"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="anitel.model.BoardDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="anitel.model.TestDAO"%>
<%@page import="anitel.model.BookingDAO"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%   
	response.setContentType("application/json; charset=UTF-8");
	
	String path = request.getRealPath("save");
	int max = 1024*1024*5; //5m
 	String enc ="UTF-8";	//인코딩 
 
 	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
 	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

 	String id = mr.getParameter("id");
 	String subject = mr.getParameter("subject");
 	String pw = mr.getParameter("pw");
 	String ctt = mr.getParameter("ctt");
 	int categ = Integer.parseInt(mr.getParameter("categ"));
 	String reg_num = mr.getParameter("reg_num");
 	String sysName = mr.getFilesystemName("img"); // 파일 넘어오는 이름 
	String orgName = mr.getOriginalFileName("img"); // 파일 원본 이름 
 	String contentT = mr.getContentType("img"); // 파일 종류 
 	
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
 	
	BoardDTO board = new BoardDTO();
	board.setId(id);
	board.setReg_num(reg_num);
	board.setCateg(categ); 
 	board.setSubject(subject);
 	board.setPw(pw);
 	board.setCtt(ctt);
 	board.setImg(sysName);
 	board.setReg_date(new Timestamp(System.currentTimeMillis()));
 	board.setReadcount(0);  
 	board.setComm(0);
 	board.setHidden_content(0);
 	

 	BoardDAO b_dao = BoardDAO.getInstance(); 
 	b_dao.insertArticle(board);
	
	
	%>			
