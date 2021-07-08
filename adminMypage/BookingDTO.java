package anitel.model;

import java.sql.Timestamp;

public class BookingDTO {
	private int booking_num;
	private String id;
	private int room_num;
	private String user_name;
	private String user_phone;
	private String user_email;
	private int pet_num;
	private String requests;
	private int paid_bath;
	private int paid_beauty;
	private int paid_medi;
	private Timestamp check_in;
	private Timestamp check_out;
	private int booking_status;
	private int payment;
	public int getBooking_num() {
		return booking_num;
	}
	public void setBooking_num(int booking_num) {
		this.booking_num = booking_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public int getPet_num() {
		return pet_num;
	}
	public void setPet_num(int pet_num) {
		this.pet_num = pet_num;
	}
	public String getRequests() {
		return requests;
	}
	public void setRequests(String requests) {
		this.requests = requests;
	}
	public int getPaid_bath() {
		return paid_bath;
	}
	public void setPaid_bath(int paid_bath) {
		this.paid_bath = paid_bath;
	}
	public int getPaid_beauty() {
		return paid_beauty;
	}
	public void setPaid_beauty(int paid_beauty) {
		this.paid_beauty = paid_beauty;
	}
	public int getPaid_medi() {
		return paid_medi;
	}
	public void setPaid_medi(int paid_medi) {
		this.paid_medi = paid_medi;
	}
	public Timestamp getCheck_in() {
		return check_in;
	}
	public void setCheck_in(Timestamp check_in) {
		this.check_in = check_in;
	}
	public Timestamp getCheck_out() {
		return check_out;
	}
	public void setCheck_out(Timestamp check_out) {
		this.check_out = check_out;
	}
	public int getBooking_status() {
		return booking_status;
	}
	public void setBooking_status(int booking_status) {
		this.booking_status = booking_status;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}

}

