package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookingDAO {

	//싱글톤 만들기 
	private static BookingDAO instance = new BookingDAO();
	private BookingDAO() {}
	public static BookingDAO getInstance() { return instance;}

	// 커넥션 메서드 : 내부에서만 사용할거라 private 접근제어자 붙힘
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}


	//booking_num 받아오는 리스트 메서드.
	public List getBNum(String id) {

		List bookinglist = null;
		BookingDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select booking_num from booking where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				bookinglist = new ArrayList();
				do{
					dto = new BookingDTO();
					dto.setBooking_num(rs.getInt("Booking_num"));
					bookinglist.add(dto);
				}while(rs.next());
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return bookinglist;

	}

	//호텔예약 취소	메서드 (부킹상태바꿔주는것 ) 
	public int cancleReserve (int booking_num) {
		int result=0;
		Connection conn=null;
		PreparedStatement pstmt=null;

		try {
			conn= getConnection();
			String sql="update booking set booking_status=1 where booking_num=?";				
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, booking_num);

			result=pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;

	}


	// 내 예약리스트의 갯수를 가져오는 메서드
	public int getReserveCount(String id, String num) {

		int count = 0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;


		try {
			conn = getConnection();
			String sql = "select count(*) from booking where id = ? AND booking_status = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, num);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				count = rs.getInt(1);
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}


		return count;
	}


	//호텔 예약관련 정보 테이블 5개에서 뽑아오는 리스트	
	public List getReserve(String id, String num, int start, int end) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List reserveList = null;

		try {
			conn = getConnection();
			String sql = "select o, booking_num, hotel_name, name, check_in, check_out, user_name, pet_name, requests, paid_bath, paid_beauty, paid_medi, hotel_img, booking_status, reg_num "
					+ "from (Select rownum o, Booking_num, hotel_name, name, check_in, check_out, user_name, pet_name, requests, paid_bath, paid_beauty, paid_medi, hotel_img, booking_status, reg_num "
					+ "from (Select b.Booking_num, m.hotel_name, r.name, b.check_in, b.check_out, u.user_name, p.pet_name, b.requests, b.paid_bath, b.paid_beauty, b.paid_medi, m.hotel_img, b.booking_status, m.reg_num "
					+ "from users u, pet p, booking b, room r, member m where u.id = b.id AND b.pet_num = p.pet_num AND b.room_num = r.room_num AND r.id = m.id AND u.id = ? AND b.booking_status = ? "
					+ "ORDER BY b.check_in asc) ORDER BY check_in asc) where o >= ? AND o <= ?";		
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, num);	        
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery(); 

			if(rs.next()) {

				reserveList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
				do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
					ReserveDTO reserve = new ReserveDTO(); 
					reserve.setBooking_num(rs.getInt("booking_num"));	               
					reserve.setHotel_name(rs.getString("hotel_name"));
					reserve.setName(rs.getString("name"));
					reserve.setCheck_in(rs.getTimestamp("check_in"));
					reserve.setCheck_out(rs.getTimestamp("check_out"));
					reserve.setUser_name(rs.getString("user_name"));
					reserve.setPet_name(rs.getString("pet_name"));
					reserve.setRequests(rs.getString("requests"));
					reserve.setPaid_bath(rs.getInt("paid_bath"));
					reserve.setPaid_beauty(rs.getInt("paid_beauty"));
					reserve.setPaid_medi(rs.getInt("paid_medi"));
					reserve.setHotel_img(rs.getString("hotel_img"));
					reserve.setBooking_status(rs.getInt("booking_status"));
					reserve.setReg_num(rs.getString("reg_num"));
					reserveList.add(reserve); // 리스트에 추가 

				}while(rs.next());

			}


		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}

		return reserveList;

	}

	// 호텔 정보 가져오는 메서드
		public MemberDTO getHotelInfo(String id) {
			MemberDTO hotel = new MemberDTO();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			
			try {
				conn = getConnection();
				String sql = "select hotel_name, hotel_add, hotel_img, util_pool, util_ground, util_parking, paid_bath, paid_beauty, paid_medi from member where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					hotel.setHotel_name(rs.getString("hotel_name"));
					hotel.setHotel_add(rs.getString("hotel_add"));
					hotel.setHotel_img(rs.getString("hotel_img"));
					hotel.setUtil_ground(rs.getInt("util_ground"));
					hotel.setUtil_parking(rs.getInt("util_parking"));
					hotel.setUtil_pool(rs.getInt("util_pool"));
					hotel.setPaid_bath(rs.getInt("paid_bath"));
					hotel.setPaid_beauty(rs.getInt("paid_beauty"));
					hotel.setPaid_medi(rs.getInt("paid_medi"));
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}
			return hotel;
		} // getHotelInfo()
		
		// 객실 정보 가져오는 메서드
		public RoomDTO getRoomInfo(String num) {
			RoomDTO room = new RoomDTO();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			
			try {
				conn = getConnection();
				String sql = "select name, pet_type, pet_etctype, d_fee, pet_big, img from room where room_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					room.setName(rs.getString("name"));
					room.setPet_type(rs.getInt("pet_type"));
					room.setPet_etctype(rs.getString("pet_etctype"));
					room.setD_fee(rs.getString("d_fee"));
					room.setPet_big(rs.getInt("pet_big"));
					room.setImg(rs.getString("img"));
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}
			return room;
		}
		
		// 예약자 정보 가져오는 메서드
		public UsersDTO getReserveUserInfo(String id) {
			UsersDTO user = new UsersDTO();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			
			try {
				conn = getConnection();
				String sql = "select user_name, user_email, user_phone from users where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					user.setUser_name(rs.getString("user_name"));
					user.setUser_email(rs.getString("user_email"));
					user.setUser_phone(rs.getString("user_phone"));
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}		
			return user;
		}
		
		// 예약자의 펫 정보 가져오는 메서드
		public List getReservePetInfo(String id) {
			List petInfo = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;		
			
			try {
				conn = getConnection();
				String sql ="select p.pet_num, p.pet_name, p.pet_type, p.pet_gender, p.pet_age, p.pet_big, p.pet_operation from pet p, users u where u.id = p.id AND u.id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					petInfo = new ArrayList();
					do {
						PetDTO pet = new PetDTO();
						pet.setPet_num(rs.getInt("pet_num"));
						pet.setPet_name(rs.getString("pet_name"));
						pet.setPet_type(rs.getInt("pet_type"));
						pet.setPet_gender(rs.getInt("pet_gender"));
						pet.setPet_age(rs.getString("pet_age"));
						pet.setPet_big(rs.getInt("pet_big"));
						pet.setPet_operation(rs.getInt("pet_operation"));									
						petInfo.add(pet);
					}while(rs.next());
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}
			return petInfo;
		}
		
		// 결제하기 버튼 누른 후 예약자 정보 저장되는 메서드
		public void insertBooking(BookingDTO dto) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				String sql = "insert into booking(id,room_num,user_name,user_phone,user_email,pet_num,requests,paid_bath,paid_beauty,paid_medi,check_in,check_out,booking_time) values(?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getId());
				pstmt.setInt(2, dto.getRoom_num());
				pstmt.setString(3, dto.getUser_name());
				pstmt.setString(4, dto.getUser_phone());
				pstmt.setString(5, dto.getUser_email());
				pstmt.setInt(6, dto.getPet_num());
				pstmt.setString(7, dto.getRequests());
				pstmt.setInt(8, dto.getPaid_bath());
				pstmt.setInt(9, dto.getPaid_beauty());
				pstmt.setInt(10, dto.getPaid_medi());
				pstmt.setTimestamp(11, dto.getCheck_in());
				pstmt.setTimestamp(12, dto.getCheck_out());
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
			}
		}




}
