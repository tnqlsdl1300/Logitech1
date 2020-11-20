package product.model;

public class ProductOptionVO {
	
	String productserialid;
	String fk_productid;
	String color;
	int stock;
	String saleday;
	
	public ProductOptionVO() {}
	
	public ProductOptionVO(String productserialid, String fk_productid, String color, int stock, String saleday) {
		super();
		this.productserialid = productserialid;
		this.fk_productid = fk_productid;
		this.color = color;
		this.stock = stock;
		this.saleday = saleday;
	}
	
	public String getProductserialid() {
		return productserialid;
	}
	public void setProductserialid(String productserialid) {
		this.productserialid = productserialid;
	}
	public String getFk_productid() {
		return fk_productid;
	}
	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getSaleday() {
		return saleday;
	}
	public void setSaleday(String saleday) {
		this.saleday = saleday;
	}
}
