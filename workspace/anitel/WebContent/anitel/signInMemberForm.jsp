<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사업자회원가입</title>
 	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
 	<link rel="stylesheet" href="style/signup.css">	
 	<script type="text/javascript" src="js/search.js"></script>
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
<script type="text/javascript">
//유효성검사
function check(frm){
	if(!checkExistData(frm.id.value, "아이디를") 
			|| !checkExistData(frm.member_pw.value, "비밀번호를") 
			|| !checkUserName(frm.member_name.value)
			|| !checkEmail(frm.member_email.value)
			|| !checkExistData(frm.hotel_name.value, "호텔이름을") 
			|| !checkUserName(frm.hotel_owner.value)
			|| !checkExistData(frm.hotel_area.value, "지역을") 
			|| !checkExistData(frm.hotel_add.value, "상세주소를") 
			|| !checkExistData(frm.reg_num.value, "사업자 등록 번호를") 
			|| !checkExistData(frm.pet_type.value, "호텔 수용 동물") 
	) return false;

   return true;
 }
// 아이디 중복 여부 판단
function confirmId(inputForm) { // inputForm <- this.form 객체 받음
	if(inputForm.id.value == "" || !inputForm.id.value) {
		alert("아이디를 입력하세요!");
		return; // 메서드 강제 종료
	}
	// 팝업
	var url = "confirmId.jsp?id=" + inputForm.id.value; // confiemId.jsp?pika
	open(url, "confirmId",  "toolbar=no, location=no, status=no, menubar=no, scrollbars=no resizeable=no, width=300, height=200");
	
	
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
	
		<form class="submitForm" action="signInMemberPro.jsp" method="post" name="inputForm" onsubmit="return check(this)">
			<h3> 사업자 회원 정보(필수입력)</h3>
			
			<div class="form__group field">
				<input type="text" id="id" class="form__field" placeholder="ID" name="id" />
				<label for="id" class="form__label">아이디 <span class="txt">*</span></label>
				<input type="button" class="confirmId" value="아이디중복체크" onclick="confirmId(this.form)" />
			</div>
			<div class="form__group field">
        <input type="password" id="pw" class="form__field" placeholder="Password" name="member_pw" />
        <label for="pw" class="form__label">비밀번호 <span class="txt">*</span></label>
      </div>
			<div class="form__group field">
        <input type="text" id="member_name" class="form__field" placeholder="Name" name="member_name"/>
        <label for="member_name" class="form__label">이름 <span class="txt">*</span></label>
      </div>
			<div class="form__group" style="display:flex;">
         <input type="text" id="mem_tel" class="form__field" name="mem_tel1"  />
         <label for="mem_tel" class="form__label">전화번호 <span class="txt">*</span></label>
         -
         <input type="text" class="form__field" name="mem_tel2" />
         -
         <input type="text" class="form__field" name="mem_tel3" /> 
       </div>
			 <div class="form__group field">
				  <input type="text" id="email" class="form__field" placeholder="E-mail" name="member_email"  />
				  <label for="email" class="form__label">E-mail <span class="txt">*</span></label>
				</div>
			
			
			<h3> 호텔(사업자) 기본 정보(필수입력)</h3>
			<div class="form__group field">
        <input type="text" id="hotel_name" class="form__field" name="hotel_name"   />
        <label for="hotel_name" class="form__label">호텔 이름 <span class="txt">*</span></label>
      </div>
      <div class="form__group field">
        <input type="text" id="hotel_owner" class="form__field" name="hotel_owner"   />
        <label for="hotel_owner" class="form__label">대표자 이름<span class="txt">*</span></label>
      </div>
      <div class="form__group field" style="display:flex;">
      		<select name="hotel_area">
							<option value="서울">서울</option>
							<option value="부산">부산</option>
							<option value="대구">대구</option>
							<option value="인천">인천</option>
							<option value="경기">경기</option>
							<option value="광주">광주</option>
							<option value="대전">대전</option>
							<option value="울산">울산</option>
							<option value="경상도">경상도</option>
							<option value="전라도">전라도</option>
							<option value="제주도">제주도</option>
							<option value="충청도">충청도</option>
							<option value="강원도">강원도</option>
						</select>
        <input type="text" id="hotel_add" class="form__field" name="hotel_add"   />
        <label for="hotel_add" class="form__label">호텔 상세 주소<span class="txt">*</span></label>
      </div>
			<div class="form__group" style="display:flex;">
         <input type="text" id="hotel_tel" class="form__field" name="ho_tel1"  />
         <label for="hotel_tel" class="form__label">전화번호 <span class="txt">*</span></label>
         -
         <input type="text" class="form__field" name="ho_tel2" />
         -
         <input type="text" class="form__field" name="ho_tel3" /> 
      </div>
			<div class="form__group field">
        <input type="text" id="reg_num" class="form__field" name="reg_num" />
        <label for="reg_num" class="form__label">사업자 등록 번호 <span class="txt">*</span></label>
      </div>
      <hr>
      <div class="form__group field">
        <textarea id="hotel_intro" class="form__field" rows="20" cols="60" name="hotel_intro"></textarea>
        <label for="hotel_intro" class="form__label">호텔 소개<span class="txt">*</span><br /><p> 검색시 리스트에 노출되는 소개글 입니다. </p></label>
      </div>
			 <div class="form__group field" style="display:flex;">
      		<select name="pet_type" id="pet_type" onChange="view(this.value)">
						<option value="1" selected >강아지</option>
						<option value="2">고양이</option>
						<option value="0">기타</option>
					</select>
					<input type="text" id="pet_etctype" class="form__field hidden" name="pet_etctype" />
	        <label for="pet_type" class="form__label">호텔 수용 동물<span class="txt">*</span></label>
	      </div>
       <div class="check_wrap">
				<div class="form__group util" style="display:flex;">
           <p>호텔 편의시설</p>
             <label for="util_pool" class="form__label">
               <input type="checkbox" id="util_pool" value="1" name="util_pool" />수영장
             </label>
             <label for="util_ground" class="form__label">
                 <input type="checkbox" id="util_ground" value="1" name="util_ground" />운동장
             </label>
             <label for="util_parking" class="form__label">
                 <input type="checkbox" id="util_parking" value="1" name="util_parking" />무료주차
             </label>
         </div>
         <div class="form__group paid" style="display:flex;">
             <p>호텔 유료서비스</p>
             <label for="paid_bath" class="form__label">
                 <input type="checkbox" id="paid_bath" value="1" name="paid_bath" />목욕서비스
             </label>
             <label for="paid_beauty" class="form__label">
                 <input type="checkbox" id="paid_beauty" value="1" name="paid_beauty" />미용서비스
             </label>  
              <label for="paid_medi" class="form__label">
                 <input type="checkbox" id="paid_medi" value="1" name="paid_medi" />동물병원
             </label>  
          </div>
        </div>
			<div class="exp_wrap">
				<p class="exp_detail_sub">세부 설명</p>
				<p class="exp_detail_con"> 호텔의 객실과 요금, 부가시설과 추가 서비스, 그리고 대표 이미지 및 소개 이미지는 가입 후 마이 페이지 - 호텔 관리에서 설정하실 수 있습니다.</p>
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
