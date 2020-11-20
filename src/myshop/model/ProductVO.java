package myshop.model;

public class ProductVO {
	
	private String productid;
	private String productname;
	private String fk_category;
	private String character;
	private int price;
	private String imgfilename;
	private String carouselimg;
	private String detailimg;
	
	public String getProductid() {
		return productid;
	}
	
	public void setProductid(String productid) {
		this.productid = productid;
	}
	
	public String getProductname() {
		return productname;
	}
	
	public void setProductname(String productname) {
		this.productname = productname;
	}
	
	public String getFk_category() {
		return fk_category;
	}
	
	public void setFk_category(String fk_category) {
		this.fk_category = fk_category;
	}
	
	public String getCharacter() {
		return character;
	}
	
	public void setCharacter(String character) {
		this.character = character;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getImgfilename() {
		return imgfilename;
	}
	
	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}
	
	public String getCarouselimg() {
		return carouselimg;
	}
	
	public void setCarouselimg(String carouselimg) {
		this.carouselimg = carouselimg;
	}
	
	public String getDetailimg() {
		return detailimg;
	}
	
	public void setDetailimg(String detailimg) {
		this.detailimg = detailimg;
	}	

}
