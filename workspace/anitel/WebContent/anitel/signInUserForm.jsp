<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원 회원가입폼</title>
 	<link rel="stylesheet" href="style/style.css">
	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/signup.css">
	<script src="js/jquery-3.1.1.min.js"></script>
 	<script type="text/javascript" src="js/valCheck.js"></script>
</head>
<%
	 String strReferer = request.getHeader("referer");
	 
	 if(strReferer == null){
	%>
	 <script language="javascript">
	  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
	  document.location.href="main.jsp";
	 </script>
	<%
	  return;
	 }
	%>
<body>
<div id="container">

	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
		</div>
	</div>	
	<div id="section">
		<form class="submitForm" action="signInUserPro.jsp" method="post" name="inputForm" onsubmit="return check(this)" style="margin-bottom: 50px;">
			<h3>회원정보 (필수입력)</h3>
			<div class="form__group field">
				<input type="text" id="id" class="form__field" placeholder="ID" name="id" />
				<label for="id" class="form__label">아이디 <span class="txt">*</span></label>
				<input type="button" class="confirmId" value="아이디중복체크" onclick="confirmId(this.form)" />
			</div>
			<div class="form__group field">
        		<input type="password" id="pw" class="form__field" placeholder="Password" name="user_pw"/>
        		<label for="pw" class="form__label">비밀번호 <span class="txt">*</span></label>
      		</div>
			<div class="form__group field">
        		<input type="text" id="member_name" class="form__field" placeholder="Name" name="user_name" />
        		<label for="member_name" class="form__label">이름 <span class="txt">*</span></label>
   		</div>
   		
   		<div class="form__group" style="display:flex;">
          <input type="text" id="tel" class="form__field" name="user_tel1" />
          <label for="tel" class="form__label">전화번호 <span class="txt">*</span></label>
          -
          <input type="text" class="form__field" name="user_tel2" />
          -
          <input type="text" class="form__field" name="user_tel3" /> 
      </div>
       
		 	<div class="form__group field">
				 <input type="text" id="email" class="form__field" placeholder="E-mail" name="user_email" />
				 <label for="email" class="form__label">E-mail <span class="txt">*</span></label>
		 	</div>	
				
			<h3>반려동물 정보(필수입력)</h3>
		
			<div class="form__group field">
        		<input type="text" id="pet_name" class="form__field" name="pet_name" />
        		<label for="pet_name" class="form__label">반려동물 이름 <span class="txt">*</span></label>
      		</div>
      	
      		<h3>반려동물 정보(선택사항)</h3>
	
      	  	<div class="form__group field" style="display:flex;">
      				<select name="pet_type" id="pet_type" onChange="view(this.value)">
						<option value="1" selected >강아지</option>
						<option value="2">고양이</option>
						<option value="0">기타</option>
					</select>
				<input type="text" id="pet_etctype" class="form__field hidden" name="pet_etctype" />
	        	<label for="pet_type" class="form__label">호텔 수용 동물<span class="txt">*</span></label>
	      	</div>
	      
         	<div class="form__group gender">
             	<p>반려동물 성별</p>
             	<input type="radio" name="pet_gender" id="female" value="0" />
             	<label for="female">암컷</label>
             	<input type="radio" name="pet_gender" id="male" value="1" />
             	<label for="male">수컷</label>
           </div>
           
           <div class="form__group gender">
             	<p>중성화 여부</p>
             	<input type="radio" name="pet_operation" id="op_yes" value="1" />
             	<label for="op_yes">예</label>
             	<input type="radio" name="pet_operation" id="op_no" value="0" />
             	<label for="op_no">아니오</label>
           </div>
          
          
          <div class="form__group age"style="margin-bottom: 50px;"> 
       	  		<label for="pet_age" class="form__label">반려동물 나이
       		 	<input type="text" id="pet_age" class="form__field" name="pet_age" />
       		 	<span class="txt"></span></label>
    	  </div>
    	  
    	  <div class="form__group pet_big" style="margin-bottom: 50px;">
              <p>대형동물 여부</p>
              <div class="check_wrap">
                <label for="pet_big" class="form__label">
                <input type="checkbox" id="pet_big" value="1" name="pet_big" />20kg 이상일 경우 체크해주세요 
                </label>
              </div>
          </div>
    	   
			<input type="submit" value="가입하기" />
			<input type="button" value="취소" onclick="window.location='main.jsp'" />
		</form>
   </div>
		<div id="footer">
	 		<img src="imgs/logo2.png" width=100px; height=50px;>
	 		<p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
	 		이용약관 | 취소정책 | 1:1문의 <br/>
			COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
 		</div>
 	</div>
 </body>
 <%-- 반려동물 종 선택 기타 입력란 나타내는 스크립트 --%>
 <script type="text/javascript">
function view(value){
	var pet_type_sel = document.getElementById('pet_type');
	var pet_type = pet_type_sel.options[pet_type_sel.selectedIndex].value;
	var input = document.getElementById('pet_etctype');
	if(pet_type == 0) {
		input.classList.replace('hidden', 'show');
	} else {
		input.classList.replace('show', 'hidden');
	}
}
</script>
<script type="text/javascript">
	//유효성검사
function check(frm){
		var a = $("input[name=user_tel1]").val();
		var b = $("input[name=user_tel2]").val();
		var c = $("input[name=user_tel3]").val();
		
		if(!checkExistData(frm.id.value, "아이디를") 
				|| !checkExistData(frm.user_pw.value, "비밀번호를") 
				|| !checkUserName(frm.user_name.value)
				/*|| !checkPhone(a+b+c)*/
				|| !checkEmail(frm.user_email.value)
				|| !checkUserName(frm.pet_name.value)
		) return false;

   return true;
 }

	//아이디 중복체크 
	function confirmId(inputForm) {
		if (inputForm.id.value == "" || !inputForm.id.value) {
			alert("아이디를 입력하세요");
			return;
		}
			var url = "confirmId.jsp?id=" + inputForm.id.value;
			open(url, "confirmId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
		}
	
</script>

</html>
