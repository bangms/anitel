package anitel.model;

import java.sql.Timestamp;

public class ReviewDTO {

	private Timestamp Reg_date;
	private String Id;
	private String Hotel_name;
	private String Subject;
	private int Comm;
	private int Board_num;
	
	
	public Timestamp getReg_date() {
		return Reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		Reg_date = reg_date;
	}
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public String getHotel_name() {
		return Hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		Hotel_name = hotel_name;
	}
	public String getSubject() {
		return Subject;
	}
	public void setSubject(String subject) {
		Subject = subject;
	}
	public int getComm() {
		return Comm;
	}
	public void setComm(int comm) {
		Comm = comm;
	}
	public int getBoard_num() {
		return Board_num;
	}
	public void setBoard_num(int board_num) {
		Board_num = board_num;
	} 
	
	
	
	
}
