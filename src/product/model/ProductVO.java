package product.model;



//DTO(data tranfer object) 데이터 전송객체 == VO(value object)
//어떤 값을 담아서 보내야하는 공통점. 대부분 같다고 본다.

public class ProductVO {
	
	String productid;
	String productname;
	String fk_category;
	String character;
	int price;
	String imgfilename;
	String carouselimg;
	String detailimg;
	ProductOptionVO povo;
	
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
	public ProductOptionVO getPovo() {
		return povo;
	}
	public void setPovo(ProductOptionVO povo) {
		this.povo = povo;
	}
}