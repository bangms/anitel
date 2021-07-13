package anitel.model;

import java.sql.Timestamp;

public class BKListDTO {
   private String hotel_name, name, user_name, user_phone, pet_name, requests;
   private int booking_num, payment, booking_status;
   private Timestamp booking_time, check_in, check_out;
   
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
   public String getUser_phone() {
	   return user_phone;
   }
   public void setUser_phone(String user_phone) {
	   this.user_phone = user_phone;
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
   public int getBooking_num() {
	   return booking_num;
   }
   public void setBooking_num(int booking_num) {
	   this.booking_num = booking_num;
   }
   public int getPayment() {
	   return payment;
   }
   public void setPayment(int payment) {
	   this.payment = payment;
   }
   public Timestamp getBooking_time() {
	   return booking_time;
   }
   public void setBooking_time(Timestamp booking_time) {
	   this.booking_time = booking_time;
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
}
