<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="anitel.model.BoardDAO"%>
<%@page import="anitel.model.AdminDAO"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.RoomDTO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<head>
	<meta charset="UTF-8">
	<title>예약페이지</title>
	<link rel="stylesheet" href="style/style.css">
	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/reserve.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="js/reservejs.js"></script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	// 디테일에서 넘어오는 정보 받아오기 
	
	String memId = request.getParameter("memId");
	String room_num = request.getParameter("room_num");
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	String id = (String)session.getAttribute("sid");
		
	BookingDAO dao = BookingDAO.getInstance();
	MemberDTO hotel = new MemberDTO();
	hotel = dao.getHotelInfo(memId);
	
	UsersDTO userInfo = new UsersDTO();
	userInfo = dao.getReserveUserInfo(id);
	
	List petInfo = dao.getReservePetInfo(id);
	PetDTO pet = new PetDTO();
	
	RoomDTO room = new RoomDTO();
	room = dao.getRoomInfo(room_num);
	
	int day_fee = Integer.parseInt(room.getD_fee());
	
	Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(check_in);
	Date date2 = new SimpleDateFormat("yyyy-MM-dd").parse(check_out);
	long diffSec = (date2.getTime()-date1.getTime()) / 1000; //초 차이
  long diffDays = diffSec / (24*60*60); //일자수 차이
  
  int total_fee = day_fee * (int)diffDays;
  
  System.out.println(diffDays + "일 이용 시 총 가격 = " + total_fee);

%>
<body>
<div id="container">

	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
<%			if(id == null){ 
%>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
			
<%}else{ 
		BoardDAO board = BoardDAO.getInstance(); 
		int checkID = board.idCk(id);
		
		if(checkID == 1) { 
			if(session.getAttribute("sid").equals("admin")) { %><%-- 관리자 일 때 --%>
				<button id="mypage" onclick="window.location='adminMypage/adminUserForm.jsp'">마이페이지</button>
		<%} else { %>
			<button id="mypage" onclick="window.location='userMypage/userMyPage.jsp'">마이페이지</button>
		<%}
		}
		if(checkID == 2) { %><%-- 사업자 일 때 --%>
			<button id="mypage" onclick="window.location='memberMypage/memberMyPage.jsp'">마이페이지</button>
	<%}%>	
		<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
<%}%>

		</div>
	</div>	
	
	<div id="section">
		<div class="hotel_info">
			<div class="hotel_name"><%=hotel.getHotel_name() %></div>
			<div style="font-size: 0.9em;font-weight: 100;"><%=hotel.getHotel_add() %></div>
			<div class="date_wrap">
				<div class="date">
					<p class="tit">체크인</p>
					<span><%=check_in %></span>
				</div>
				<div class="date">
					<p class="tit">체크아웃</p>
					<span><%=check_out %></span>
				</div>
			</div>
		</div>
		
		<!-- 지도 -->
			<div class="map" id="map"> 
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85cb70f384f9e8ef51db5fd63fe96989&libraries=services"></script>
				<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(37.565577,126.978082), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
				
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('<%=hotel.getHotel_add()%>', function(result, status) {
					
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
				
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=hotel.getHotel_name()%></div>'
				        });
				        infowindow.open(map, marker);
				
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});    
				</script>
			</div>
		
		
	
		<form method="post" id="reserveForm" name="reserveForm">
			<input type="hidden" name="in" value="<%=check_in %>" />
			<input type="hidden" name="out" value="<%=check_out %>" /> 
			<input type="hidden" name="room_num" value="<%=room_num %>" />
			<input type="hidden" name="id" value="<%=id %>" />
			<input type="hidden" name="total_fee" value="<%= total_fee %>" />
			
			<div class="userInfo">예약자정보
				<input type="checkbox" name="user_info" /> <span>가입자와 동일</span>
			</div>
			<p style="font-weight:100; font-size:0.8em; margin-bottom:30px;">* 는 필수 입력 사항 입니다!</p>
			<div class="group">
				<label for="user_name">성함<span class="red">*</span></label>
				<input type="text" name="user_name" placeholder="내용을 입력해주세요" />
			</div>
			
			<div class="group">
				<label for="user_email">이메일<span class="red">*</span></label>
				<input type="text" name="user_email" placeholder="내용을 입력해주세요" />
			</div>
	
			<div class="group">
				<label for="user_phone">전화번호<span class="red">*</span></label>
				<input type="text" name="user_phone" placeholder="내용을 입력해주세요" />
			</div>		
			
			<%-- 반려동물은 id에 등록되어 있는 아이들만 가능하게 --%>
			<div class="group">
				<label for="user_name">반려동물 이름<span class="red">*</span></label>
				<select name="pet_num" id="pet">
					<option>반려동물 선택</option>
					<%for(int i = 0; i < petInfo.size(); i++){ 
						pet = (PetDTO)petInfo.get(i);
					%>
					<option value="<%=pet.getPet_num()%>"><%=pet.getPet_name() %></option>
					<%}%>
				</select>
			</div>
			
			
			<script type="text/javascript">
				$("input[name=user_info]").change(function(){
		        if($(this).is(":checked")){
		        	console.log("체크박스 체크했음!");
		        	$("input[name=user_name]").val('<%=userInfo.getUser_name()%>');
		        	$("input[name=user_email]").val('<%=userInfo.getUser_email()%>');
		        	$("input[name=user_phone]").val('<%=userInfo.getUser_phone()%>');
		          $("#pet").val('<%=pet.getPet_num()%>')
		        }else{
	            console.log("체크박스 체크 해제!");
	            $("input[name=user_name]").val('');
		        	$("input[name=user_email]").val('');
		        	$("input[name=user_phone]").val('');
		        }
		    });
			</script>
	
			
			<div class="group">
				<label for="pet_type" class="form__label">호텔 수용 동물</label>
				<select name="pet_type" id="pet_type">
					<option id="dog" value="0" >강아지</option>
					<option id="cat" value="1">고양이</option>
					<option id="etc" value="2">기타</option>
				</select>
			</div>
			
			<div class="group">
				<label id="pet_etctype" class="hidden"> 기타동물 입력
					<input type="text" class="form__field" name="pet_etctype" />
				</label>
			</div>
			
			<div class="group gender">
				<p class="sub">반려동물 성별 </p>
				<div class="input_wrap">
			    <label for="male" class="form__label"> 수컷
			        <input type="radio" id="male" value="1" name="pet_gender" /> 
			    </label>
			    <label for="female" class="form__label">암컷
			        <input type="radio" id="female" value="0" name="pet_gender" />  
			    </label>
			  </div> 
			</div>
			
			<div class="group">
				<input type="text" name="pet_age" id="pet_age"/>
				<label for="pet_age">반려동물 나이</label>
			</div>
			
			<div class="group">
				<label for="pet_big">대형견 여부</label>
				<input type="checkbox" name="pet_big" id="pet_big" value="1" />
			</div>
			
			<div class="group">
				<p class="sub">중성화 여부</p>
				<input type="radio" id="N" name="pet_operation" value="0"/>
				<label for="N" style="font-weight:100">아니오</label>
				<input type="radio" id="Y" name="pet_operation" value="1"/>
				<label for="Y" style="font-weight:100">예</label>
			</div>
			
			<div class="group paid">
				<p>유료 서비스<span style="font-size:0.7em; font-weight:100;margin-left:10px;margin-bottom:20px;">유료서비스 가격은 호텔에 문의하세요.</span></p>
				<input id="paid_bath" type="checkbox" name="paid_bath" value="1"/>
				<label for="paid_bath">목욕서비스</label>
				<input id="paid_beauty" type="checkbox" name="paid_beauty" value="1"/>
				<label for="paid_beauty">미용서비스</label>
				<input id="paid_medi" type="checkbox" name="paid_medi"  value="1"/>
				<label for="paid_medi">동물병원</label>
			</div>
			
			<div class="request">
				<p>요청사항<span style="font-size:0.7em; font-weight:100;margin-left:10px;margin-bottom:20px;">요청사항은 호텔에 전달됩니다. 요청사항은 반드시 제공되는 것이 아님을 알려드립니다.</span></p>
				<textarea name="requests" cols="50" rows="20" placeholder="내용을 입력해주세요."></textarea>
			</div>
 
		</form>
		
		<%-- 객실 세부 정보 --%>
		<div class="room_info_wrap">
			<div class="sub">객실세부정보</div>
			<div class="util">
				<h4>편의시설</h4>
<%	   	 if(hotel.getUtil_pool() == 1) { %> 
						<div class="icon">
							<img src = "imgs/swim.png" />
							<span>수영장</span>
						</div>
<%				} %>
<%				if(hotel.getUtil_ground() == 1) { %>
						<div class="icon">
							<img src = "imgs/park.png" />
							<span>운동장</span>
						</div>
<%				} %>
<%				if(hotel.getUtil_parking() == 1) { %>
						<div class="icon">
							<img src = "imgs/parking.png" />							
							<span>무료주차</span>
						</div>
<%				} %>
			</div>
			<div class="img_wrap">
     		<img src="/anitel/save/<%=room.getImg()%>" class="room_img" alt="room_img"/>
     	</div>
     	<p><%=room.getName() %></p>
<%		if (room.getPet_big() == 1) { %> 
     		<p>대형동물 전용방</p>
<%		} %>
		</div>
		
		<%-- 의미없는 정책과 예약 약관 --%>
		<div class="cancel_wrap terms">
			<div class="sub">취소정책</div>
			<p> 호텔은 <span>체크인 24시간 이상 전에 취소</span>해야 합니다. 이후 환불 규정은 <a href="board/list.jsp?categ=0"> 공지사항 </a>을 참고해주세요.</p>
			<input type="checkbox" id="cancel_agree" />
			<label for="cancel_agree">동의함</label>
		</div>
		<div class="cancel_wrap terms">
			<div class="sub">예약약관</div>
			<p>저희 <a href="#">이용약관</a>을 읽었고 동의하시는 것으로 간주됩니다.</p>
			<input type="checkbox" id="reserve_agree" />
			<label for="reserve_agree">동의함</label> 
		</div>
		
		<%-- 전체 결제 금액 표시 --%>
		<div class="total_fee">
			<p><strong>결제할 금액</strong> <%=total_fee %>원</p>
			<button id="paymentBtn" onclick="submitForm(this)">결  제</button>
		</div>
	</div>
	<div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
     	<p>
			평일 10:00 - 17:00 | anitel@anitel.com <br /> <span id="info_text_btn">이용약관 </span> | <span id="tos_text_btn">취소정책
			</span> | <span id="info_text_btn"><a href="../board/list.jsp?categ=1" style="color:#fff;">1:1문의 </a></span><br> COPYRIGHT 콩콩이 ALLRIGHT Reserved.
		</p>
    </div>
</div>	
</body>
<script type="text/javascript">
function submitForm() {
	var cancel_agree = document.getElementById('cancel_agree').checked;
	var reserve_agree = document.getElementById('reserve_agree').checked;
	if(cancel_agree && reserve_agree) {
		document.reserveForm.action = "payment.jsp";
		document.reserveForm.submit();
	} else {
		alert("동의해주세요!");
		return false;
	}
	
}
</script>
</html>