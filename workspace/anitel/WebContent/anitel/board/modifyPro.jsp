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

	String id = (String)session.getAttribute("sid");
	System.out.println("sid=" + id);

	//컨텐츠에서 보고 있던 페이지 번호 뽑아오기 
	String pageNum = request.getParameter("pageNum"); 
 	
	
	
 	
	BoardDTO dto = new BoardDTO();
	 	
 	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	
	int board_num = Integer.parseInt(mr.getParameter("board_num"));
 	System.out.println("board_num=" + board_num);
 	int categ = Integer.parseInt(mr.getParameter("categ"));
 	System.out.println("categ=" + categ);
 	String reg_num = request.getParameter("reg_num");
	System.out.println("list reg_num=" +reg_num);
 	
	// update imgMember set email = ? .... where id = ?
	// modify Form 에서 id 값이 안넘어오니, 세션에서 꺼내서 dto에 추가
	dto.setBoard_num(board_num);
	dto.setId(id);
	dto.setReg_num(reg_num);
	dto.setCateg(categ); 
 	dto.setSubject(mr.getParameter("subject"));
 	dto.setPw(mr.getParameter("pw")); 
 	dto.setCtt(mr.getParameter("ctt"));
 	dto.setReg_date(new Timestamp(System.currentTimeMillis()));
 	dto.setReadcount(0);  
 	dto.setComm(0);
 	dto.setHidden_content(0);
	// 일반 파라미터는 그냥 request에서 getparameter 해도 됨
	// 파일을 꺼내올 때는 mr을 사용해야하니까 통일시킨 것.


	if(mr.getFilesystemName("img") != null) {// photo input 태그에 뭔가 담겨서 넘어왔다면
		// 새로 넘어온 파일의 이름을 dto 에 넣고
		System.out.println(mr.getFilesystemName("img"));
		dto.setImg(mr.getFilesystemName("img"));
		
		// 기존 파일은 지우기 (기존에 올린 파일이 있다면 지우기(디폴트가 아니라면 / null이 아니라면))
		
	} else { // photo input 태그로 사진 지정 안하고 그냥 넘어왔으면 
		// 기존에 DB에 저장되어있던 이름으로 다시 dto에 추가
		System.out.println(mr.getParameter("exPhoto"));
		// 수정할 때 DB상에 값이 없으면, form에 null 값이 전달되어서 -> "null" 문자열로 넘어옴
		if(mr.getParameter("exPhoto").equals("null") || mr.getParameter("exPhoto").equals("")) {
			dto.setImg(null); // 실제 null 을 넣어주기 (디폴트이미지 나오도록)
			// (DB에 만들때부터 default 값으로 디폴트 이미지를 넣어주는 것이 나음)
		} else {
			dto.setImg(mr.getParameter("exPhoto"));
		}
	}
 	
 
 	/* //덮어쓰기 방지 객체 : 중복이름으로 파일 저장시 파일 자동으로 이름 생성 
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
			f.delete(); */
		%>
			<script type="text/javascript">
				alert("이미지 파일이 아닙니다. 이미지 파일을 업로드해주세요.");
				history.go(-1);
			</script>		
 <%
 	
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