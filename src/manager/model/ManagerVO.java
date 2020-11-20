package manager.model;

public class ManagerVO {
	
	private int managerno;  // 관리자 번호
	private String managerid;  // 관리자 아이디
	private String managerpwd;  // 관리자 비밀번호
	private String managertype;  // 관리자 유형
	private String manageremail;  // 담당 메일
	private String managermobile;  // 담당 전화번호
	
	public ManagerVO() {}
	
	public ManagerVO(String managerid, String managerpwd, String managertype, String manageremail,
			String managermobile) {
		super();
		this.managerid = managerid;
		this.managerpwd = managerpwd;
		this.managertype = managertype;
		this.manageremail = manageremail;
		this.managermobile = managermobile;
	}

	public int getManagerno() {
		return managerno;
	}
	
	public void setManagerno(int managerno) {
		this.managerno = managerno;
	}
	
	public String getManagerid() {
		return managerid;
	}
	
	public void setManagerid(String managerid) {
		this.managerid = managerid;
	}
	
	public String getManagerpwd() {
		return managerpwd;
	}
	
	public void setManagerpwd(String managerpwd) {
		this.managerpwd = managerpwd;
	}
	
	public String getManagertype() {
		return managertype;
	}
	
	public void setManagertype(String managertype) {
		this.managertype = managertype;
	}
	
	public String getManageremail() {
		return manageremail;
	}
	
	public void setManageremail(String manageremail) {
		this.manageremail = manageremail;
	}
	
	public String getManagermobile() {
		return managermobile;
	}
	
	public void setManagermobile(String managermobile) {
		this.managermobile = managermobile;
	}

}
