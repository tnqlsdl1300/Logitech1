package member.model;

public class PointVO {
   private int pointnum;
   private String reason;
   private int usedpointnum;
   private int fk_purchaseno;
   private String pointdate;
   
   public int getPointnum() {
      return pointnum;
   }
   public void setPointnum(int pointnum) {
      this.pointnum = pointnum;
   }
   
   public String getReason() {
      return reason;
   }
   public void setReason(String reason) {
      this.reason = reason;
   }

   public int getUsedpointnum() {
      return usedpointnum;
   }
   public void setUsedpointnum(int usedpointnum) {
      this.usedpointnum = usedpointnum;
   }
   public int getFk_purchaseno() {
      return fk_purchaseno;
   }
   public void setFk_purchaseno(int fk_purchaseno) {
      this.fk_purchaseno = fk_purchaseno;
   }
   public String getPointdate() {
      return pointdate;
   }
   public void setPointdate(String pointdate) {
      this.pointdate = pointdate;
   }
   
}