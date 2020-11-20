package myshop.model;

import member.model.MemberVO;

public class EachCouponVO {
	
	private String eachcouponcode;
	private String fk_couponcode;
	private int fk_memberno;
	private int status;
	private String endday;
	
	private CouponVO coupvo;
	
	public String getEachcouponcode() {
		return eachcouponcode;
	}
	
	public void setEachcouponcode(String eachcouponcode) {
		this.eachcouponcode = eachcouponcode;
	}
	
	public String getFk_couponcode() {
		return fk_couponcode;
	}
	
	public void setFk_couponcode(String fk_couponcode) {
		this.fk_couponcode = fk_couponcode;
	}
	
	public int getFk_memberno() {
		return fk_memberno;
	}
	
	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}
	
	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}
	
	public String getEndday() {
		return endday;
	}
	
	public void setEndday(String endday) {
		this.endday = endday;
	}

	public CouponVO getCoupvo() {
		return coupvo;
	}

	public void setCoupvo(CouponVO coupvo) {
		this.coupvo = coupvo;
	}

}
