package anitel.model;

import java.sql.Timestamp;

public class DetailDTO {
	
	
		
		// 검색할 때 DAO 보낼
		private String id;
		
		private String hotel_name;
		private String hotel_intro;
		private String hotel_area; 
		private String util_pool;
		private String util_ground;
		private String util_parking;
		private String paid_bath;
		private String paid_beauty;
		private String paid_medi;
		private String hotel_img;
		private String hotel_add;
		
		// 검색 호텔정보 룸 뿌려줄 
		private int room_num;
		private String name;
		private int pet_type;
		private int pet_etctype;
		private String d_fee;
		private int pet_big;
		private String img;
		
 
		private String check_in;
		private String check_out;
		
		
		//게시판 뿌려줄
		private int board_num;
		private String reg_num;
		private int categ;
		private String subject;
		private String pw;
		private String ctt;
		private Timestamp reg_date;
		private Timestamp reply_date;
		private String reply_content;
		private int readcount;
		private int comm;
		private int hidden_content;
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getHotel_name() {
			return hotel_name;
		}
		public void setHotel_name(String hotel_name) {
			this.hotel_name = hotel_name;
		}
		public String getHotel_intro() {
			return hotel_intro;
		}
		public void setHotel_intro(String hotel_intro) {
			this.hotel_intro = hotel_intro;
		}
		public String getHotel_area() {
			return hotel_area;
		}
		public void setHotel_area(String hotel_area) {
			this.hotel_area = hotel_area;
		}
		public String getUtil_pool() {
			return util_pool;
		}
		public void setUtil_pool(String util_pool) {
			this.util_pool = util_pool;
		}
		public String getUtil_ground() {
			return util_ground;
		}
		public void setUtil_ground(String util_ground) {
			this.util_ground = util_ground;
		}
		public String getUtil_parking() {
			return util_parking;
		}
		public void setUtil_parking(String util_parking) {
			this.util_parking = util_parking;
		}
		public String getPaid_bath() {
			return paid_bath;
		}
		public void setPaid_bath(String paid_bath) {
			this.paid_bath = paid_bath;
		}
		public String getPaid_beauty() {
			return paid_beauty;
		}
		public void setPaid_beauty(String paid_beauty) {
			this.paid_beauty = paid_beauty;
		}
		public String getPaid_medi() {
			return paid_medi;
		}
		public void setPaid_medi(String paid_medi) {
			this.paid_medi = paid_medi;
		}
		public String getHotel_img() {
			return hotel_img;
		}
		public void setHotel_img(String hotel_img) {
			this.hotel_img = hotel_img;
		}
		public String getHotel_add() {
			return hotel_add;
		}
		public void setHotel_add(String hotel_add) {
			this.hotel_add = hotel_add;
		}
		public int getRoom_num() {
			return room_num;
		}
		public void setRoom_num(int room_num) {
			this.room_num = room_num;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getPet_type() {
			return pet_type;
		}
		public void setPet_type(int pet_type) {
			this.pet_type = pet_type;
		}
		public int getPet_etctype() {
			return pet_etctype;
		}
		public void setPet_etctype(int pet_etctype) {
			this.pet_etctype = pet_etctype;
		}
		public String getD_fee() {
			return d_fee;
		}
		public void setD_fee(String d_fee) {
			this.d_fee = d_fee;
		}
		public int getPet_big() {
			return pet_big;
		}
		public void setPet_big(int pet_big) {
			this.pet_big = pet_big;
		}
		public String getImg() {
			return img;
		}
		public void setImg(String img) {
			this.img = img;
		}
		public String getCheck_in() {
			return check_in;
		}
		public void setCheck_in(String check_in) {
			this.check_in = check_in;
		}
		public String getCheck_out() {
			return check_out;
		}
		public void setCheck_out(String check_out) {
			this.check_out = check_out;
		}
		public int getBoard_num() {
			return board_num;
		}
		public void setBoard_num(int board_num) {
			this.board_num = board_num;
		}
		public String getReg_num() {
			return reg_num;
		}
		public void setReg_num(String reg_num) {
			this.reg_num = reg_num;
		}
		public int getCateg() {
			return categ;
		}
		public void setCateg(int categ) {
			this.categ = categ;
		}
		public String getSubject() {
			return subject;
		}
		public void setSubject(String subject) {
			this.subject = subject;
		}
		public String getPw() {
			return pw;
		}
		public void setPw(String pw) {
			this.pw = pw;
		}
		public String getCtt() {
			return ctt;
		}
		public void setCtt(String ctt) {
			this.ctt = ctt;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
		public Timestamp getReply_date() {
			return reply_date;
		}
		public void setReply_date(Timestamp reply_date) {
			this.reply_date = reply_date;
		}
		public String getReply_content() {
			return reply_content;
		}
		public void setReply_content(String reply_content) {
			this.reply_content = reply_content;
		}
		public int getReadcount() {
			return readcount;
		}
		public void setReadcount(int readcount) {
			this.readcount = readcount;
		}
		public int getComm() {
			return comm;
		}
		public void setComm(int comm) {
			this.comm = comm;
		}
		public int getHidden_content() {
			return hidden_content;
		}
		public void setHidden_content(int hidden_content) {
			this.hidden_content = hidden_content;
		}
 
		

}
