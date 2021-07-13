<%@page import="anitel.model.UsersDAO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>팝업 프로</title>
</head>
<%	request.setCharacterEncoding("UTF-8");
	String pop = request.getParameter("pop");
	String pw = request.getParameter("user_pw");
	//String id = (String)session.getAttribute("sid");
	// String id = "java01";
	String id = "java01";
	
	System.out.println("popupPro.jsp");
	
	%>
	
<%	if(pw.equals(null) || pw.equals("")){ %>
		<script>
			alert("비밀번호가 입력되지 않았습니다.");
			history.go(-1);
		</script>
<%	}else{
	UsersDAO user = UsersDAO.getInstance();
	MemberDAO member = MemberDAO.getInstance();
	int result = -1;
	System.out.println(pop);
	if(pop.equals("1") || pop.equals("2") || pop.equals("3")){
		// 일반회원 영역) 1 : 일반회원 - 반려동물 수정, 2 : 일반회원 - 회원탈퇴, 3 : 일반회원 - 내 정보 수정
		result = user.matchUserPw(id, pw); 
		System.out.println("popupPro.jsp - 비밀번호 확인 결과 : " + result);
		// 비밀번호가 DB와 일치하면 1 출력, 불일치하면 -1 출력
	}else if(pop.equals("4") || pop.equals("5") || pop.equals("6") || pop.equals("7")){
		// 사업자회원 영역) 4 : 사업자회원 - 호텔정보 수정, 5 : 사업자회원 - 객실정보 수정, 6 : 사업자회원 - 회원탈퇴, 7 : 사업자회원 - 내 정보 수정
		result = member.matchMemberPw(id, pw); 
		System.out.println("popupPro.jsp - 비밀번호 확인 결과 : " + result);
		// 비밀번호가 DB와 일치하면 1 출력, 불일치하면 -1 출력
	}
	
	
	if(result != 1){ %>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
<%	}else{
		if(pop.equals("1")){
			// 일반회원 - 반려동물 수정
			
		}
		if(pop.equals("2")){
			// 일반회원 - 회원탈퇴
			int num = user.deleteUser(id, pw);
			if(num == 1){%>
				<script>
					alert("탈퇴 처리가 완료되었습니다.");
					self.close();
					window.location.href="/anitel/userLoginForm.jsp"; 									// main.jsp로 바꿔야됨
				</script>
<%			}else{%>
				<script>
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					history.go(-1);
				</script>
<%			}
		}
		if(pop.equals("3")){
			// 일반회원 - 내 정보 수정 %>
			<script>
				opener.document.location="/anitel/userMypage/userModifyForm.jsp?id=<%=id%>";
				self.close();
			</script>
<%		}
		if(pop.equals("4")){
			// 사업자회원 - 호텔정보 수정%>
			<script>
				opener.document.location="/anitel/memberMypage/memberHModifyForm.jsp?id=<%=id%>";
				self.close();
			</script>
<%		}
		if(pop.equals("5")){
			// 사업자회원 - 객실정보 수정
			
		}
		if(pop.equals("6")){
			// 사업자회원 - 회원탈퇴
			int num = member.deleteMember(id, pw);
			if(num == 1){%>
				<script>
					alert("탈퇴 처리가 완료되었습니다.");
					window.location.href="/anitel/userLoginForm.jsp"; 									// main.jsp로 바꿔야됨
				</script>
<%			}else{%>
				<script>
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					history.go(-1);
				</script>
<%			}
		}
		if(pop.equals("7")){ 
			// 사업자회원 - 내 정보 수정 %>
			<script type="text/javascript">
				opener.document.location="/anitel/memberMypage/memberModifyForm.jsp?id=<%=id%>";
				self.close();
			</script>
<%		}//8번 : 반려동물 삭제
}
%>
<body>

팝업 프로<br/>
팝업페이지 번호  : <%= pop %>

</body>
<%	} %>
</html>