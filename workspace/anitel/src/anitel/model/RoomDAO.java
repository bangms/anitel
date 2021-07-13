package anitel.model;
import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

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
			/*
			select count(distinct e.id) 
			from member m, (select d.id, d.img, d.d_fee, d.pet_big, d.pet_type from (select C.* from room C left outer join (select A.room_num from
			(SELECT * FROM booking WHERE check_in <= '2021-07-14' AND check_out >= '2021-07-12' and booking_status = 2) A) B on C.room_num=B.room_num where B.room_num is null) D
			where d.pet_type = 1) E where m.id = e.id and m.hotel_area like '대구%' and m.member_approved = 1
		 */
			String sql = "select count(distinct e.id)"
				+ " from member m, (select d.id,d.img, d.d_fee, d.pet_big, d.pet_type from (select C.* from room C left outer join (select A.room_num from"
				+ "	(SELECT * FROM booking WHERE check_in <= '"+hotel.getCheck_out()+"' AND check_out >= '"+hotel.getCheck_in()+"' and booking_status = 2) A) B on C.room_num=B.room_num where B.room_num is null) D"
				+ " where d.pet_type = "+hotel.getPet_type()+") E where m.id = E.id and m.hotel_area like '"+hotel.getHotel_area()+"%' and m.member_approved = 1";
			
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
		List<HotelDTO> hotelList = null;
		
		try {
			conn = getConnection();
			
			/*
		 	select m.id, m.hotel_name, e.img, e.d_fee, m.util_pool, m.util_ground, m.util_parking, m.paid_bath, m.paid_beauty, m.paid_medi, m.hotel_intro, e.pet_big
			from member m, (select d.id, d.img, d.d_fee, d.pet_big, d.pet_type from (select C.* from room C left outer join (select A.room_num from
			(SELECT * FROM booking WHERE check_in <= '2021-07-14' AND check_out >= '2021-07-12' and booking_status = 2) A) B on C.room_num=B.room_num where B.room_num is null) D
			where d.pet_type = 1) E where m.id = e.id and m.hotel_area like '대구%' and m.member_approved = 1; 
		 */
		String sql = "select m.id, m.hotel_name, m.hotel_img, e.d_fee, m.util_pool, m.util_ground, m.util_parking, m.paid_bath, m.paid_beauty, m.paid_medi, m.hotel_intro, e.pet_big"
				+ " from member m, (select d.id, d.img, d.d_fee, d.pet_big, d.pet_type from (select C.* from room C left outer join (select A.room_num from"
				+ " (SELECT * FROM booking WHERE check_in <= '"+selhotel.getCheck_out()+"' AND check_out >= '"+selhotel.getCheck_in()+"' and booking_status = 2) A) B on C.room_num=B.room_num where B.room_num is null) D"
				+ " where d.pet_type = "+selhotel.getPet_type()+") E where m.id = e.id and m.hotel_area like '"+selhotel.getHotel_area()+"%' and m.member_approved = 1";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 있으면
				hotelList = new ArrayList(); // list 객체 생성

				do {
					HotelDTO hotel = new HotelDTO();
					hotel.setId(rs.getString("id"));
					hotel.setHotel_name(rs.getString("hotel_name"));
					hotel.setImg(rs.getString("hotel_img"));
					hotel.setD_fee(rs.getString("d_fee"));
					hotel.setUtil_pool(rs.getString("util_pool"));
					hotel.setUtil_ground(rs.getString("util_ground"));
					hotel.setUtil_parking(rs.getString("util_parking"));
					hotel.setPaid_bath(rs.getString("paid_bath"));
					hotel.setPaid_beauty(rs.getString("paid_beauty"));
					hotel.setPaid_medi(rs.getString("paid_medi"));
					hotel.setHotel_intro(rs.getString("hotel_intro"));
					hotel.setPet_big(rs.getString("pet_big"));
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
		return hotelList.stream().distinct().collect(Collectors.toList());
	}
	// 세부검색 호텔 개수 가져오기
	public int getSubHotelCount(HotelDTO hotel, String subSql) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(distinct e.id)"
					+ " from member m, (select d.id, d.img, d.d_fee, d.pet_big, d.pet_type from (select C.* from room C left outer join (select A.room_num from"
					+ "	(SELECT * FROM booking WHERE check_in <= '"+hotel.getCheck_out()+"' AND check_out >= '"+hotel.getCheck_in()+"' and booking_status = 2) A) B on C.room_num=B.room_num where B.room_num is null) D"
					+ " where d.pet_type = "+hotel.getPet_type()+") E where m.id = E.id and m.hotel_area like '"+hotel.getHotel_area()+"%' and m.member_approved = 1";
			
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
		List<HotelDTO> hotelList = null;
		
		try {
			conn = getConnection();
			
			String sql = "select m.id, m.hotel_name, m.hotel_img, e.d_fee, m.util_pool, m.util_ground, m.util_parking, m.paid_bath, m.paid_beauty, m.paid_medi, m.hotel_intro, e.d_fee, e.pet_big, e.pet_type"
					+ " from member m, (select d.id, d.img, d.d_fee, d.pet_big, d.pet_type from (select C.* from room C left outer join (select A.room_num from"
					+ " (SELECT * FROM booking WHERE check_in <= '"+selhotel.getCheck_out()+"' AND check_out >= '"+selhotel.getCheck_in()+"' and booking_status = 2) A) B on C.room_num=B.room_num where B.room_num is null) D"
					+ " where d.pet_type = "+selhotel.getPet_type()+") E where m.id = e.id and m.hotel_area like '"+selhotel.getHotel_area()+"%' and m.member_approved = 1";
			
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
					hotel.setImg(rs.getString("hotel_img"));
					hotel.setD_fee(rs.getString("d_fee"));
					hotel.setUtil_pool(rs.getString("util_pool"));
					hotel.setUtil_ground(rs.getString("util_ground"));
					hotel.setUtil_parking(rs.getString("util_parking"));
					hotel.setPaid_bath(rs.getString("paid_bath"));
					hotel.setPaid_beauty(rs.getString("paid_beauty"));
					hotel.setPaid_medi(rs.getString("paid_medi"));
					hotel.setHotel_intro(rs.getString("hotel_intro"));
					hotel.setPet_big(rs.getString("pet_big"));
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
		return hotelList.stream().distinct().collect(Collectors.toList());
	}	
	
	
	
	// 방 개수 가져오기 (다희)
	public int getRoomCount(DetailDTO room, String id) {
		int roomCount = 0;
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from room r, "
					+ "(select C.* from room C left outer join (select A.room_num from "
					+ "(select * from booking WHERE check_in <= '" + room.getCheck_out() + "' AND check_out >= '" + room.getCheck_in() + "') A) B on C.room_num=B.room_num where B.room_num is null) d "
					+ "where r.room_num = d.room_num and r.pet_type = " + room.getPet_type() + " and r.id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// count(*) 은 결과를 숫자로 가져옴. 
				// 컬럼명 대신 컬럼번호로 꺼내서 count 변수에 담기
				roomCount = rs.getInt(1); 
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return roomCount;
	}
	
	// 방 리스트 가져오기(리스트->디테일) (다희)
		public List getRooms (DetailDTO selRoom, String id) { 
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List roomList = null;
			
			try {
				conn = getConnection();
				
				String sql ="select r.id, r.room_num, r.name, r.d_fee, r.pet_big, r.img from room r, "
						+ "(select C.* from room C left outer join "
						+ "(select A.room_num from "
						+ "(select * from booking where check_in <= '"+selRoom.getCheck_out()+"' and check_out >= '"+selRoom.getCheck_out()+"') A) B on C.room_num=B.room_num where B.room_num is null) d "
						+ "where r.room_num = d.room_num and r.pet_type="+selRoom.getPet_type()+" and r.id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { // 결과가 있으면
					roomList = new ArrayList(); // list 객체 생성

					do {
						DetailDTO room = new DetailDTO();
						room.setId(rs.getString("id"));
						room.setRoom_num(rs.getInt("room_num"));
						room.setName(rs.getString("name"));
						room.setD_fee(rs.getString("d_fee"));
						room.setPet_big(rs.getInt("pet_big"));
						room.setImg(rs.getString("img"));
						roomList.add(room); 
					} while (rs.next());
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
			}	
			return roomList;
		}
		
		// hotel detail 호텔 정보 (다희)
		public DetailDTO getHotelDetail(String id){  
			DetailDTO dto = null; // dto에 담을거야 
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			System.out.println(id);
			
			try {
				conn = getConnection();
				String sql = "select hotel_name, hotel_area, reg_num, hotel_intro, util_pool, util_ground, util_parking, paid_bath, paid_beauty, paid_medi, hotel_img, hotel_add from member where id=?";
				
				pstmt = conn.prepareStatement(sql);  
				pstmt.setString(1, id); 
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					do {
						dto = new DetailDTO(); 
						dto.setHotel_name(rs.getString(1));
						dto.setHotel_area(rs.getString(2));
						dto.setReg_num(rs.getString(3));
						dto.setHotel_intro(rs.getString(4));
						dto.setUtil_pool(rs.getString(5));
						dto.setUtil_ground(rs.getString(6));
						dto.setUtil_parking(rs.getString(7));
						dto.setPaid_bath(rs.getString(8));
						dto.setPaid_beauty(rs.getString(9));
						dto.setPaid_medi(rs.getString(10));
						dto.setHotel_img(rs.getString(11));
						dto.setHotel_add(rs.getString(12));
					} while (rs.next());
			
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}

			return dto;
		}
		

	// hotel detail 해달 게시글 수 구하기 (다희추가 )
	public int getReviewCount(int categ, String reg_num) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select count(*) from board where categ = ? and reg_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setString(2, reg_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// count(*) 은 결과를 숫자로 가져옴. 컬럼명 대신 컬럼번호로 꺼내서 count 변수에 담기
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
	 
	// hotel detail 게시판 가져오기 (다희추가 )
	public List getReviews (int start, int end, int categ, String reg_num) {
		List reviewList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();  
			//간단버전  
			String sql = "select b.*, r " 
					+"from (select A.*, rownum r from "
					+"(select * from board where categ = ? and reg_num = ? order by reg_date desc) A order by reg_date desc) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setString(2, reg_num);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();

			if(rs.next()) { // 결과가 있으면
				
				reviewList = new ArrayList();
				do {
					DetailDTO article = new DetailDTO();
					article.setBoard_num(rs.getInt("board_num"));
					article.setId(rs.getString("id"));
					article.setReg_num(rs.getString("reg_num"));
					article.setCateg(rs.getInt("categ"));
					article.setSubject(rs.getString("subject"));
					article.setPw(rs.getString("pw"));
					article.setCtt(rs.getString("ctt"));
					article.setImg(rs.getString("img"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReply_date(rs.getTimestamp("reply_date"));
					article.setReply_content(rs.getString("reply_content"));
					article.setReadcount(rs.getInt("readcount"));
					article.setComm(rs.getInt("comm"));
					article.setHidden_content(rs.getInt("hidden_content"));				
					reviewList.add(article); 				
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return reviewList;
	}
		
	   //hotel detail 후기게시판 글쓰기  결제회원 아이디 확인 (다희추가)
	   public boolean paymentUserCk(String id, String reg_num) { 
		   boolean result = false;
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   try {
		         conn = getConnection();
		         String sql = "Select b.id from booking b, room r, member m where m.id = r.id AND r.room_num = b.room_num AND b.booking_status = '0' AND m.reg_num = ? and b.id = ?";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, reg_num);
		         pstmt.setString(2, id);
		         rs = pstmt.executeQuery();
		         if(rs.next()) {
		        	 String dbid = rs.getString("id");
		        	 if(dbid.equals(id)) {
		        		 result = true;
		        	 }
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally { 
		         if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
		         if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
		         if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		      }
		   return result;
	   }
		


	// 노현호 작성 호텔 객실 추가
	public int insertRoom(String id, MultipartRequest mr, String sysName) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "insert into room(room_num, id, name, pet_type, d_fee, pet_big, img) values(room_seq.nextVal,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, mr.getParameter("name"));
			pstmt.setInt(3, Integer.parseInt(mr.getParameter("pet_type")));
			pstmt.setString(4, mr.getParameter("d_fee"));
			if(mr.getParameter("pet_big")==null) {
				pstmt.setInt(5, 0);
			}else {
				pstmt.setInt(5, Integer.parseInt(mr.getParameter("pet_big")));
			}
			pstmt.setString(6, sysName);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// 노현호 작성 사업자 id로 객설 리스트 불러오기
	public List getRoomList(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List roomList = null;
		try {
			conn = getConnection();
			String sql = "select * from room where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				roomList = new ArrayList();
				do {
					RoomDTO dto = new RoomDTO();
					dto.setRoom_num(rs.getInt("room_num"));
					dto.setId(id);
					dto.setName(rs.getString("name"));
					dto.setPet_type(rs.getInt("pet_type"));
					dto.setPet_etctype(rs.getString("pet_etcType"));
					dto.setD_fee(rs.getString("d_fee"));
					dto.setPet_big(rs.getInt("pet_big"));
					dto.setImg(rs.getString("img"));
					roomList.add(dto);	
				}while(rs.next());
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return roomList;
	}
	
	// 노현호 작성 room_num을 받아 객실 삭제
	public int deleteRoom(String num) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "delete from room where room_num=?";
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
	}
	
	// 노현호 작성 room_num을 받아 객실 불러오기
	public RoomDTO getRoom(int room_num) {
		RoomDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select name, pet_type, d_fee, pet_big, img from room where room_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, room_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new RoomDTO();
				dto.setName(rs.getString(1));
				dto.setPet_type(rs.getInt(2));
				dto.setD_fee(rs.getString(3));
				dto.setPet_big(rs.getInt(4));
				dto.setImg(rs.getString(5));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace(); }
		}
		return dto;
	}
	
	// 노현호 작성 객실 정보 수정(이미지 변동 없음)
	public int modifyRoom(String id, MultipartRequest mr, int room_num) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			System.out.println("SQL문 실행");
			String sql = "update room set name=?, pet_type=?, d_fee=?, pet_big=? where id=? and room_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mr.getParameter("name"));
			System.out.println(mr.getParameter("name"));
			pstmt.setInt(2, Integer.parseInt(mr.getParameter("pet_type")));
			System.out.println(Integer.parseInt(mr.getParameter("pet_type")));
			pstmt.setString(3, mr.getParameter("d_fee"));
			System.out.println(mr.getParameter("d_fee"));
			if(mr.getParameter("pet_big")==null) {
				pstmt.setInt(4, 0);
				System.out.println("0");
			}else {
				pstmt.setInt(4, Integer.parseInt(mr.getParameter("pet_big")));
				System.out.println(Integer.parseInt(mr.getParameter("pet_big")));
			}
			pstmt.setString(5, id);
			System.out.println(id);
			pstmt.setInt(6, room_num);
			System.out.println(room_num);
			result = pstmt.executeUpdate();
			System.out.println("SQL문 종료");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// 노현호 작성 객실 정보 수정(이미지 변동 있음)
	public int modifyRoom(String id, MultipartRequest mr, String sysName, int room_num) {
		int result = -1;
		System.out.println("modifyRoom - " + sysName);
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update room set name=?, pet_type=?, d_fee=?, pet_big=?, img=? where id=? and room_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mr.getParameter("name"));
			pstmt.setInt(2, Integer.parseInt(mr.getParameter("pet_type")));
			pstmt.setString(3, mr.getParameter("d_fee"));
			if(mr.getParameter("pet_big")==null) {
				pstmt.setInt(4, 0);
			}else {
				pstmt.setInt(4, Integer.parseInt(mr.getParameter("pet_big")));
			}
			pstmt.setString(5, sysName);
			pstmt.setString(6, id);
			pstmt.setInt(7, room_num);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
}// close

