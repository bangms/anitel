package anitel.model;

import java.sql.Timestamp;

public class ReserveDTO {
	private String hotel_name, name, user_name, pet_name, requests, hotel_img;
	private int booking_num, paid_bath, paid_beauty, paid_medi, booking_status;
	private Timestamp check_in, check_out;
	
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public String getRequests() {
		return requests;
	}
	public void setRequests(String requests) {
		this.requests = requests;
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
	public int getBooking_num() {
		return booking_num;
	}
	public void setBooking_num(int booking_num) {
		this.booking_num = booking_num;
	}
	public int getBooking_status() {
		return booking_status;
	}
	public void setBooking_status(int booking_status) {
		this.booking_status = booking_status;
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
	public String getHotel_img() {
		return hotel_img;
	}
	public void setHotel_img(String hotel_img) {
		this.hotel_img = hotel_img;
	}
	
}