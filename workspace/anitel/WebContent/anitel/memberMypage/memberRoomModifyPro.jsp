<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="anitel.model.RoomDAO"%>
<%@page import="anitel.model.RoomDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(사업자회원) - 호텔 객실 추가</title>
</head>
<%	request.setCharacterEncoding("UTF-8"); %>

<%	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ %>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	RoomDAO dao = RoomDAO.getInstance();
	
	String path = request.getRealPath("save"); 
	System.out.println("memberRoomModifyPro.jsp - 이미지저장경로 : " + path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

	
	String sysName = mr.getFilesystemName("img");	// 업로드된 파일 이름
	System.out.println(sysName);
	String orgName = mr.getOriginalFileName("img");	// 파일 원본 이름
	System.out.println(orgName);
	String contentType = mr.getContentType("img");	// 파일 종류
	System.out.println(contentType);
	
	// 이미지파일이 아닌 경우 삭제
	String[] type = contentType.split("/");
	int img = 1;
	if(!(type[0]!=null && type[0].equals("image"))){	// 업로드된 파일이 image가 '아닐때'(!)
		System.out.println(type[0] + "타입은 유효하지 않아 삭제되었습니다.(image파일만 업로드 가능)");
		File f = mr.getFile("upload");					// java.io 파일 import
		f.delete();
	}
	int result = -2;
	if(img == 1){
		result = dao.insertRoom(id, mr, sysName);
		System.out.println("memberRoomModifyPro.jsp - 객실 추가 결과 : " + result + "(1 : 추가 성공, -1 : 추가 실패)");
	}
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("객실 정보가 추가되었습니다.");
			window.location.href="memberRoomModifyForm.jsp";
		</script>
<%	}else if(result == -2){ %>
		<script>
			alert("이미지 형식이 아닌 파일을 업로드하였습니다.");
			history.go(-1);
		</script>
<%	}else{%>
		<script>
			alert("객실정보 추가 실패. 다시 시도해주세요.");
			history.go(-1);
		</script>
<%	}%>
</body>
<%	} %>
</html>
