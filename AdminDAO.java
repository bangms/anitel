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
			String sql = "SELECT R.name, M.hotel_name, B.Booking_Time, B.id, B.user_phone, P.pet_name, B.REQUESTS, B.payment from Booking B, room R, member M, pet P where R.room_num = B.room_num AND R.id = M.id AND P.pet_num = B.pet_num";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bookingList = new ArrayList();
				do {
					RoomDTO r = new RoomDTO();
					BookingDTO b = new BookingDTO();
					MemberDTO m = new MemberDTO();
					PetDTO p = new PetDTO();
					
					r.setName(rs.getString("name"));
					m.setHotel_name(rs.getString("hotel_name"));
					b.setBooking_time(rs.getTimestamp("booking_time"));
					b.setId(rs.getString("id"));
					b.setUser_phone(rs.getString("user_phone"));
					p.setPet_name(rs.getString("pet_name"));
					b.setRequests(rs.getString("requests"));
					b.setBooking_status(rs.getInt("booking_status"));
					b.setPayment(rs.getInt("payment"));
									
					bookingList.add(r);
					bookingList.add(b);	
					bookingList.add(m);	
					bookingList.add(p);	
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
		
// ********** 1:1문의 관련 메서드 *************
	
	// 1:1문의  일반 회원 - UserQnAList 가져오는 메서드
	public List getUserQnAList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List usQnaList = null;
		
		try {
			conn = getConnection();
			String sql = "select reg_date,id,subject,comm, r from (select reg_date, id, subject, comm, rownum r from (select B.reg_date,B.id,B.subject,B.comm from board B, users U where B.id = U.id and B.categ = 1 order by B.reg_date desc)) where r >= ? and r <= ?";
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
	
	// 1:1문의  일반 회원 - UserQnAList 의 수를 가져오는 메서드
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
			String sql = "select count(*) from board B,users U where B." + sel + " like '%" + search + "%' AND B.id = U.id";
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
			String sql = "select reg_date,id,subject,comm,r from (select reg_date, id, subject, comm, rownum r from (select B.reg_date,B.id,B.subject,B.comm from board B, users U where B.id = U.id and B.categ = 1 and B." +sel+ " like '%" +search+ "%' order by B.reg_date desc)) where r >= ? and r <= ?";
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
			String sql = "delete from board where exists(select * from users where board.id = users.id AND board.id = ?)";
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
	
	
	// 1:1문의  사업자 회원  - mbQnAList 가져오는 메서드
	public List getMemberQnAList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List mbQnaList = null;
		
		try {
			conn = getConnection();
			String sql = "select reg_date,id,subject,comm,r from (select reg_date, id, subject, comm, rownum r from (select B.reg_date,B.id,B.subject,B.comm from board B, member M where B.id = M.id and B.categ = 1 order by B.reg_date desc)) where r >= ? and r <= ?";
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
	
	// 1:1문의  사업자회원 - mbQnAList 의 수를 가져오는 메서드
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
				String sql = "select count(*) from board B,member M where B." + sel + " like '%" + search + "%' AND B.id = M.id";
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
		
		// 1:1문의 검색 된 일반회원 리스트 가져오는 메서드
		public List getMemberQnASearch(int start, int end, String sel, String search) {
			List mbQnaList = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select reg_date,id,subject,comm,r from (select reg_date, id, subject, comm, rownum r from (select B.reg_date,B.id,B.subject,B.comm from board B, member M where B.id = M.id and B.categ = 1 and B." +sel+ " like '%" +search+ "%' order by B.reg_date desc)) where r >= ? and r <= ?";
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
				String sql = "delete from board where exists(select * from member where board.id = member.id AND board.id = ?)";
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
		   
	public int deleteMember(String id) {//adminMemberDeleteForm
      
	      PreparedStatement pstmt = null;
	      Connection conn = null;
	      String sql = null;
	      int result = 0;
	      
	      try {
	         conn = getConnection();	         
	         sql = "delete from member where id=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(0, id);
	         
	         result = pstmt.executeUpdate();	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(pstmt != null) try {pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
	         if(conn != null) try {conn.close(); }catch(Exception e) { e.printStackTrace(); }	         
	      }
	      return result;    
   }
		      
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


	
}
