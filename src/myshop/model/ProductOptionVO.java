package myshop.model;

public class ProductOptionVO {
	
	private String productserialid;
	private String fk_productid;
	private String color;
	private int stock;
	private String saleday;
	private ProductVO pvo;
	
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
	};
	
	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}

}
