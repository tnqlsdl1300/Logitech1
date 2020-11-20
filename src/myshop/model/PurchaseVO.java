package myshop.model;

import member.model.MemberVO;
import member.model.PointVO;

public class PurchaseVO {
	int purchaseno;
	int fk_memberno;
	String receiver;
	String postcode;
	String address;
	String detailaddress;
	String extraaddress;
	String payment;
	int totalprice;
	String purchaseday;
	private String ordernum;
	private String totalstatus;
	
 
	private MemberVO mvo;
	private PointVO pointvo;
	private int discount;
	
	public PurchaseVO() {}
	
	public PurchaseVO(int purchaseno, int fk_memberno, String receiver, String postcode, String detailaddress,
			String extraaddress, String payment, int totalprice, String purchaseday) {
		
		this.purchaseno = purchaseno;
		this.fk_memberno = fk_memberno;
		this.receiver = receiver;
		this.postcode = postcode;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.payment = payment;
		this.totalprice = totalprice;
		this.purchaseday = purchaseday;
	}
	
	

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTotalstatus() {
		return totalstatus;
	}

	public void setTotalstatus(String totalstatus) {
		this.totalstatus = totalstatus;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getPurchaseno() {
		return purchaseno;
	}

	public void setPurchaseno(int purchaseno) {
		this.purchaseno = purchaseno;
	}

	public int getFk_memberno() {
		return fk_memberno;
	}

	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public String getPurchaseday() {
		return purchaseday;
	}

	public void setPurchaseday(String purchaseday) {
		this.purchaseday = purchaseday;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public PointVO getPointvo() {
		return pointvo;
	}

	public void setPointvo(PointVO pointvo) {
		this.pointvo = pointvo;
	}
	
	
	
	
}
