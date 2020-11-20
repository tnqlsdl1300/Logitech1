package product.model;

public class LikeProductVO {
   
   int seq_like;
   int fk_memberno;
   String fk_productid;
   int status;
   
   
   public int getSeq_like() {
      return seq_like;
   }
   public void setSeq_like(int seq_like) {
      this.seq_like = seq_like;
   }
   public int getFk_memberno() {
      return fk_memberno;
   }
   public void setFk_memberno(int fk_memberno) {
      this.fk_memberno = fk_memberno;
   }
   public String getFk_productid() {
      return fk_productid;
   }
   public void setFk_productid(String fk_productid) {
      this.fk_productid = fk_productid;
   }
   public int getStatus() {
      return status;
   }
   public void setStatus(int status) {
      this.status = status;
   }
   
   
}