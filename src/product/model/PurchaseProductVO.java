package product.model;

public class PurchaseProductVO {
	
	
	   int sq_cart;
	   String fk_productid;
	   int price;
	   String selectcolor;
	   int fk_memberno;
	   String cartpronum;
	   
	  

	public PurchaseProductVO() {}
	   
	   public PurchaseProductVO(int sq_cart, String fk_productid, int price, String selectcolor,  int fk_memberno, String cartpronum) {
		
		this.sq_cart = sq_cart;
		this.fk_productid = fk_productid;
		this.price = price;
		this.selectcolor = selectcolor;
		this.fk_memberno=  fk_memberno;
		this.cartpronum = cartpronum;
	}
	   
	   
	public String getCartpronum() {
		return cartpronum;
	}

	public void setCartpronum(String cartpronum) {
		this.cartpronum = cartpronum;
	}

	public int getSq_cart() {
	      return sq_cart;
	   }
	   public void setSq_cart(int sq_cart) {
	      this.sq_cart = sq_cart;
	   }
	   public String getFk_productid() {
	      return fk_productid;
	   }
	   public void setFk_productid(String fk_productid) {
	      this.fk_productid = fk_productid;
	   }
	   public int getPrice() {
	      return price;
	   }
	   public void setPrice(int price) {
	      this.price = price;
	   }
	   public String getSelectcolor() {
	      return selectcolor;
	   }
	   public void setSelectcolor(String selectcolor) {
	      this.selectcolor = selectcolor;
	   }

	public int getFk_memberno() {
		return fk_memberno;
	}

	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}
	   
	   
	   
	}

