package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


 

public class UsersDAO {
	
	//싱글톤 만들기 
	private static UsersDAO instance = new UsersDAO();
	private UsersDAO() {}
	public static UsersDAO getInstance() { return instance;}

	// 커넥션 메서드 : 내부에서만 사용할거라 private 접근제어자 붙힘
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//일반유저 회원가입 (유저)
	public void insertUser(UsersDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection();
			String sql = "insert into users values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getUser_pw());
			pstmt.setString(3, dto.getUser_name());
			pstmt.setString(4, dto.getUser_phone());
			pstmt.setString(5, dto.getUser_email());
			pstmt.setInt(6, dto.getAdmin());
			
			pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}
	//일반유저 회원가입 (펫) - 다희수정
	public void insertPet(PetDTO dto, String id) { 
		Connection conn = null;
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection();
			String sql = "insert into pet values(PET_SEQ.nextVal,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, dto.getPet_name());
			pstmt.setInt(3, dto.getPet_type());
			pstmt.setString(4, dto.getPet_etctype());
			pstmt.setInt(5, dto.getPet_gender());
			pstmt.setInt(6, dto.getPet_operation());
			pstmt.setString(7, dto.getPet_age());
			pstmt.setInt(8, dto.getPet_big());
			pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}

	//아이디 중복 체크하는메소드 
	public boolean confirmId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		boolean result = false;
		
		try {
			System.out.println(id);
			conn = getConnection(); 
			String sql = "select id from users where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}else {
				sql = "select id from member where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = true;
				}
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}		
		
		return result;
	}
	// 아이디 비밀번호 체크
	public boolean idPwCheck(String id, String pw) {
		boolean result = false;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();	
			String sql = "select * from users where id=? and user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
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
	// 노현호 작성 - id 받아서 해당 '일반 회원' 개인정보 불러오기 (userMyPage.jsp 에서 사용함)
	public UsersDTO getuser(String id) {
		UsersDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id, user_name, user_phone, user_email from users where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new UsersDTO();
				dto.setId(rs.getString(1));
				dto.setUser_name(rs.getString(2));
				dto.setUser_phone(rs.getString(3));
				dto.setUser_email(rs.getString(4));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return dto;
	}	
	
	//비밀번호 수정하는 메소드 
	public int userModifyPw(String id, String pw_now, String pw, String pw2){
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id, user_pw from users where id=? and user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw_now);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pw.equals(pw2)) {
					sql = "update users set user_pw=? where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, pw);
					pstmt.setString(2, id);
					result = pstmt.executeUpdate();
				}else {
					result = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		// result 값이 -1 : 현재 비밀번호 불일치, 0 : 새 비밀번호간 불일치, 1 : 변경 완료 
		return result;
	}
	
	
	// 노현호 작성 - pw 넣어서 '일반회원' 비밀번호 일치 여부 확인(popupPro.jsp에서 사용)
	public int matchUserPw(String id, String pw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id from users where id=? and user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result=1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		// result 값이 -1 : 현재 비밀번호 불일치, 1 : 변경 완료 
		return result;
	}
	
	// 노현호 작성 - pw 넣어서 일반회원' 탈퇴(popupPro.jsp에서 사용)
	public int deleteUser(String id, String pw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id, user_pw from users where id=? and user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "delete from users where id=? and user_pw=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				result = pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		// result 값이 -1 : 현재 비밀번호 불일치, 0 : 새 비밀번호간 불일치, 1 : 변경 완료 
		return result;
	}
	
//	// 삭제된 유저의 펫도 삭제
//		public void deleteUsersPet(String id) { 
//			Connection conn = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				conn = getConnection();			
//				String sql = "delete from pet where id = ?";
//				pstmt = conn.prepareStatement(sql);
//				pstmt.setString(1, id);
//				pstmt.executeUpdate();
//
//			}catch(Exception e) {
//				e.printStackTrace();
//			}finally {
//				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
//				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
//			}
//			
//			
//		}
//		// 회원 삭제시, 예정 상태 예약만 취소 처리시키는 메서드
//		public void deleteUserBooking(String id) {
//			Connection conn = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				conn = getConnection();			
//				String sql = "update booking set booking_status=1 where booking_status=2 and id = ?";
//				pstmt = conn.prepareStatement(sql);
//				pstmt.setString(1, id);
//				pstmt.executeUpdate();
//
//			}catch(Exception e) {
//				e.printStackTrace();
//			}finally {
//				if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
//				if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
//			}		
//		}
		

	//개인정보 수정 메서드 (userModifyForm)
	public int userModify(String id, UsersDTO dto){
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			conn = getConnection();
			String sql = "update users set user_name=?, user_phone=?, user_email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_name());
			pstmt.setString(2, dto.getUser_phone());
			pstmt.setString(3, dto.getUser_email());
			pstmt.setString(4, id);
			
			result = pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;

	}	
}
