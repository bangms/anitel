<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(사업자회원) - 개인정보 수정결과</title>
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
	String pw_now = (String)request.getParameter("member_pw_now");	// 현재 사용중인 비밀번호
	String pw = (String)request.getParameter("member_pw");			// 변경할 비밀번호
	String pw2 = (String)request.getParameter("member_pw2");		// 변경할 비밀번호 재입력
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.memberModifyPw(id, pw_now, pw, pw2);
	System.out.println("memberModifyPwPro.jsp - 비밀번호 변경 결과 : " + result + "(1 : 변경 성공, 0 : 새 비밀번호간 불일치, -1 : 현재 비밀번호 불일치)");
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("비밀번호가 변경되었습니다.");
			window.location.href="memberMyPage.jsp";
		</script>
<%	}else if(result ==0){%>
		<script>
			alert("비밀번호 변경 실패. 새로 입력한 비밀번호가 서로 일치하지 않습니다.");
			history.go(-1);
		</script>
<%	}else if(result == -1){%>
		<script>
			alert("비밀번호 변경 실패. 비밀번호가 입력되지 않았거나 현재 비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
<%	} %>
</body>
<%	} %>
</html>
