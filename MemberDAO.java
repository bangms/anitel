package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() { return instance; }
	
	// 커넥션 메서드 : 내부에서만 사용할거라 private 접근 제어자
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 회원가입 메서드 (member 테이블에 입력)
	public void insertMember(MemberDTO member) {
		Connection conn = null;
		PreparedStatement  pstmt = null;
		
		try {
			conn = getConnection();
			// DB에 작성되어있는 순서대로 작성하여야 함 (컬럼명 작성 안했기 때문에)
			String sql = "insert into member values(?,?,?,?,?,?,?,?,?,0,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getMember_pw());
			pstmt.setString(3, member.getMember_name());
			pstmt.setString(4, member.getMember_phone());
			pstmt.setString(5, member.getMember_email());
			pstmt.setString(6, member.getHotel_name());
			pstmt.setString(7, member.getHotel_owner());
			pstmt.setString(8, member.getHotel_add());
			pstmt.setString(9, member.getHotel_phone());
			pstmt.setString(10, member.getHotel_intro());
			pstmt.setString(11, member.getHotel_area());
			pstmt.setString(12, member.getHold_reason());
			pstmt.setString(13, member.getReg_num());
			
			int result = pstmt.executeUpdate();
			System.out.println(result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	// 회원가입 메서드 (room 테이블에 입력)
	public void insertRoom(RoomDTO room) {
		Connection conn = null;
		PreparedStatement  pstmt = null;

		try {
			conn = getConnection();
			// DB에 작성되어있는 순서대로 작성하여야 함 (컬럼명 작성 안했기 때문에)
			String sql = "insert into room values(room_seq.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, room.getId());
			pstmt.setString(2, room.getName());
			pstmt.setInt(3, room.getPet_type());
			pstmt.setString(4, room.getPet_etctype());
			pstmt.setString(5, room.getD_fee());
			pstmt.setInt(6, room.getPet_big());
			pstmt.setInt(7, room.getUtil_pool());
			pstmt.setInt(8, room.getUtil_ground());
			pstmt.setInt(9, room.getUtil_parking());
			pstmt.setInt(10, room.getPaid_bath());
			pstmt.setInt(11, room.getPaid_beauty());
			pstmt.setInt(12, room.getPaid_medi());
			pstmt.setString(13, room.getImg());
			
			int result = pstmt.executeUpdate();
			System.out.println(result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	// 아이디 중복 확인 
	public boolean confirmId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn = getConnection();
			String sql = "select id from users where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			} else {
				sql = "select id from member where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = true;
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return result;
	}
}
