package anitel.model;

public class RoomDTO {
	private int room_num;
	private String id;
	private String name;
	private int pet_type;
	private String pet_etctype;
	private String d_fee;
	private int pet_big;
	private String img;
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getPet_etctype() {
		return pet_etctype;
	}
	public void setPet_etctype(String pet_etctype) {
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
}
