package product.model;

public class EventVO {
	
	private int seq_event;			// 이벤트 시퀀스
	private String eventname;		// 이벤트명
	private String fk_productid;	// 이벤트 제품 아이디
	private String startday;		// 이벤트 시작 날짜
	private String endday;			// 이벤트 종료 날짜
	private String carouselimg;		// 이벤트 캐러셀 이미지
	
	////////////////////////////////////////////
	
	public EventVO() {	}
	
	////////////////////////////////////////////
	
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

	public String getCarouselimg() {
		return carouselimg;
	}

	public void setCarouselimg(String carouselimg) {
		this.carouselimg = carouselimg;
	}

	
}
