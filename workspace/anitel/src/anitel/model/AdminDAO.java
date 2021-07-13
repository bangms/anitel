package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {
	
	// 싱글턴
	private static AdminDAO instance = new AdminDAO();
	private AdminDAO() {}
	public static AdminDAO getInstance() { return instance; }
	
	// 커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
// ********** 회원관리  관련 메서드 *************
	
	// 전체 회원 리스트 가져오는 메서드
	public List getUserList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List userList = null;
		
		try {
			conn = getConnection();
			String sql = "select id,user_name,user_phone,user_email,r from (select id,user_name,user_phone,user_email,rownum r from (select id,user_name,user_phone,user_email from users order by id)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userList = new ArrayList();
				do {
					UsersDTO user = new UsersDTO();
					user.setId(rs.getString("id"));
					user.setUser_name(rs.getString("user_name"));
					user.setUser_phone(rs.getString("user_phone"));
					user.setUser_email(rs.getString("user_email"));
					userList.add(user);					
				}while(rs.next());
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return userList;
	} // getUserList()
	
	// 전체 회원 리스트의 수를 가져오는 메서드
	public int getUserCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from users";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return count;
	}
	
	// 검색 된 회원 리스트의 수를 가져오는 메서드
	public int getUserSearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from users where " + sel + " like '%" + search + "%'";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return count;
	} //getUserSearchCount()
	
	// 검색 된 회원 리스트를 가져오는 메서드
	public List getUserSearch(int start, int end, String sel, String search) {
		List userList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select id,user_name,user_phone,user_email,r from (select id,user_name,user_phone,user_email,rownum r from (select id,user_name,user_phone,user_email from users where " +sel+ " like '%" + search+ "%' order by id)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userList = new ArrayList();
				do {
					UsersDTO user = new UsersDTO();
					user.setId(rs.getString("id"));
					user.setUser_name(rs.getString("user_name"));
					user.setUser_phone(rs.getString("user_phone"));
					user.setUser_email(rs.getString("user_email"));
					userList.add(user);					
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}	
		return userList;
	} //getUserSearch()
	
	// 회원 삭제 메서드
	public int deleteUser(String id) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();			
			String sql = "delete from users where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}		
		return result;
	}
	
// ********** 예약관리 관련 메서드 *************
	
	// 호텔예약관리 리스트 가져오는 메서드	
	public List getBookingList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List bookingList = null;
		
		try {
			conn = getConnection();
			String sql = "select booking_num, hotel_name, name, booking_time, check_in, user_name, user_phone, pet_name, requests, payment, pet_num, r from (select booking_num, hotel_name, name, booking_time, check_in, user_name, user_phone, pet_name, requests, payment, pet_num, rownum r from (select B.booking_num, M.hotel_name, R.name, B.Booking_Time, B.check_in, B.user_name, B.user_phone, P.pet_name, B.requests, B.payment, P.pet_num from Booking B, room R, member M, pet P where R.room_num = B.room_num AND R.id = M.id AND P.pet_num = B.pet_num order by M.hotel_name)) where r>= ? and r <= ? order by booking_time desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bookingList = new ArrayList();
				do {
					BKListDTO hotel = new BKListDTO();
					
					hotel.setBooking_num(rs.getInt("booking_num"));
					hotel.setHotel_name(rs.getString("hotel_name"));
					hotel.setName(rs.getString("name"));
					hotel.setBooking_time(rs.getTimestamp("booking_time"));
					hotel.setCheck_in(rs.getTimestamp("check_in"));
					hotel.setUser_name(rs.getString("user_name"));
					hotel.setUser_phone(rs.getString("user_phone"));
					hotel.setPet_name(rs.getString("pet_name"));
					hotel.setRequests(rs.getString("requests"));
					hotel.setPayment(rs.getInt("payment"));
					hotel.setPet_num(rs.getInt("pet_num"));
									
					bookingList.add(hotel);
				}while(rs.next());
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return bookingList;
	} // getBookingList()
	
	// 호텔 예약관리 리스트의 수를 가져오는 메서드
	public int getBookingCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from Booking B, room R, member M, pet P where R.room_num = B.room_num AND R.id = M.id AND P.pet_num = B.pet_num";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();			
			if(rs.next() ) {
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}		
		return count;
	} //getBookingCount()
	
	// 호텔 예약관리 검색 된 리스트의 수를 가져오는 메서드
	public int getBookingSearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from Booking B, room R, member M, pet P where B." + sel + " like '%" + search + "%' and R.room_num = B.room_num AND R.id = M.id AND P.pet_num = B.pet_num";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return count;
	} //getBookingSearchCount()
	
	// 호텔예약관리 검색 된 예약 리스트 가져오는 메서드
	public List getBookingSearch(int start, int end, String sel, String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List bookingList = null;
		
		try {
			conn = getConnection();
			String sql ="select booking_num, hotel_name, name, booking_time, check_in, user_name, user_phone, pet_name, requests, payment, pet_num, r from (select booking_num, hotel_name, name, booking_time, check_in, user_name, user_phone, pet_name, requests, payment, pet_num, rownum r from (select B.booking_num, M.hotel_name, R.name, B.Booking_Time, B.check_in, B.user_name, B.user_phone, P.pet_name, B.requests, B.payment, P.pet_num from Booking B, room R, member M, pet P where R.room_num = B.room_num AND R.id = M.id AND P.pet_num = B.pet_num and B." +sel+ " like '%" +search+ "%' order by M.hotel_name)) where r>= ? and r <= ? order by booking_time desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bookingList = new ArrayList();
				do {
					BKListDTO hotel = new BKListDTO();
					
					hotel.setBooking_num(rs.getInt("booking_num"));
					hotel.setHotel_name(rs.getString("hotel_name"));
					hotel.setName(rs.getString("name"));
					hotel.setBooking_time(rs.getTimestamp("booking_time"));
					hotel.setCheck_in(rs.getTimestamp("check_in"));
					hotel.setUser_name(rs.getString("user_name"));
					hotel.setUser_phone(rs.getString("user_phone"));
					hotel.setPet_name(rs.getString("pet_name"));
					hotel.setRequests(rs.getString("requests"));
					hotel.setPayment(rs.getInt("payment"));
					hotel.setPet_num(rs.getInt("pet_num"));
									
					bookingList.add(hotel);
				}while(rs.next());		
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return bookingList;
	} // getBookingSearch()
	
	// 호텔예약관리 예약 취소시키는 메서드
	public int deleteReserve(String num) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();			
			String sql = "update booking set booking_status=1, payment=2 where booking_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			result = pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}		
		return result;
	} //deleteReserve()
	
	// 동물정보 - 이름 클릭 시 동물 정보 가져오는 메서드(adminReserveAnimalInfo 팝업창)
	public PetDTO getPetInfo(String num) {		
		PetDTO pet = new PetDTO();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	      
		try {
			conn = getConnection();
			String sql = "Select * from pet where pet_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pet.setPet_name(rs.getString("pet_name"));
				pet.setPet_type(rs.getInt("pet_type"));
				pet.setPet_etctype(rs.getString("pet_etctype"));
				pet.setPet_gender(rs.getInt("pet_gender"));
				pet.setPet_operation(rs.getInt("pet_operation"));
				pet.setPet_age(rs.getString("pet_age"));
				pet.setPet_big(rs.getInt("pet_big"));   
			}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}
			return pet;      
	} //getPetInfo()
	
	// 세부.추가요청사항 - 요청사항 있을 때 클릭 시 요청사항 가져오는 메서드
	public BookingDTO getAddInfo(String num) {
		BookingDTO add = new BookingDTO();
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	      
		try {
			conn = getConnection();
			String sql = "select B.requests, B.paid_bath, B.paid_beauty, B.paid_medi from booking B, pet P where P.pet_num = B.pet_num and P.pet_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				add.setRequests(rs.getString("requests"));
				add.setPaid_bath(rs.getInt("paid_bath"));
				add.setPaid_beauty(rs.getInt("paid_beauty"));
				add.setPaid_medi(rs.getInt("paid_medi"));
			}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}	      
			return add;
	}//getAddInfo()
		
// ********** 1:1문의 관련 메서드 *************
	
	// 1:1문의  일반 회원 QnAList 가져오는 메서드
	public List getUserQnAList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List usQnaList = null;
		
		try {
			conn = getConnection();
			String sql = "select reg_date,id,subject,reply_date,comm,r from (select reg_date, id, subject, reply_date, comm, rownum r from (select B.reg_date,B.id,B.subject,B.reply_date,B.comm from board B, users U where B.id = U.id and B.categ = 1 order by B.reg_date desc)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				usQnaList = new ArrayList();
				do {
					BoardDTO user = new BoardDTO();
					user.setReg_date(rs.getTimestamp("reg_date"));
					user.setId(rs.getString("id"));
					user.setSubject(rs.getString("subject"));
					user.setReply_date(rs.getTimestamp("reply_date"));
					user.setComm(rs.getInt("comm"));
					usQnaList.add(user);					
				}while(rs.next());
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return usQnaList;
	} // getUserQnAList()
	
	// 1:1문의  일반 회원 QnAList 의 수를 가져오는 메서드
	public int getUserQnACount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from board B, users U where categ=1 and B.id = U.id";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return count;
	} //getUserQnACount()
	
	// 1:1문의 검색 된 일반회원 리스트의 수를 가져오는 메서드
	public int getUserQnASearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from board B,users U where B." + sel + " like '%" + search + "%' AND categ = 1 and B.id = U.id";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return count;
	} //getUserQnASearchCount()
	
	// 1:1문의 검색 된 일반회원 리스트 가져오는 메서드
	public List getUserQnASearch(int start, int end, String sel, String search) {
		List usQnaList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select reg_date,id,subject,reply_date,comm,r from (select reg_date, id, subject, reply_date, comm, rownum r from (select B.reg_date,B.id,B.subject,B.reply_date,B.comm from board B, users U where B.id = U.id and B.categ = 1 and B." +sel+ " like '%" +search+ "%' order by B.reg_date desc)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				usQnaList = new ArrayList();
				do {
					BoardDTO user = new BoardDTO();
					user.setReg_date(rs.getTimestamp("reg_date"));
					user.setId(rs.getString("id"));
					user.setSubject(rs.getString("subject"));
					user.setReply_date(rs.getTimestamp("reply_date"));
					user.setComm(rs.getInt("comm"));
					usQnaList.add(user);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}	
		return usQnaList;
	} //getUserQnASearch()
	
	// 1:1문의 일반회원 문의글 삭제 메서드
	public int deleteUserQna(String id) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();			
			String sql = "delete from board where exists(select * from users where board.id = users.id AND board.categ=1 and board.id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}		
		return result;
	}
		
	// 1:1문의  사업자 회원 QnAList 가져오는 메서드
	public List getMemberQnAList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List mbQnaList = null;
		
		try {
			conn = getConnection();
			String sql = "select reg_date,id,subject,reply_date,comm,r from (select reg_date, id, subject, reply_date, comm, rownum r from (select B.reg_date,B.id,B.subject,B.reply_date,B.comm from board B, member M where B.id = M.id and B.categ = 1 order by B.reg_date desc)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mbQnaList = new ArrayList();
				do {
					BoardDTO user = new BoardDTO();
					user.setReg_date(rs.getTimestamp("reg_date"));
					user.setId(rs.getString("id"));
					user.setSubject(rs.getString("subject"));
					user.setReply_date(rs.getTimestamp("reply_date"));
					user.setComm(rs.getInt("comm"));
					mbQnaList.add(user);					
				}while(rs.next());
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return mbQnaList;
	} // getUserQnAList()
	
	// 1:1문의  사업자회원 QnAList 의 수를 가져오는 메서드
	public int getMemberQnACount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from board B, member M where categ=1 and B.id = M.id";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return count;
	} //getMemberQnACount()
	
	// 1:1문의 검색 된 사업자회원 리스트의 수를 가져오는 메서드
		public int getMemberQnASearchCount(String sel, String search) {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select count(*) from board B,member M where B." + sel + " like '%" + search + "%' AND categ=1 and B.id = M.id";
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}
			return count;
		} //getMemberQnASearchCount()
		
		// 1:1문의 검색 된 사업자회원 리스트 가져오는 메서드
		public List getMemberQnASearch(int start, int end, String sel, String search) {
			List mbQnaList = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select reg_date,id,subject,reply_date,comm,r from (select reg_date, id, subject, reply_date, comm, rownum r from (select B.reg_date,B.id,B.subject,B.reply_date,B.comm from board B, member M where B.id = M.id and B.categ = 1 and B." +sel+ " like '%" +search+ "%' order by B.reg_date desc)) where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					mbQnaList = new ArrayList();
					do {
						BoardDTO user = new BoardDTO();
						user.setReg_date(rs.getTimestamp("reg_date"));
						user.setId(rs.getString("id"));
						user.setSubject(rs.getString("subject"));
						user.setReply_date(rs.getTimestamp("reply_date"));
						user.setComm(rs.getInt("comm"));
						mbQnaList.add(user);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}	
			return mbQnaList;
		} //getMemberQnASearch()
	
		// 1:1문의 사업자회원 문의글 삭제 메서드
		public int deleteMemberQna(String id) {
			int result = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();			
				String sql = "delete from board where exists(select * from member where board.id = member.id AND board.categ=1 and board.id = ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				result = pstmt.executeUpdate();

			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}		
			return result;
		} //deleteMemberQna()
	
		
// ********** 사업자 관리 관련 메서드 *************
		
		//adminMemberDeleteForm		
		public int deleteMember(String id) {			
			PreparedStatement pstmt = null;
			Connection conn = null;
			String sql = null;
			int result = 0;
			
			try {
				conn = getConnection();				
				sql = "delete from member where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }				
			}		
			return result;			
		}
		
		
		//adminMemberForm에서 사용 - 리스트 호출, 검색		
		public int getMembercount() {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			
			try {				
				conn = getConnection();
				String sql = "select count(*) from member";			
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = rs.getInt(1);
				}			
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}			
			return result;
		}
			
		public List getMember(int startRow, int endRow){		
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List MemberList = null;
						
			try {
				conn = getConnection();
		        String sql = "select r, ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from (select rownum r, ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from (select ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from member ORDER BY ID ASC) ORDER BY ID ASC) WHERE r >= ? AND r <= ?";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, startRow);
		         pstmt.setInt(2, endRow);
		         rs = pstmt.executeQuery(); 
		         
		         if(rs.next()) {		        	 
		            MemberList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
		            do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
		               MemberDTO member = new MemberDTO(); 
		               member.setId(rs.getString("id"));
		               member.setHotel_name(rs.getString("hotel_name"));
		               member.setHotel_add(rs.getString("hotel_add"));
		               member.setHotel_owner(rs.getString("hotel_owner"));
		               member.setReg_num(rs.getString("reg_num"));
		               member.setMember_approved(rs.getInt("member_approved"));
		               MemberList.add(member); // 리스트에 추가 		               
		            }while(rs.next());		            
		         }				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}			
			return MemberList;
		}
		
		// 검색으로 member리스트의 값이 몇개인지 리턴하는 메서드
		public int getMemberSearchcount(String selected, String search) {		
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int result = 0;
		
			try {			
				conn = getConnection();
				String sql = "select count(*) from member where "+selected+" like '%"+search+"%'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = rs.getInt(1);
				}	
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}			
			return result;		
		}
		
		public List getSearchMember(int startRow, int endRow, String selected, String search) {			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List MemberList = null;
				
			try {
				conn = getConnection();
		        String sql = "select r, id, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from (select rownum r, ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from (select ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from member where "+selected+" like '%"+search+"%') ORDER BY ID ASC) WHERE r >= ? AND r <= ?";	         
		        pstmt = conn.prepareStatement(sql);

		        pstmt.setInt(1, startRow);
		        pstmt.setInt(2, endRow);
		        rs = pstmt.executeQuery(); 
		         
		        if(rs.next()) {	        	 
		            MemberList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
		            do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
		               MemberDTO member = new MemberDTO(); 
		               member.setId(rs.getString("id"));
		               member.setHotel_name(rs.getString("hotel_name"));
		               member.setHotel_add(rs.getString("hotel_add"));
		               member.setHotel_owner(rs.getString("hotel_owner"));
		               member.setReg_num(rs.getString("reg_num"));
		               member.setMember_approved(rs.getInt("member_approved"));
		               MemberList.add(member); // 리스트에 추가 		               
		            }while(rs.next());		            
		         }				
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
					if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
					if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
				}			
			return MemberList;			
			}
				
		//adminApproveForm에서 사용
		public int MemberApprove(String Id) { //멤버 승인		
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
		
			try {
				conn = getConnection();
				String sql = "Update member set member_approved = 1 where id = ?";			
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, Id);
				
				result = pstmt.executeUpdate();				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}		
			return result;			
		}
		
		//adminConfirmRegNumForm에서 사용, 승인 보류		
		public int ConfirmRegNum(String Id, String HoldReason) {			
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
						
			try {
				conn = getConnection();
				String sql = "Update member set member_approved = 2, hold_reason = ? where id = ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, HoldReason);
				pstmt.setString(2, Id);
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}			
			return result;	
		}
		
// ********** 후기관리 관련 메서드 *************
			
		//Review - adminReviewForm에서 사용		
		public int getReviewCount() {	
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			
			try {			
				conn = getConnection();
				String sql = "select count(*) from board b, member m where b.reg_num = m.reg_num AND categ = '3'";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) { //결과 있으면
					result = rs.getInt(1); //컬럼번호로 빼내욤. 어차피 결과 컬럼번호 1에 count(*)로 갯수만 출력되어있음
				}			
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}			
			return result;			
		}
		
		
		public List getReview(int startRow, int endRow){			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List reviewList = null;
						
			try {
				conn = getConnection();
		         String sql = "select r, reg_date, id, hotel_name, subject, comm, board_num from (select rownum r, reg_date, id, hotel_name, subject, comm, board_num from (select b.reg_date, b.id, m.hotel_name, b.subject, b.comm, b.board_num from board b, member m where b.reg_num = m.reg_num AND categ = 3 ORDER BY b.reg_date DESC) ORDER BY reg_date DESC) where r >= ? AND r <= ?";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, startRow);
		         pstmt.setInt(2, endRow);
		         rs = pstmt.executeQuery(); 
		         
		         if(rs.next()) {
		        	 //b.reg_date, b.id, m.hotel_name, b.subject, b.comm, b.board_num
		            reviewList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
		            do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.	            	
			            ReviewDTO review = new ReviewDTO();
			            review.setReg_date(rs.getTimestamp("reg_date"));
			            review.setId(rs.getString("id"));
			            review.setHotel_name(rs.getString("hotel_name"));
			            review.setSubject(rs.getString("subject"));
			            review.setComm(rs.getInt("comm"));
			            review.setBoard_num(rs.getInt("board_num"));
			 	        reviewList.add(review); // 리스트에 추가 				          			          	               
		            }while(rs.next());		            
		         }				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}			
			return reviewList;
		}
		
		public int getReviewSearchCount(String selected, String search) {			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			String sql = null;
		
			try {				
				conn = getConnection();
				System.out.println(selected);
				if(selected.equals("id")){
					sql = "select count(*) from board where "+selected+" like '%"+search+"%' AND categ = 3";
				}
				else if(selected.equals("hotel_name")){
					sql = "select count(*) from board b, member m where m."+selected+" like '%"+search+"%' AND b.categ = 3 AND b.reg_num = m.reg_num";
				}

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) { //결과 있으면
					result = rs.getInt(1); //컬럼번호로 빼내욤. 어차피 결과 컬럼번호 1에 count(*)로 갯수만 출력되어있음
				}		
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}		
		return result;		
		}
		
		public List getSearchReview(int startRow, int endRow, String selected, String search) {
		
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List reviewList = null;
			String sql = null;
			
			System.out.println(selected);
			
			try {
			conn = getConnection();
			if(selected.equals("id")){sql = "select r, reg_date, id, hotel_name, subject, comm, board_num from (select rownum r, reg_date, id, hotel_name, subject, comm, board_num from (select b.reg_date, b.id, m.hotel_name, b.subject, b.comm, b.board_num from board b, member m where b."+selected+" like '%"+search+"%' AND b.categ = 3 AND b.reg_num = m.reg_num) ORDER BY ID ASC) WHERE r >= ? AND r <= ?";}
			else if(selected.equals("hotel_name")){sql = "select r, reg_date, id, hotel_name, subject, comm, board_num from (select rownum r, reg_date, id, hotel_name, subject, comm, board_num from (select b.reg_date, b.id, m.hotel_name, b.subject, b.comm, b.board_num from board b, member m where m."+selected+" like '%"+search+"%' AND b.categ = 3 AND b.reg_num = m.reg_num) ORDER BY ID ASC) WHERE r >= ? AND r <= ?";}
			 
			pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, selected);
			//pstmt.setString(2, search);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery(); 
			 
			if(rs.next()) {
				 
			   reviewList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
			   do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
				   ReviewDTO review = new ReviewDTO();
		            review.setReg_date(rs.getTimestamp("reg_date"));
		            review.setId(rs.getString("id"));
		            review.setHotel_name(rs.getString("hotel_name"));
		            review.setSubject(rs.getString("subject"));
		            review.setComm(rs.getInt("comm"));
		            review.setBoard_num(rs.getInt("board_num"));
		 	        reviewList.add(review); // 리스트에 추가 
		           
			   }while(rs.next());
			}
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}	
		return reviewList;	
		}
		
		//adminReviewDeleteForm에서 사용		
			public int deleteReview(String num) {//adminReviewDeleteForm
				
				PreparedStatement pstmt = null;
				Connection conn = null;
				String sql = null;
				int result = 0;
				
				try {
					conn = getConnection();
					
					sql = "delete from board where board_num = ? AND categ = 3";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, num);
					
					result = pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
					if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }				
				}				
				return result;				
			}
			
}
