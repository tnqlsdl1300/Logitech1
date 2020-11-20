package myshop.model;

public class CouponVO {
	
	private String couponcode;
	private String couponname;
	private int discount;
	private int minprice;
	private String fk_membershipname;
	
	public String getCouponcode() {
		return couponcode;
	}
	
	public void setCouponcode(String couponcode) {
		this.couponcode = couponcode;
	}
	
	public String getCouponname() {
		return couponname;
	}
	
	public void setCouponname(String couponname) {
		this.couponname = couponname;
	}
	
	public int getDiscount() {
		return discount;
	}
	
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	
	public int getMinprice() {
		return minprice;
	}
	
	public void setMinprice(int minprice) {
		this.minprice = minprice;
	}
	
	public String getFk_membershipname() {
		return fk_membershipname;
	}
	
	public void setFk_membershipname(String fk_membershipname) {
		this.fk_membershipname = fk_membershipname;
	}

}
