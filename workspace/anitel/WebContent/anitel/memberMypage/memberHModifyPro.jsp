<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="anitel.model.MemberDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(사업자회원) - 호텔정보 수정 결과</title>
</head>
<%	request.setCharacterEncoding("UTF-8"); %>

<%	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ %>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";;
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	MemberDAO dao = MemberDAO.getInstance();
	
	String path = request.getRealPath("save"); 
	System.out.println("memberRoomModifyPro.jsp - 이미지저장경로 : " + path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	String sysName = mr.getFilesystemName("hotel_img");	// 업로드된 파일 이름
	System.out.println("sysName : " + sysName);
	String orgName = mr.getOriginalFileName("hotel_img");	// 파일 원본 이름
	System.out.println("orgName : " + orgName);
	String contentType = mr.getContentType("hotel_img");	// 파일 종류
	System.out.println("contentType : " + contentType);
	
	// 이미지파일이 아닌 경우 삭제
	String[] type = contentType.split("/");
	int img = 1;
	if(!(type[0]!=null && type[0].equals("image"))){	// 업로드된 파일이 image가 '아닐때'(!)
		System.out.println(type[0] + "타입은 유효하지 않아 삭제되었습니다.(image파일만 업로드 가능)");
		File f = mr.getFile("upload");					// java.io 파일 import
		f.delete();
		img = -1;
	}
	int result = -2;
	if(img == 1){
		result = dao.memberHModify(id, mr, sysName);  
		System.out.println("memberHModifyPro.jsp - 호텔정보 수정 결과 : " + result + "(1 : 수정 성공, -1 : 수정 실패)");
	}
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("호텔 정보가 수정되었습니다.");
			window.location.href="memberHInfo.jsp";
		</script>
<%	}else if(result == -2){ %>
		<script>
			alert("이미지 형식이 아닌 파일을 업로드하였습니다.");
			history.go(-1);
		</script>
<%	}else{%>
		<script>
			alert("호텔정보 수정 실패. 다시 시도해주세요.");
			history.go(-1);
		</script>
<%	}%>
</body>
<%	} %>
</html>
