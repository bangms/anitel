<%@page import="anitel.model.RoomDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>호텔 객실 정보 수정 결과</title>
</head>
<%	request.setCharacterEncoding("UTF-8"); 
	String id = (String)session.getAttribute("sid");
	RoomDAO dao = RoomDAO.getInstance();
	int room_num = Integer.parseInt(request.getParameter("room_num"));
	
	String path = request.getRealPath("save"); 
	System.out.println("memberRoomModifyPro.jsp - 이미지저장경로 : " + path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	int result = -1;
	String sysName = mr.getFilesystemName("img");	// 업로드된 파일 이름
	if(mr.getFilesystemName("img")==null){
		// 이미지를 변경하지 않은 경우
		result = dao.modifyRoom(id, mr, room_num);
	}else if(mr.getFilesystemName("img")!=null){
		// 이미지를 변경한 경우
		result = dao.modifyRoom(id, mr, sysName, room_num);
	}
	System.out.println("memberRoomModifyPro.jsp - 객실 수정 결과 : " + result + "(1 : 수정 성공, -1 : 수정 실패)");
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("객실 정보가 수정되었습니다.");
			window.location.href="memberRoomModifyForm.jsp";
		</script>
<%	}else{%>
		<script>
			alert("객실정보 수정 실패. 다시 시도해주세요.");
			history.go(-1);
		</script>
<%	}%>
</body>
</html>
