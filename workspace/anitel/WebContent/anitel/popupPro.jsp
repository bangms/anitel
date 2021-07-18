<%@page import="anitel.model.PetDAO"%>
<%@page import="anitel.model.BookingDAO"%> 
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
	String id = (String)session.getAttribute("sid");

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
	BookingDAO booking =BookingDAO.getInstance();
	PetDAO pet=PetDAO.getInstance();
	
	int result = -1;
	System.out.println(pop);
	if(pop.equals("1") || pop.equals("2") || pop.equals("3") || pop.equals("8") || pop.equals("9") || pop.equals("10")){
		// 일반회원 영역) 1 : 일반회원 - 반려동물 수정, 2 : 일반회원 - 회원탈퇴, 3 : 일반회원 - 내 정보 수정
		result = user.matchUserPw(id, pw);
		System.out.println("popupPro.jsp - 비밀번호 확인 결과 : " + result);
		// 비밀번호가 DB와 일치하면 1 출력, 불일치하면 -1 출력
	}else if(pop.equals("4") || pop.equals("5") || pop.equals("6") || pop.equals("7") || pop.equals("11") || pop.equals("12")) {
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
					window.location.href="main.jsp";
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
				opener.document.location="../anitel/anitel/userMypage/userModifyForm.jsp";
				self.close();
			</script>
<%		}
		if(pop.equals("4")){
			// 사업자회원 - 호텔정보 수정%>
			<script>
				opener.document.location="../anitel/memberMypage/memberHModifyForm.jsp";
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
					window.location.href="main.jsp";
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
			<script>
				opener.document.location="../anitel/memberMypage/memberModifyForm.jsp";
				self.close();
			</script>
<%		}
		if(pop.equals("8")){																			// 완료됨
			System.out.println("id : " + id + " / pop8(일반회원 - 반려동물정보삭제) 실행");
			// 일반회원 - 반려동물 정보삭제
			int pet_num=pet.getPetNum(id);
			int num = pet.deletePet(pet_num);
			if(num == 1){%>
				<script>
					alert("반려동물 정보 삭제가 완료되었습니다.");
					self.close();
					opener.document.location="main.jsp";
				</script>
<%			}else{%>
				<script>
					alert("오류가 발생했습니다. 다시 시도해주세요.");
					history.go(-1);
				</script>
<%			}
	}
		if(pop.equals("9")){																			// 완료됨
			System.out.println("id : " + id + " / pop9(일반회원 -반려동물 정보 수정) 실행");
			String pet_num = request.getParameter("pet_num");
			//일반회원 - 반려동물 정보 수정 %>
			<script>
				opener.document.location="../anitel/anitel/userMyPage/petinfoModifyForm.jsp?id=<%=id%>&pet_num=<%=pet_num%>";
				self.close();
			</script>
<%		}
		
		if(pop.equals("11")){ 
			// 사업자회원 - 객실 및 서비스 관리 %>
			<script type="text/javascript">
				opener.document.location="../anitel/anitel/memberMypage/memberRoomModifyForm.jsp";
				self.close();
			</script>
<%		}
		if(pop.equals("12")){ 
		// 사업자회원 - 호텔 예약 관리 %>
			<script type="text/javascript">
				opener.document.location="../anitel/anitel/memberMypage/memberBookingModifyForm.jsp";
				self.close();
			</script>
<%		} %>
<%	} %>
<body>

팝업 프로<br/>
팝업페이지 번호  : <%= pop %>

</body>
<%	} %>
</html>
