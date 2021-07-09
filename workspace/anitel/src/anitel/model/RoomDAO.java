package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RoomDAO {
	//싱글톤 만들기 
	private static RoomDAO instance = new RoomDAO();
	private RoomDAO() {}
	public static RoomDAO getInstance() { return instance;}

	// 커넥션 메서드 : 내부에서만 사용할거라 private 접근제어자 붙힘
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 호텔 개수 가져오기
	public int getHotelCount(HotelDTO hotel) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql ="select count(*)"
					+ " FROM member mem, room r, (select C.* from room C left outer join (select A.room_num from (SELECT * FROM booking WHERE check_in <= '"+hotel.getCheck_out()+"' AND check_out >= '"+hotel.getCheck_in()+"') A) B on C.room_num=B.room_num where B.room_num is null) D"
					+ " where r.room_num = D.room_num and mem.id = r.id and mem.hotel_area like '"+hotel.getHotel_area()+"%' and r.pet_type = "+hotel.getPet_type();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// count(*) 은 결과를 숫자로 가져옴. 
				// 컬럼명 대신 컬럼번호로 꺼내서 count 변수에 담기
				count = rs.getInt(1); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return count;
	}
	// 리스트 가져오기(메인->리스트)
	public List getHotels (int start, int end, HotelDTO selhotel) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List hotelList = null;
		
		try {
			conn = getConnection();
			
			String sql ="select m.id, m.hotel_name, r.img, r.d_fee, m.util_pool, m.util_ground, m.util_parking, m.paid_bath, m.paid_beauty, m.paid_medi, r.pet_big, m.hotel_intro"
					+ " FROM member m, room r, (select C.* from room C left outer join (select A.room_num from (SELECT * FROM booking WHERE check_in <= '"+selhotel.getCheck_out()+"' AND check_out >= '"+selhotel.getCheck_in()+"') A) B on C.room_num=B.room_num where B.room_num is null) D"
					+ " where r.room_num = D.room_num and m.id = r.id and m.hotel_area like '"+selhotel.getHotel_area()+"%' and r.pet_type = "+selhotel.getPet_type();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 있으면
				hotelList = new ArrayList(); // list 객체 생성

				do {
					HotelDTO hotel = new HotelDTO();
					hotel.setId(rs.getString("id"));
					hotel.setHotel_name(rs.getString("hotel_name"));
					hotel.setImg(rs.getString("img"));
					hotel.setUtil_pool(rs.getString("util_pool"));
					hotel.setUtil_ground(rs.getString("util_ground"));
					hotel.setUtil_parking(rs.getString("util_parking"));
					hotel.setPaid_bath(rs.getString("paid_bath"));
					hotel.setPaid_beauty(rs.getString("paid_beauty"));
					hotel.setPaid_medi(rs.getString("paid_medi"));
					hotel.setPet_big(rs.getString("pet_big"));
					hotel.setHotel_intro(rs.getString("hotel_intro"));
					hotel.setD_fee(rs.getString("d_fee"));
					hotelList.add(hotel);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}	
		return hotelList;
	}
	// 세부검색 호텔 개수 가져오기
	public int getSubHotelCount(HotelDTO hotel, String subSql) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql ="select count(*)"
					+ " FROM member mem, room r, (select C.* from room C left outer join (select A.room_num from (SELECT * FROM booking WHERE check_in <= '"+hotel.getCheck_out()+"' AND check_out >= '"+hotel.getCheck_in()+"') A) B on C.room_num=B.room_num where B.room_num is null) D"
					+ " where r.room_num = D.room_num and mem.id = r.id and mem.hotel_area like '"+hotel.getHotel_area()+"%' and r.pet_type = "+hotel.getPet_type();
			
			if(subSql != null) {
				sql += subSql;
			}
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// count(*) 은 결과를 숫자로 가져옴. 
				// 컬럼명 대신 컬럼번호로 꺼내서 count 변수에 담기
				count = rs.getInt(1); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return count;
	}
	// 세부 검색 리스트 가져오기
	public List getSubHotels (int start, int end, HotelDTO selhotel, String subSql) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List hotelList = null;
		
		try {
			conn = getConnection();
			
			String sql ="select mem.id, mem.hotel_name, r.img, r.d_fee, mem.util_pool, mem.util_ground, mem.util_parking, mem.paid_bath, mem.paid_beauty, mem.paid_medi, r.pet_big, mem.hotel_intro"
					+ " FROM member mem, room r, (select C.* from room C left outer join (select A.room_num from (SELECT * FROM booking WHERE check_in <= '"+selhotel.getCheck_out()+"' AND check_out >= '"+selhotel.getCheck_in()+"') A) B on C.room_num=B.room_num where B.room_num is null) D"
					+ " where r.room_num = D.room_num and mem.id = r.id and mem.hotel_area like '"+selhotel.getHotel_area()+"%' and r.pet_type = "+selhotel.getPet_type();
			
			if(subSql != null) {
				sql += subSql;
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 있으면
				hotelList = new ArrayList(); // list 객체 생성

				do {
					HotelDTO hotel = new HotelDTO();
					hotel.setId(rs.getString("id"));
					hotel.setHotel_name(rs.getString("hotel_name"));
					hotel.setImg(rs.getString("img"));
					hotel.setUtil_pool(rs.getString("util_pool"));
					hotel.setUtil_ground(rs.getString("util_ground"));
					hotel.setUtil_parking(rs.getString("util_parking"));
					hotel.setPaid_bath(rs.getString("paid_bath"));
					hotel.setPaid_beauty(rs.getString("paid_beauty"));
					hotel.setPaid_medi(rs.getString("paid_medi"));
					hotel.setPet_big(rs.getString("pet_big"));
					hotel.setHotel_intro(rs.getString("hotel_intro"));
					hotel.setD_fee(rs.getString("d_fee"));
					hotelList.add(hotel);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}	
		return hotelList;
	}
	
}
