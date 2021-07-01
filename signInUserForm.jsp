<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원 회원가입폼</title>
		<link rel="stylesheet" href="../style/style.css">
		<link rel="stylesheet" href="../style/reset.css">
		<link rel="stylesheet" href="../style/init.css">
	
	<script>
	function confirmId(inputForm) {
		if (inputForm.id.value == "" || !inputForm.id.value) {
			alert("아이디를 입력하세요");
			return;
			}
			var url = "confirmId.jsp?id=" + inputForm.id.value;
			open(url, "confirmId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
		}
	</script>
</head>
<div id="container">
	<div id="header">
		<div id="logo">
			<img src="imgs/logo.jpg" width="200px" height="100px">
		</div>
		<div id="button">
			<button id="notice">공지사항</button>
			<button id="signin">회원가입</button>
			<button id="login">로그인</button>
		</div>
	</div>	
	<div id="jb-content">
    <h1 align="center"> 회원가입 </h1>
	<form action="signInUserPro.jsp" method="post" name="inputForm" onsubmit="return check()">
		<h3>회원정보 (필수입력)</h3>
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="id" placeholder="입력 후 중복 체크해주세요" /> 
				</td>
				<td>
					<input type="button" value="중복체크" onclick="confirmId(this.form)" />
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="user_pw" /> 
				</td>
			</tr>
			<tr>
				<td>성명</td>
				<td>
					<input type="text" name="user_name" /> 
				</td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>
					<input type="text" name="user_phone" /> 
				</td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td>
					<input type="text" name="user_email" /> 
				</td>
			</tr>
		</table>
		<br />
		
		<h3>반려동물 정보(필수입력)</h3>
		<table>
			<tr>
				<td>반려동물이름</td>
				<td>
					<input type="text" name="pet_name" /> 
				</td>
			</tr>
		</table>
		<br />
 
	
		<h3>반려동물 정보(선택사항)</h3>
		<table>
			<tr>
				<td>반려동물 종</td>
				<td>
					  <select name="pet_type">  
                        <option value ="1">강아지</option>
		                <option value ="2">고양이</option>
		                <option value ="0">기타</option>
                   </select>
				</td>
			</tr>
			 <tr> 
			 	<td>반려동물 성별</td>
               <td> 
                   <input type="radio" name='pet_gender' value="1"/> 수컷 
                   <input type="radio" name='pet_gender' value="0"/> 암컷     
              </td>
           </tr> 
           <tr>
				<td>중성화여부</td>
				  <td>
                    <input type="radio" name="pet_operation" value="1"> 예 
                    <input type="radio" name="pet_operation" value="0"> 아니오
               	</td> 
			</tr>
			<tr>
				<td>반려동물 나이</td>
				<td>
					<input type="text" name="pet_age" /> 
				</td>
			</tr>
			 <tr>
				<td>대형동물 여부</td>
				  <td>
                    <input type="radio" name="pet_big" value="1"> 20kg 이상 경우 체크해주세요 
               	</td> 
			</tr>  
			<tr>
			<td colspan="2" align="center"> 
			<input type="submit" value="가입하기" />
			</td>
			</tr>
		</table>
	</form>
	
		<div id="footer">
			 <img src="imgs/logo2.png" width=100px; height=50px;>
			 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
			 이용약관 | 취소정책 | 1:1문의 <br/>
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
			</div>
  </div>
    </div>
 
</body>
</html>