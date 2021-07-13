package anitel.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class PetDAO {	
	// 싱글턴 
		private static PetDAO instance = new PetDAO(); 
		private PetDAO() {}
		public static PetDAO getInstance() { return instance; }
	
		private Connection getConnection() throws Exception{
			Context ctx= new InitialContext();
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds=(DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
	
		//반려동물 마리수만큼 이름 가져오는메소드 (petSelect)
		public List getPetName(String id) {
			
			List petlist = null;
			PetDTO dto = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select pet_name,pet_num from pet where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					petlist = new ArrayList();
					do{
						dto = new PetDTO();
						dto.setPet_name(rs.getString("pet_name"));
						dto.setPet_num(rs.getInt("pet_num"));
						petlist.add(dto);
					}while(rs.next());
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
			}
			return petlist;
			
		}
		
		
		//id, pet_num 받아서 회원의 펫 정보 불러오는 메서드 (petinfoModifyForm)
		public PetDTO getPet(String id, int pet_num) {
			
			PetDTO dto = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select pet_name, pet_type, pet_etctype, pet_gender, pet_operation, pet_age, pet_big from pet where id=? and pet_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, pet_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new PetDTO();
					dto.setPet_name(rs.getString(1));
					dto.setPet_type(rs.getInt(2));
					dto.setPet_etctype(rs.getString(3));
					dto.setPet_gender(rs.getInt(4));
					dto.setPet_operation(rs.getInt(5));
					dto.setPet_age(rs.getString(6));
					dto.setPet_big(rs.getInt(7));
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
		
		
		
		public PetDTO getSearchPet(String id, String name) {			
			PetDTO dto = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select pet_name, pet_type, pet_etctype, pet_gender, pet_operation, pet_age, pet_big from pet where id=? AND pet_name =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, name);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new PetDTO();
					dto.setPet_name(rs.getString(1));
					dto.setPet_type(rs.getInt(2));
					dto.setPet_etctype(rs.getString(3));
					dto.setPet_gender(rs.getInt(4));
					dto.setPet_operation(rs.getInt(5));
					dto.setPet_age(rs.getString(6));
					dto.setPet_big(rs.getInt(7));
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


		//펫 정보 수정 메서드 (petinfoModifyForm)
		public int updatePet(String id, PetDTO pet) {
			Connection conn= null;
			PreparedStatement pstmt= null;
			int result= -1;
			
			try {
				conn= getConnection();
				String sql="update pet set pet_name=?, pet_type=?, pet_etctype=?, pet_gender=?, pet_operation=?, pet_age=?, pet_big=? where id=? and pet_num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, pet.getPet_name());
				pstmt.setInt(2, pet.getPet_type());
				pstmt.setString(3, pet.getPet_etctype());
				pstmt.setInt(4, pet.getPet_gender());
				pstmt.setInt(5, pet.getPet_operation());
				pstmt.setString(6, pet.getPet_age());
				pstmt.setInt(7, pet.getPet_big());
				pstmt.setString(8, id);
				pstmt.setInt(9, pet.getPet_num());
				result=pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt !=null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
				if(conn !=null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		
			}
			return result;	
		}
		
		
		//펫 추가 메서드 (petAddForm)
		public int insertPet(String id, PetDTO dto) {
			int result=0;
			Connection conn = null;
			PreparedStatement  pstmt = null;
			ResultSet rs=null;
			try {
				conn = getConnection();
				
				String sql="insert into pet values(pet_seq.nextval,?,?,?,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, dto.getPet_name());
				pstmt.setInt(3, dto.getPet_type());
				pstmt.setString(4, dto.getPet_etctype());
				pstmt.setInt(5, dto.getPet_gender());
				pstmt.setInt(6, dto.getPet_operation());
				pstmt.setString(7, dto.getPet_age());
				pstmt.setInt(8, dto.getPet_big());
				result = pstmt.executeUpdate();
				
			}catch(Exception e) {
					e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }				
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
			}
			return result;
		}
		
		//반려동물 삭제	 메서드   
		public int deletePet (int pet_num) {
			Connection conn=null;
			PreparedStatement pstmt=null;
			int result=0;
			try {
				conn= getConnection();
			    String sql="delete from pet where pet_num=?";				
                pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, pet_num);
				result=pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
	
		}
		
		//반려동물삭제할때 펫넘버 받아오는 메서드 (popupPro"8" )
		public int getPetNum (String id) {
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int result=0;
			try {
				conn= getConnection();
			    String sql="select pet_num from pet where id=?";				
                pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
	
		}
		
		
		//펫이름 가져오는 메서드 
		public int getBookingPet (int pet_num) {
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int result=0;
			try {
				conn= getConnection();
			    String sql="select pet_name from pet where pet_num=?";				
                pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, pet_num);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
	
		}
		
		
}	
