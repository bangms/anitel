package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BoardDAO {
	private static BoardDAO instance = new BoardDAO();
	private BoardDAO() {}
	public static BoardDAO getInstance() { return instance; }

	// 커넥션 메서드 : 내부에서만 사용할거라 private 접근 제어자
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	// 게시글 전체 글 갯수 가져오기 
	public int getArticleCount(int categ) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select count(*) from board where categ =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);

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
	// 게시글 범위만큼 가져오는 메서드
	public List getArticles (int start, int end, int categ) {  
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;

		try {
			conn = getConnection();  
			//간단버전  
			String sql = "select b.*, r " 
					+"from (select A.*, rownum r from "
					+"(select * from board where categ = ? order by reg_date desc) A order by reg_date desc) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			if(rs.next()) { // 결과가 있으면
				articleList = new ArrayList(); // arraylist 객체 생성

				do {
					BoardDTO article = new BoardDTO();
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
					articleList.add(article);  

				} while (rs.next()); // 없으면 null
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}   
		return articleList;
	}
	
	// 이미지게시판 검색된 글의 개수 가져오기
	public int getSearchArticleCount(int categ, String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select count(*) from board where categ=? and " + sel + " like '%" + search + "%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return count;
	}
	
	// 이미지게시판 검색한 글들 가져오기
	public List getSearchArticles(int categ, int start, int end, String sel, String search ) {
		List articleList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select B.* "
					+ "from (select A.*, rownum r "
					+ "from (select * from board where categ=? and " + sel + " like '%" + search + "%' order by reg_date desc) A order by reg_date desc) B where r >= ? and r <= ?";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);   
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList();		 
				do {
					BoardDTO article = new BoardDTO();
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
					articleList.add(article); 
				}while(rs.next());
			}									 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return articleList;
	}

	// 컨텐트 가져오기 
	public BoardDTO getArticle(int board_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO article = null;

		try {
			conn = getConnection();

			// 조회수 올리기
			String sql = "update board set readcount=readcount+1 where board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();

			// 글 가져오기 
			sql = "SELECT * FROM board WHERE board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				//System.out.println("dao article " + rs.getString("subject"));
				article = new BoardDTO(); // 객체 생성
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
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return article;
	}

	// 글 저장 메서드 insertArticle
		public void insertArticle(BoardDTO article) { 
			Connection conn = null;
			PreparedStatement pstmt = null;
			System.out.println(article.getSubject());

			try {
				conn = getConnection(); 
				String sql = "insert into board values(board_seq.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getId());
				pstmt.setString(2, article.getReg_num());
				pstmt.setInt(3, article.getCateg());
				pstmt.setString(4, article.getSubject());
				pstmt.setString(5, article.getPw());
				pstmt.setString(6, article.getCtt());
				pstmt.setString(7, article.getImg());
				pstmt.setTimestamp(8, article.getReg_date());
				pstmt.setTimestamp(9, article.getReply_date());
				pstmt.setString(10, article.getReply_content());
				pstmt.setInt(11, 0);
				pstmt.setInt(12, article.getComm());
				pstmt.setInt(13, article.getHidden_content());

				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {

				if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
			}
		}
	
	//글 수정 가져오기 
	public BoardDTO getUpdateArticle(int board_num, int categ) {
		BoardDTO article = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn=getConnection();
			String sql = "SELECT * FROM board WHERE board_num = ? and categ=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.setInt(2, categ);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				article = new BoardDTO(); // 객체 생성
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }	
		}

		return article;
	}

	// 게시글 수정 updateArticle
	public int updateArticle(BoardDTO dto, int categ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;

		try {
			conn=getConnection();
			//비밀번호 확인 -> 비밀번호 오류 수정안함 =0, 비밀번호 맞아서 수정되면 =1 (executeUpdate()리턴값)
			String sql = "select pw from board where categ=? and board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCateg()); 
			pstmt.setInt(2, dto.getBoard_num()); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String dbpw = rs.getString("pw");
				if(dbpw.equals(dto.getPw())) {
					sql = "update board set subject=?, ctt=?, img=? where board_num=? and categ=?";
					pstmt= conn.prepareStatement(sql); 
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getCtt());
					pstmt.setString(3, dto.getImg());
					pstmt.setInt(4, dto.getBoard_num());
					pstmt.setInt(5, dto.getCateg());
					result = pstmt.executeUpdate();   
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
	
	// 게시판 수정 (관리자용) //다희 추가 
	public int modifyArticleAdmin(BoardDTO dto, int categ)  {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
 
		try {
			conn = getConnection(); 
			String sql = "update board set subject=?, ctt=?, img=? where board_num=? and categ=?";
			pstmt= conn.prepareStatement(sql); 
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getCtt());
			pstmt.setString(3, dto.getImg());
			pstmt.setInt(4, dto.getBoard_num());
			pstmt.setInt(5, dto.getCateg());
			result = pstmt.executeUpdate();  
		 		 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// path만들기 위헤 img 가져오기 
	public String getPhoto(int board_num, int categ){
		String photo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select img from board where categ=? and board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setInt(2, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				photo = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return photo;
	}

	//게시판 삭제(일반 사용자)
	public int deleteArticle(int board_num, String pw, int categ) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			// 비밀번호 확인 : 오류/수정불가 = 0, 수정 = 1
			String sql = "select pw from Board where categ=? and board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setInt(2, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pw.equals(rs.getString("pw"))) {
					// 게시글 삭제
					sql = "delete from Board where categ=? and board_num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, categ);
					pstmt.setInt(2, board_num);
					result = pstmt.executeUpdate();
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}

	// 게시판 삭제(관리자용)
	public int deleteArticleAdmin(int board_num, int categ) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
 
		try {
			conn = getConnection(); 
			String sql = "delete from Board where categ=? and board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setInt(2, board_num);
			result = pstmt.executeUpdate(); 
		 		 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	//답변 저장 하기
	public int updateReply (BoardDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result=-1;
		try {
			conn=getConnection();
			String sql ="update board set reply_content=?, comm ='1' where board_num= ? and categ=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getReply_content());
			pstmt.setInt(2, dto.getBoard_num());
			pstmt.setInt(3, dto.getCateg());
			
			System.out.println("--dao");
			System.out.println(dto.getReply_content());
			System.out.println(dto.getBoard_num());
			System.out.println(dto.getCateg());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	//비밀글 비번 체크 checkpw
	   public boolean checkpw(int board_num, String pw) {
	      System.out.println("checkpw num= " + board_num + " " + pw);
	      boolean result = false;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      try {
	         conn = getConnection();
	         String sql = "select pw from board where board_num = ?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, board_num);
	         
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            String dbpw = rs.getString("pw");
	            System.out.println("dbpw / pw " + dbpw + " " + pw);
	            if(dbpw.equals(pw)) {
	               System.out.println("서버랑 비밀번호 일치");
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
	   
	   // 결제회원 아이디 확인 // 윤지 추가
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
	   
	   // 일반 회원인지 아이디 확인 // 윤지 추가
	   public boolean userCk(String id) {
		   boolean result = false;
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   try {
		         conn = getConnection();
		         String sql = "select id from users where id = ?";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, id);
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
	   
	   // 사업자 회원인지 아이디 확인 // 윤지 추가
	   public boolean memberCk(String id) {
		   boolean result = false;
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   try {
		         conn = getConnection();
		         String sql = "select id from member where id = ?";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, id);
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
	   // 일반 회원인지 아이디 확인 // 윤지 추가 
	   public int idCk(String id) {
		   int result = -1;
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   try {
		         conn = getConnection();
		         String sql = "select id from users where id = ?";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, id);
		         rs = pstmt.executeQuery();
		         if(rs.next()) {
		        	 String userId = rs.getString("id");
		        	 if(userId.equals(id)) {
		        		 // 일반회원이면 1 리턴
		        		 result = 1;
		        	 }
		         } else {
		        	 sql = "select id from member where id = ?";
	        		 pstmt = conn.prepareStatement(sql);
			         pstmt.setString(1, id);
			         rs = pstmt.executeQuery();
			         if(rs.next()) {
			        	 String memId = rs.getString("id");
			        	 if(memId.equals(id)) {
			        		 result = 2; // 사업자 회원이면 2 리턴
			        	 }
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
	   
		// 사업자 QnA, 후기용 게시글 갯수 로드 메서드
		public int getQnaArticleCount(int categ, String reg_num) {
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
		
		// 사업자QnA, 후기용 게시글 로드 메서드
		public List getQnaArticles (int start, int end, int categ, String reg_num) {  
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List articleList = null;

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
					articleList = new ArrayList(); // arraylist 객체 생성

					do {
						BoardDTO article = new BoardDTO();
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
						articleList.add(article);  

					} while (rs.next()); // 없으면 null
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
			}   
			return articleList;
		}
		
		// 사업자용 QnA, 후기 검색용 게시글 갯수 로드 메서드
		public int getSearchQnaArticleCount(int categ, String sel, String search, String reg_num) {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select count(*) from board where categ=? and reg_num=? and " + sel + " like '%" + search + "%'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, categ);
				pstmt.setString(2, reg_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return count;
		}
		
		// 사업자용 QnA, 후기 검색용 게시글 로드 메서드
		public List getSearchQnaArticles(int categ, int start, int end, String sel, String search, String reg_num) {
			List articleList = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select B.* "
						+ "from (select A.*, rownum r "
						+ "from (select * from board where categ=? and reg_num=? and " + sel + " like '%" + search + "%' order by reg_date desc) A order by reg_date desc) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, categ);
				pstmt.setString(2, reg_num);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					articleList = new ArrayList();		 
					do {
						BoardDTO article = new BoardDTO();
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
						articleList.add(article); 
					}while(rs.next());
				}									 
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return articleList;
		}

	// 보드넘버 넣고 답글 꺼내기
	public String getReply(int board_num) {
		String reply = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select reply_content from board where board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1)!=null) {
					reply = rs.getString(1);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return reply;
	}
	// 일반회원 Qna 전체 게시글 갯수 로드 메서드
	public int getuserQnaCount(int categ, String id) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select count(*) from board where categ = ? and id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
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
	
	// 일반회원 Qna 게시글 로드 메서드
	public List getuserQna (int start, int end, int categ, String id) {  
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;

		try {
			conn = getConnection();  
			String sql="select * from (select rownum r, board_num, id, reg_num, categ, subject, pw, ctt, img, reg_date, reply_date, reply_content, readcount, comm, hidden_content, hotel_name "
			+ "from (Select b.*, m.hotel_name from board b, member m where m.reg_num = b.reg_num ORDER BY b.reg_date desc)where categ = ? AND id = ?) where r >= ? AND r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categ);
			pstmt.setString(2, id);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();

			if(rs.next()) { // 결과가 있으면
				articleList = new ArrayList(); // arraylist 객체 생성

				do {
					UserBoardDTO qna= new UserBoardDTO();
					qna.setBoard_num(rs.getInt("board_num"));
					qna.setId(rs.getString("id"));
					qna.setReg_num(rs.getString("reg_num"));
					qna.setCateg(rs.getInt("categ"));
					qna.setSubject(rs.getString("subject"));
					qna.setPw(rs.getString("pw"));
					qna.setCtt(rs.getString("ctt"));
					qna.setImg(rs.getString("img"));
					qna.setReg_date(rs.getTimestamp("reg_date"));
					qna.setReply_date(rs.getTimestamp("reply_date"));
					qna.setReply_content(rs.getString("reply_content"));
					qna.setReadcount(rs.getInt("readcount"));
					qna.setComm(rs.getInt("comm"));
					qna.setHidden_content(rs.getInt("hidden_content"));
					qna.setHotel_name(rs.getString("hotel_name"));
					articleList.add(qna);  

				} while (rs.next()); // 없으면 null
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}   
		return articleList;
	}
}// close
