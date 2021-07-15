
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사업자 login Pro</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto"); 
		
		// 쿠키 체크 : loginform을 안타고 main에 바로 날라왔을 때는 getparameter는 form에서 올 경우에만 
		// 위 파라미터에서 값을 꺼내고 없기 때문에 다시 쿠키에서 id, pw, auto를 꺼내서 채워주기
		Cookie[] coos = request.getCookies();
		if(coos != null) {
			for(Cookie c : coos) {
				if(c.getName().equals("autoId")) { id = c.getValue(); }
				if(c.getName().equals("autoPw")) { pw = c.getValue(); }
				if(c.getName().equals("autoCh")) { auto = c.getValue(); }
			}
		}
		System.out.println("id : " + id);
		System.out.println("pw : " + pw);
		System.out.println("auto : " + auto);
	
		MemberDAO dao = MemberDAO.getInstance(); 
		// 쿠키에서 준 id, pw 주고 다시 한번 체크
		boolean res = dao.idPwCheck(id, pw);
		
		if(res) {
			if(auto != null) { // 자동 로그인 체크가 된 상태
				// 원래 있었던 경우라면 다시 새로 만들어줌 (갱신해주는 개념) (age 연장)
				Cookie c1 = new Cookie("autoId", id);
				Cookie c2 = new Cookie("autoPw", pw);
				Cookie c3 = new Cookie("autoCh", auto);
				// 3개 저장하는 이유 
				// 쿠키에 id, pw 다 저장 해놓고
				// 다음에 들어왔을 때 미리 쿠키에서 id,pw 있는지 확인해서
				// 로그인 처리 하고 form 안거치고 쿠키를 통해서 pro로 바로 넘어갈 것
				// 쿠키를 통해서 세션만들고 어쩌구 저쩌구 
				// 기본 로그인 처리는 세션으로 하면 되고 // 자동 로그인은 세션 + 쿠키 까지
				c1.setMaxAge(60*60*24); // 하루
				c2.setMaxAge(60*60*24);  // 쿠키 기간 갱신(쿠키가 있는데 또 들어왔을경우 유효기간 연장)
				c3.setMaxAge(60*60*24); 
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
			}
			// 자동로그인 처리
			session.setAttribute("sid", id);
			response.sendRedirect("main.jsp"); // main 으로 이동 !
		} else { %>
			<script type="text/javascript">
				alert("ID 또는 PASSWORD 가 일치하지 않습니다. 다시 시도해주세요.");
				history.go(-1); // 다시 form 페이지(이전페이지)로 이동시킴
			</script>
	<% } %>
</body>
</html>