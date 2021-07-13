<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사업자회원가입</title>
  <link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
  <link rel="stylesheet" href="style/init.css">	
</head>
<script type="text/javascript">
function check() {
	var inputs = document.inputForm; 
	if(!inputForm.id.value == "" || !inputForm.id.value) {
		alert("아이디를 입력하세요!");
		return;
	}	
	if(inputForm.member_pw.value == "" || !inputForm.member_pw.value) {
		alert("비밀번호를 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.member_name.value == "" || !inputForm.member_name.value) {
		alert("사업자 이름을 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.member_phone.value == "" || !inputForm.member_phone.value) {
		alert("연락처를 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.member_email.value == "" || !inputForm.member_email.value) {
		alert("이메일을 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.hotel_name.value == "" || !inputForm.hotel_name.value) {
		alert("호텔 이름을 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.hotel_owner.value == "" || !inputForm.hotel_owner.value) {
		alert("대표자 성명을 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.hotel_area.value == "" || !inputForm.hotel_area.value) {
		alert("호텔 주소를 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.hotel_phone.value == "" || !inputForm.hotel_phone.value) {
		alert("호텔 전화번호를 입력하세요!");
		return; // 메서드 강제 종료
	}
	if(inputForm.reg_num.value == "" || !inputForm.reg_num.value) {
		alert("사업자등록번호를 입력하세요!");
		return; // 메서드 강제 종료
	}
}
function confirmId(inputForm) { // inputForm <- this.form 객체 받음
	if(inputForm.id.value == "" || !inputForm.id.value) {
		alert("아이디를 입력하세요!");
		return; // 메서드 강제 종료
	}

	// 팝업
	var url = "confirmId.jsp?id=" + inputForm.id.value; 
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
			<button id="login" onclick="window.location='LoginForm.jsp'">로그인</button>
		</div>
	</div>	
	<div id="section">
		<h1 align="center">사업자회원가입</h1>
	
		<form action="singInMemberPro.jsp" method="post" name="inputForm" onsubmit="return check()">
			<h3> 사업자 회원 정보(필수입력)</h3>
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="id" placeholder="입력 후 중복 체크 해주세요." />
					</td>
					<td>
						<input type="button" value="중복체크" onclick="confirmId(this.form)"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="member_pw" />
					</td>
				</tr>
				<tr>
					<td>성명</td>
					<td>
						<input type="text" name="member_name" />
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
						<input type="text" name="member_phone" placeholder="-없이 숫자만 입력해주세요."/>
					</td>
				</tr>
				<tr>
					<td>E-mail</td>
					<td>
						<input type="text" name="member_email" /> 
					</td>
				</tr>
			</table>
			<h3> 호텔(사업자) 기본 정보(필수입력)</h3>
			<span></span>
			<table>
				<tr>
					<td>호텔 이름</td>
					<td>
						<input type="text" name="hotel_name" />
					</td>
				</tr>
				<tr>
					<td>대표자 성명</td>
					<td>
						<input type="text" name="hotel_owner" />
					</td>
				</tr>
				<tr>
					<td>호텔주소</td>
					<td>
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
						<input type="text" name="hotel_add" />
					</td>
				</tr>
				<tr>
					<td>호텔 전화번호</td>
					<td>
						<input type="text" name="hotel_phone" placeholder="-없이 숫자만 입력해주세요." />
					</td>
				</tr>
				<tr>
					<td>사업자 등록 번호</td>
					<td>
						<input type="text" name="reg_num" />
					</td>
				</tr>
				<tr>
					<td>호텔 소개<br />
						※ 메인 리스트에 노출되는 소개글입니다.
					</td>
					<td>
						<textarea rows="20" cols="60" name="hotel_intro"></textarea>
					</td>
				</tr>
				<tr>
					<td>호텔 수용 동물</td>
					<td>
						<select name="pet_type" id="pet_type" onChange="view(this.value)">
							<option value="1" selected >강아지</option>
							<option value="2">고양이</option>
							<option value="0">기타</option>
						</select>
						<input type="text" id="pet_etctype" class="hidden" name="pet_etctype" />
					</td>
				</tr>
				<tr>
					<td>호텔 편의시설</td>
					<td>
						<input type="checkbox" name="util_pool" value="1"/> 수영장
						<input type="checkbox" name="util_ground" value="1"/> 운동장
						<input type="checkbox" name="util_parking" value="1"/> 무료주차
					</td>
				</tr>
				<tr>
					<td>호텔 유료서비스</td>
					<td>
						<input type="checkbox" name="paid_bath" value="1"/> 목욕서비스
						<input type="checkbox" name="paid_beauty" value="1" /> 미용서비스
						<input type="checkbox" name="paid_medi" value="1"/> 동물병원
					</td>
				</tr>
			</table>
			<div class="exp_wrap">
				<p class="exp_detail_sub">세부 설명</p>
				<p class="exp_detail_con"> 호텔의 객실과 요금, 부가시설과 추가 서비스, 그리고 대표 이미지 및 소개 이미지는 가입 후 마이 페이지 - 호텔 관리에서 설정하실 수 있습니다.</p>
			</div>
			<input type="submit" value="가입하기" />
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