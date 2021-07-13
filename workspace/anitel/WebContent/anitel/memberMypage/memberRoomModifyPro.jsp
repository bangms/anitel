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
	if(session.getAttribute("sid")!=null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	//String id = (String)session.getAttribute("sid");
	String id = "global";													// 테스트용 : 개발 끝나고 지워버려야댐
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
	
	
	int result = dao.insertRoom(id, mr, sysName);

	System.out.println("memberRoomModifyPro.jsp - 객실 추가 결과 : " + result + "(1 : 추가 성공, -1 : 추가 실패)");
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("객실 정보가 추가되었습니다.");
			window.location.href="/anitel/memberMypage/memberRoomModifyForm.jsp";
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
