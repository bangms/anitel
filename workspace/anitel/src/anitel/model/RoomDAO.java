package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

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
	public int getHotelCount(String area, String check_in, String check_out, int pet_type) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*)" + 
					" from member mem, room r, booking b" + 
					" where mem.id = r.id and r.room_num = b.room_num" + 
					" and mem.hotel_area like '"+ area +"%'" +
					" and r.pet_type =" + pet_type + 
					" and b.check_in > '" + check_out + "'";
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
	public Map getHotels (int start, int end, String area, String check_in, String check_out, int pet_type) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map hotelList = null;
		
		try {
			conn = getConnection();
			// 서브쿼리 중첩 (가장 안쪽 괄호부터 보기)
			String sql = "select mem.id, mem.hotel_name, r.img, r.util_pool, r.util_ground, r.util_parking, r.paid_bath, r.paid_beauty, r.paid_medi, r.pet_big, mem.hotel_intro" + 
					" from member mem, room r, booking b" + 
					" where mem.id = r.id and r.room_num = b.room_num" + 
					" and mem.hotel_area like '"+ area +"%'" +
					" and r.pet_type =" + pet_type + 
					" and b.check_in > '" + check_out + "'";
			//" and b.check_in > '" + check_out + "' and b.check_out < '" + check_in + "'"; 
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 있으면
				hotelList = new HashMap(); // list 객체 생성

				do {
					hotelList.put("id",rs.getString("id"));
					hotelList.put("hotel_name",rs.getString("hotel_name"));
					hotelList.put("img",rs.getString("img"));
					hotelList.put("util_pool",rs.getString("util_pool"));
					hotelList.put("util_ground",rs.getString("util_ground"));
					hotelList.put("util_ground",rs.getString("util_parking"));
					hotelList.put("paid_bath",rs.getString("paid_bath"));
					hotelList.put("paid_beauty",rs.getString("paid_beauty"));
					hotelList.put("paid_medi",rs.getString("paid_medi"));
					hotelList.put("pet_big",rs.getString("pet_big"));
					hotelList.put("hotel_intro",rs.getString("hotel_intro"));
										
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
	// 세부 검색
	
	
}
