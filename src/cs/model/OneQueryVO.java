package cs.model;

public class OneQueryVO {

	private String seq_eq; // 문의번호
	private int fk_memberno; // 회원번호
	private String category; // 카테고리
	private String title; // 제목
	private String content; // 고객문의내용
	private String answerform; // 답변희망형태  1 이면 email 0 이면 마이페이지 내 
	private String writeday; // 작성일자 default
	private String answerstatus; // 답변상태 
	private String answerday; // 답변일자 default
	
	
	
	/////////////////////////////////////////////////////////////////////

	
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	/////////////////////////////////////////////////////////////////////

	public OneQueryVO() {}
	public OneQueryVO(String category, String title, String content,
			String answerform) {
		
		this.category = category;
		this.title = title;
		this.content = content;
		this.answerform = answerform;
	}
	
	public String getSeq_eq() {
		return seq_eq;
	}
	public void setSeq_eq(String seq_eq) {
		this.seq_eq = seq_eq;
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
	public String getAnswerform() {
		return answerform;
	}
	public void setAnswerform(String answerform) {
		this.answerform = answerform;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getAnswerstatus() {
		return answerstatus;
	}
	public void setAnswerstatus(String answerstatus) {
		this.answerstatus = answerstatus;
	}
	public String getAnswerday() {
		return answerday;
	}
	public void setAnswerday(String answerday) {
		this.answerday = answerday;
	}
	
	
	
	
	

	




	




	
	
	
	
	
	
}
