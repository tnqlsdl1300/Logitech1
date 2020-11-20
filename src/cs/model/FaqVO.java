package cs.model;

public class FaqVO {

	private String seq_faq;
	private String suq_category;
	private String category;
	private String title;
	private String content;
	

	public FaqVO() {}


	public String getSeq_faq() {
		return seq_faq;
	}


	public void setSeq_faq(String seq_faq) {
		this.seq_faq = seq_faq;
	}


	public String getSuq_category() {
		return suq_category;
	}


	public void setSuq_category(String suq_category) {
		this.suq_category = suq_category;
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

	
	public FaqVO(String seq_faq, String suq_category, String category, String title, String content) {
		
		this.seq_faq = seq_faq;
		this.suq_category = suq_category;
		this.category = category;
		this.title = title;
		this.content = content;
	}
	
	
	

	
	
	
		
	
	
	
	
}
