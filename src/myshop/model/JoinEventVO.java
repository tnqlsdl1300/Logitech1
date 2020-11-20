package myshop.model;

import member.model.MemberVO;

public class JoinEventVO {
	
	private int seq_joinevent;
	private int fk_event;
	private int fk_memberno;
	private int winstatus;
	
	private MemberVO mvo;
	private EventVO evo;
	
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

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public EventVO getEvo() {
		return evo;
	}

	public void setEvo(EventVO evo) {
		this.evo = evo;
	}

}
