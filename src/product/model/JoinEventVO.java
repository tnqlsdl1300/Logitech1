package product.model;

public class JoinEventVO {
	
	private int seq_joinevent;	// 회원이벤트 시퀀스
	private int fk_event;		// 이벤트 번호(시퀀스)
	private int fk_memberno;	// 참여한 회원번호
	private int winstatus;		// 당첨여부
	
	EventVO eventvo;			// (select 용) 해당 이벤트 객체
	
	////////////////////////////////////////////////
	
	public JoinEventVO() {	}
	
	////////////////////////////////////////////////

	public int getSeq_joinevent() {
		return seq_joinevent;
	}

	public void setSeq_joinevent(int seq_joinevent) {
		this.seq_joinevent = seq_joinevent;
	}

	public int getFk_event() {
		return fk_event;
	}

	public void setFk_event(int fk_event) {
		this.fk_event = fk_event;
	}

	public int getFk_memberno() {
		return fk_memberno;
	}

	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}

	public int getWinstatus() {
		return winstatus;
	}

	public void setWinstatus(int winstatus) {
		this.winstatus = winstatus;
	}

	public EventVO getEventvo() {
		return eventvo;
	}

	public void setEventvo(EventVO eventvo) {
		this.eventvo = eventvo;
	}
	
	

}
