package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	// 싱글턴
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
			pstmt.setString(8, member.getHotel_area() + " " +member.getHotel_add());
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
	// 아이디 비밀번호 체크
	public boolean idPwCheck(String id, String pw) {
		boolean result = false;	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();	
			String sql = "select * from member where id=? and member_pw=?";
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
	

	// 노현호 작성 - id 받아서 해당 '사업자 회원' 개인정보 불러오기 (memberMyPage.jsp, memberModifyForm.jsp 에서 사용함)
	public MemberDTO getMember(String id) {
		MemberDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id, member_name, member_phone, member_email from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString(1));
				dto.setMember_name(rs.getString(2));
				dto.setMember_phone(rs.getString(3));
				dto.setMember_email(rs.getString(4));
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
	
	// 노현호 작성 - id 받아서 해당 '사업자 회원' 호텔정보 불러오기 (memberHInfo.jsp 에서 사용함)
	public MemberDTO getMemberHotel(String id) {
		MemberDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select hotel_name, hotel_owner, hotel_area, hotel_add, hotel_phone, reg_num, member_approved, hold_reason, member_name, id from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setHotel_name(rs.getString(1));
				dto.setHotel_owner(rs.getString(2));
				dto.setHotel_area(rs.getString(3));
				dto.setHotel_add(rs.getString(4));
				dto.setHotel_phone(rs.getString(5));
				dto.setReg_num(rs.getString(6));
				dto.setMember_approved(rs.getInt(7));
				dto.setHold_reason(rs.getString(8));
				dto.setMember_name(rs.getString(9));
				dto.setId(rs.getString(10));
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
	
	// 노현호 작성 - id, dto 받아서 해당 '사업자 회원' 개인정보 수정하기 (memberModifyPro.jsp 에서 사용함)
	public int memberModify(String id, MemberDTO dto){
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update member set member_name=?, member_phone=?, member_email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMember_name());
			pstmt.setString(2, dto.getMember_phone());
			pstmt.setString(3, dto.getMember_email());
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
	
	// 노현호 작성 - id pw 받아서 해당 '사업자 회원' 비밀번호 변경하기 (memberModifyPwPro.jsp 에서 사용함)
		public int memberModifyPw(String id, String pw_now, String pw, String pw2){
			int result = -1;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select id, member_pw from member where id=? and member_pw=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw_now);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(pw.equals(pw2)) {
						sql = "update member set member_pw=? where id=?";
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
	
	// 노현호 작성 사업자회원 호텔정보 업데이트
	public int memberHModify(String id, MemberDTO dto) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select hotel_name, hotel_owner, hotel_area, hotel_add, hotel_phone, reg_num, member_approved from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 사업자 등록번호 변동이 없을 경우
				if(dto.getReg_num().equals(rs.getString("reg_num"))) {
					sql = "update member set hotel_name=?, hotel_owner=?, hotel_area=?, hotel_add=?, hotel_phone=?, reg_num=? where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getHotel_name());
					pstmt.setString(2, dto.getHotel_owner());
					pstmt.setString(3, dto.getHotel_area());
					pstmt.setString(4, dto.getHotel_add());
					pstmt.setString(5, dto.getHotel_phone());
					pstmt.setString(6, dto.getReg_num());
					pstmt.setString(7, id);
					result = pstmt.executeUpdate();
				// 사업자 등록번호 변동이 있을 경우
				}else {
					sql = "update member set hotel_name=?, hotel_owner=?, hotel_area=?, hotel_add=?, hotel_phone=?, reg_num=?, member_approved=? where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getHotel_name());
					pstmt.setString(2, dto.getHotel_owner());
					pstmt.setString(3, dto.getHotel_area());
					pstmt.setString(4, dto.getHotel_add());
					pstmt.setString(5, dto.getHotel_phone());
					pstmt.setString(6, dto.getReg_num());
					pstmt.setInt(7, 0);
					pstmt.setString(8, id);
					result = pstmt.executeUpdate();
					result ++;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		// result 값이 -1 : 변경 실패, 1 : 변경 완료(사업자등록번호 변동없음), 2 : 변경 완료(사업자등록번호 변동 있음) 
		return result;
	}
	
	// 노현호 작성 - pw 넣어서 '사업자회원' 비밀번호 일치 여부 확인(popupPro.jsp에서 사용)
	public int matchMemberPw(String id, String pw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id from member where id=? and member_pw=?";
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
		// result 값이 -1 : 현재 비밀번호 불일치, 0 : 새 비밀번호간 불일치, 1 : 변경 완료 
		return result;
	}
	
	// 노현호 작성 - pw 넣어서 '사업자회원' 탈퇴(popupPro.jsp에서 사용)
	public int deleteMember(String id, String pw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select id, member_pw from member where id=? and member_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "delete from member where id=? and member_pw=?";
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
	
	// 기간이 경과하지 않은 호텔 예약 목록
	public List getBookingList(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List bookingList = null;
		System.out.println("getBookingList 실행");
		try {
			conn = getConnection();
			String sql = "select b.booking_num, r.name, b.booking_time, b.check_in, b.check_out, b.user_name, b.user_phone, p.pet_name, b.requests, b.payment, b.booking_status from booking b, room r, pet p where b.room_num = r.room_num and b.pet_num = p.pet_num and r.id=? and b.booking_status = 2 order by r.name, b.check_in, b.check_out";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			System.out.println("id : " + id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bookingList = new ArrayList();
				do {
					System.out.println("do 반복문 실행");
					BKListDTO dto = new BKListDTO();
					dto.setBooking_num(rs.getInt("booking_num"));
					dto.setName(rs.getString("name"));
					dto.setBooking_time(rs.getTimestamp("booking_time"));
					dto.setCheck_in(rs.getTimestamp("check_in"));
					dto.setCheck_out(rs.getTimestamp("check_out"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setPet_name(rs.getString("pet_name"));
					dto.setRequests(rs.getString("requests"));
					dto.setPayment(rs.getInt("payment"));
					bookingList.add(dto);	
				}while(rs.next());
				System.out.println("do 반복문 종료");
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		System.out.println("getBookingList 종료");
		return bookingList;
	}
	
	// 기간이 경과한 호텔 예약 목록
	public List getAfterBookingList(String id, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List bookingList = null;
		System.out.println("getAfterBookingList 실행");
		try {
			conn = getConnection();
			String sql = "select B.* from (select A.*, rownum r from (select b.booking_num, r.name, b.booking_time, b.check_in, b.check_out, b.user_name, b.user_phone, p.pet_name, b.requests, b.payment, b.booking_status from booking b, room r, pet p where b.room_num = r.room_num and b.pet_num = p.pet_num and r.id=? and b.booking_status != 2 order by r.name, b.check_in, b.check_out) A ) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			System.out.println("id : " + id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bookingList = new ArrayList();
				do {
					System.out.println("do 반복문 실행");
					BKListDTO dto = new BKListDTO();
					dto.setBooking_num(rs.getInt("booking_num"));
					dto.setName(rs.getString("name"));
					dto.setBooking_time(rs.getTimestamp("booking_time"));
					dto.setCheck_in(rs.getTimestamp("check_in"));
					dto.setCheck_out(rs.getTimestamp("check_out"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setPet_name(rs.getString("pet_name"));
					dto.setRequests(rs.getString("requests"));
					dto.setPayment(rs.getInt("payment"));
					dto.setBooking_status(rs.getInt("booking_status"));
					bookingList.add(dto);	
				}while(rs.next());
				System.out.println("do 반복문 종료");
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		System.out.println("getAfterBookingList 종료");
		return bookingList;
	}
	
	// 예약자 이름(user_name)을 이용하여 booking 테이블의 예약 삭제
	public int deleteBooking(String num) {
		System.out.println("deleteBooking 실행");
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			System.out.println("sql문 실행");
			String sql = "update booking set booking_status=1 where booking_num = ?";
			System.out.println("sql문 실행종료");
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			result = pstmt.executeUpdate();
			System.out.println("실행 결과" + result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		System.out.println("deleteBooking 종료");
		return result;
	}
	
	
	
	// 사업자 id를 넣어 기간이 경과 + 취소한 예약 수를 가져오는 메서드
	public int getBookingCount(String id) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select count(*) from booking b, room r, pet p where b.room_num = r.room_num and b.pet_num = p.pet_num and r.id=? and b.booking_status!=2";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	// '검색 된' 기간이 경과한 예약 수를 가져오는 메서드(사업자 id 필요 / 회원 id, 회원 연락처로 검색)
	public int getBookingSearchCount(String id, String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try {
			conn = getConnection();
			String sql = "select count(*) from booking b, room r, pet p where b.room_num = r.room_num and b.pet_num = p.pet_num and b.booking_status!=2 and r.id=? and " + sel + " like '%" + search + "%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	// 기간이 경과한 '검색 된' 호텔 예약 목록 
	public List getAfterBookingListSearch(String id, int start, int end, String sel, String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List bookingList = null;
		try {
			conn = getConnection();
			String sql = "select B.* from (select A.*, rownum r from (select b.booking_num, r.name, b.booking_time, b.check_in, b.check_out, b.user_name, b.user_phone, p.pet_name, b.requests, b.payment, b.booking_status from booking b, room r, pet p where b.room_num = r.room_num and b.pet_num = p.pet_num and r.id=? and b.booking_status != 2 and " +sel+ " like '%" + search+ "%' order by r.name, b.check_in, b.check_out) A ) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bookingList = new ArrayList();
				do {
					System.out.println("do 반복문 실행");
					BKListDTO dto = new BKListDTO();
					dto.setBooking_num(rs.getInt("booking_num"));
					dto.setName(rs.getString("name"));
					dto.setBooking_time(rs.getTimestamp("booking_time"));
					dto.setCheck_in(rs.getTimestamp("check_in"));
					dto.setCheck_out(rs.getTimestamp("check_out"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_phone(rs.getString("user_phone"));
					dto.setPet_name(rs.getString("pet_name"));
					dto.setRequests(rs.getString("requests"));
					dto.setPayment(rs.getInt("payment"));
					bookingList.add(dto);	
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
	}
}
