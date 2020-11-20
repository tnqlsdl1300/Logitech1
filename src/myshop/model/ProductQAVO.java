package myshop.model;

import member.model.MemberVO;

public class ProductQAVO {
	
	private int seq_qa;
	private int fk_memberno;
	private String fk_productid;
	private String content;
	private String writeday;
	private int status;
	
	private MemberVO mvo;
	
	public int getSeq_qa() {
		return seq_qa;
	}
	
	public void setSeq_qa(int seq_qa) {
		this.seq_qa = seq_qa;
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
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getWriteday() {
		return writeday;
	}
	
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

}
