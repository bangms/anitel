package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.ldap.Rdn;
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
	
	//일반유저 회원가입 (펫)
	public void insertPet(PetDTO dto, String id) { 
		
		Connection conn = null;
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection();
			String sql = "insert into pet values(PET_SEQ.nextVal,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, dto.getPet_name());
			pstmt.setInt(3, dto.getPet_type());
			pstmt.setInt(4, dto.getPet_gender());
			pstmt.setInt(5, dto.getPet_operation());
			pstmt.setString(6, dto.getPet_age());
			pstmt.setInt(7, dto.getPet_big());
			pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}
	//아이디 중복 체크 
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

}
