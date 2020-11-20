package myshop.model;

import member.model.MemberVO;

public class OneQueryVO {
	
	private int seq_oq;
	private int fk_memberno;
	private String category;
	private String title;
	private String content;
	private int answerform;
	private String writeday;
	private int answerstatus;
	
	private MemberVO mvo;
	
	public int getSeq_oq() {
		return seq_oq;
	}
	
	public void setSeq_oq(int seq_oq) {
		this.seq_oq = seq_oq;
	}
	
	public int getFk_memberno() {
		return fk_memberno;
	}
	
	public void setFk_memberno(int fk_memberno) {
		this.fk_memberno = fk_memberno;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getAnswerform() {
		return answerform;
	}
	
	public void setAnswerform(int answerform) {
		this.answerform = answerform;
	}
	
	public String getWriteday() {
		return writeday;
	}
	
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	public int getAnswerstatus() {
		return answerstatus;
	}
	
	public void setAnswerstatus(int answerstatus) {
		this.answerstatus = answerstatus;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

}
