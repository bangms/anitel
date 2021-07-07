package anitel.model;

public class HotelDTO {
	// 검색할 때 DAO 보낼
	private String hotel_area; 
	private String check_in;
	private String check_out;
	private int pet_type;
	// 검색된 호텔리스트 뿌려주기
	private String id;
	private String hotel_name;
	private String img;
	private String util_pool;
	private String util_ground;
	private String util_parking;
	private String paid_bath;
	private String paid_beauty;
	private String paid_medi;
	private String pet_big;
	private String hotel_intro;
	private String d_fee;
	public String getHotel_area() {
		return hotel_area;
	}
	public void setHotel_area(String hotel_area) {
		this.hotel_area = hotel_area;
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
	public int getPet_type() {
		return pet_type;
	}
	public void setPet_type(int pet_type) {
		this.pet_type = pet_type;
	}
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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
	public String getPet_big() {
		return pet_big;
	}
	public void setPet_big(String pet_big) {
		this.pet_big = pet_big;
	}
	public String getHotel_intro() {
		return hotel_intro;
	}
	public void setHotel_intro(String hotel_intro) {
		this.hotel_intro = hotel_intro;
	}
	public String getD_fee() {
		return d_fee;
	}
	public void setD_fee(String d_fee) {
		this.d_fee = d_fee;
	}
	
}
