package myshop.model;

public class EventVO {
	
	private int seq_event;
	private String eventname;
	private String fk_productid;
	private String startday;
	private String endday;
	
	public int getSeq_event() {
		return seq_event;
	}
	
	public void setSeq_event(int seq_event) {
		this.seq_event = seq_event;
	}
	
	public String getEventname() {
		return eventname;
	}
	
	public void setEventname(String eventname) {
		this.eventname = eventname;
	}
	
	public String getFk_productid() {
		return fk_productid;
	}
	
	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}
	
	public String getStartday() {
		return startday;
	}
	
	public void setStartday(String startday) {
		this.startday = startday;
	}
	
	public String getEndday() {
		return endday;
	}
	
	public void setEndday(String endday) {
		this.endday = endday;
	}

}
