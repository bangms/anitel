package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import anitel.model.AdminDAO;

public class AdminDAO {

	private static AdminDAO instance = new AdminDAO();
	private AdminDAO() {}
	public static AdminDAO getInstance() { return instance; }
	
	private Connection getConnection() throws Exception{
		
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
		
	}
	
	//adminMemberDeleteForm에서 사용
	
	public int deleteMember(String id) {//adminMemberDeleteForm
		
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
	
	
	public int getMembercount() { //adminMemberForm Member테이블 데이터 총갯수 출력
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			
			conn = getConnection();
			String sql = "select count(*) from member";
			
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
		
		return result; //갯수 출력
		
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
	

	public int getMemberSearchcount(String selected, String search) {//검색으로 member리스트의 값이 몇개인지 리턴하는 메서드
	
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
	
		try {
			
			conn = getConnection();
			String sql = "select count(*) from member where ? like %?%";
			
			pstmt.setString(1, selected);
			pstmt.setString(2, search);
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
	
	public List getSearchMember(int startRow, int endRow, String selected, String search) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List MemberList = null;
		
		
		try {
			conn = getConnection();
	         String sql = "select r, ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from (select rownum r, ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from (select ID, hotel_name, hotel_add, hotel_owner, reg_num, member_approved from member where ? like '%?%') ORDER BY ID ASC) WHERE r >= ? AND r <= ?";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, selected);
	         pstmt.setString(2, search);
	         pstmt.setInt(3, startRow);
	         pstmt.setInt(4, endRow);
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
	

	
	
	
	//Review - adminReviewForm에서 사용
	
	public int getReviewCount() { //adminMemberForm Member테이블 데이터 총갯수 출력
		
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
		
		return result; //갯수 출력
		
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
	
	public int getReviewSearchCount(String selected, String search) {//검색으로 member리스트의 값이 몇개인지 리턴하는 메서드
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = null;
	
		try {
			
			conn = getConnection();
			
			if(selected == "id") {sql = "select count(*) from board where ? like %?% AND categ = '3'";}
			else if(selected == "hotel_name") {sql = "select count(*) from board b, member m where m.? like '%?%' AND b.categ = '3' AND b.reg_num = m.reg_num";}
		
			pstmt.setString(1, selected);
			pstmt.setString(2, search);
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
		
		try {
		conn = getConnection();
		if(selected == "id") {sql = "select r, reg_date, id, hotel_name, subject, comm, board_num from (select rownum r, reg_date, id, hotel_name, subject, comm, board_num from (select b.reg_date, b.id, m.hotel_name, b.subject, b.comm, b.board_num from board b, member m where b.? like '%?%' AND b.categ = '3' AND b.reg_num = m.reg_num) ORDER BY ID ASC) WHERE r >= ? AND r <= ?";}
		else if(selected == "hotel_name") {sql = "select r, reg_date, id, hotel_name, subject, comm, board_num from (select rownum r, reg_date, id, hotel_name, subject, comm, board_num from (select b.reg_date, b.id, m.hotel_name, b.subject, b.comm, b.board_num from board b, member m where m.? like '%?%' AND b.categ = '3' AND b.reg_num = m.reg_num) ORDER BY ID ASC) WHERE r >= ? AND r <= ?";}
		 
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, selected);
		pstmt.setString(2, search);
		pstmt.setInt(3, startRow);
		pstmt.setInt(4, endRow);
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
