<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원 회원가입폼</title>
  	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
  	<link rel="stylesheet" href="style/init.css">	
  	<link rel="stylesheet" href="style/signup.css">
</head>
<script type="text/javascript">
 
	// 유효성 검사 
	function check(){
		var inputForm = document.inputForm;
		var regExp = /\s/g;
		var nameReg = /^[가-힣ㄱ-ㅎㅏ-ㅣ]{1,10}$/g;
		var idReg = /^[a-z0-9]{6,15}$/g;
		var pet_ageReg = /^[0-9]*$/;
		var user_phoneReg = /^[0-9]*$/;
		var pnameReg = /^[가-힣ㄱ-ㅎㅏ-ㅣ]{1,10}$/g;
		
		if(!inputForm.id.value){
			alert("아이디가 입력되지 않았습니다.");
			return false;
		}
		
		if(!idReg.test(inputForm.id.value) || regExp.test(inputForm.id.value)){
			alert("아이디는 6~16자 사이의 영문 소문자+숫자만 가능합니다.");
			return false;
		}
		
		if(!inputForm.user_pw.value){
			alert("비밀번호가 입력되지 않았습니다.");
			return false;
		}
		if(!inputForm.user_name.value){
			alert("이름이 입력되지 않았습니다.");
			return false;
		}
		
		if(!nameReg.test(inputForm.user_name.value)){
			alert("이름은 2~10자 사이의 한글만 가능합니다.");
			return false;
		}

		if(!inputForm.user_tel.value || !inputForm.user_tel1.value || !inputForm.user_tel2.value || !inputForm.user_tel3.value){
			alert("연락처가 입력되지 않았습니다.");
			return false;
		}
		
		if(!user_phoneReg.test(inputForm.user_tel1.value)){
			alert("핸드폰 번호는 숫자만 가능합니다.");
			return false;
		}
		if(!user_phoneReg.test(inputForm.user_tel2.value)){
			alert("핸드폰 번호는 숫자만 가능합니다.");
			return false;
		}
		if(!user_phoneReg.test(inputForm.user_tel3.value)){
			alert("핸드폰 번호는 숫자만 가능합니다.");
			return false;
		}
		
		if(!inputForm.user_email.value){
			alert("이메일이 입력되지 않았습니다.");
			return false;
		}
		
		if(!inputForm.pet_name.value){
			alert("반려동물 이름이 입력되지 않았습니다.");
			return false;
		}
		
		if(!pnameReg.test(inputForm.pet_name.value)){
			alert("반려동물 이름은 2~10자 사이의 한글만 가능합니다.");
			return false;
		}
		
		if(!pet_ageReg.test(inputForm.pet_age.value)){
			alert("반려동물 나이는 숫자만 가능합니다.");
			return false;
		}
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
		<form class="submitForm" action="signInUserPro.jsp" method="post" name="inputForm" onsubmit="return check()" style="margin-bottom: 50px;">
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
         		<input type="text" id="user_tel" class="form__field" name="user_tel1" />
         		<label for="user_tel" class="form__label">전화번호 <span class="txt">*</span></label>
         		 -
         		<input type="text" class="form__field" name="user_tel2"/>
        		 -
         		<input type="text" class="form__field" name="user_tel3"/> 
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

</html>
