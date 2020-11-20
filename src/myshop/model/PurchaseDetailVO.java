package myshop.model;

public class PurchaseDetailVO {
	
	int purchasedetailid;       
	int fk_purchaseno;       
	String fk_productid; 
	String fk_productserialid; 
	int volume;    
	String deliverystatus;
	
	private ProductVO pvo;
	private PurchaseVO purcvo;
	private int detailtotalpay;
	
	public PurchaseDetailVO() {}
	
	public PurchaseDetailVO(int purchasedetailid, int fk_purchaseno, String fk_productid, String fk_productserialid,
			int volume, String deliverystatus) {
	
		this.purchasedetailid = purchasedetailid;
		this.fk_purchaseno = fk_purchaseno;
		this.fk_productid = fk_productid;
		this.fk_productserialid = fk_productserialid;
		this.volume = volume;
		this.deliverystatus = deliverystatus;
		
		
	}

	public int getPurchasedetailid() {
		return purchasedetailid;
	}

	public void setPurchasedetailid(int purchasedetailid) {
		this.purchasedetailid = purchasedetailid;
	}

	public int getFk_purchaseno() {
		return fk_purchaseno;
	}

	public void setFk_purchaseno(int fk_purchaseno) {
		this.fk_purchaseno = fk_purchaseno;
	}

	public String getFk_productid() {
		return fk_productid;
	}

	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}

	public String getFk_productserialid() {
		return fk_productserialid;
	}

	public void setFk_productserialid(String fk_productserialid) {
		this.fk_productserialid = fk_productserialid;
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}

	public String getDeliverystatus() {
		return deliverystatus;
	}

	public void setDeliverystatus(String deliverystatus) {
		this.deliverystatus = deliverystatus;
	}

	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}

	public PurchaseVO getPurcvo() {
		return purcvo;
	}

	public void setPurcvo(PurchaseVO purcvo) {
		this.purcvo = purcvo;
	}

	public int getDetailtotalpay() {
		return detailtotalpay;
	}

	public void setDetailtotalpay(int detailtotalpay) {
		this.detailtotalpay = detailtotalpay;
	} 
	
	
	
	
	
	
}
