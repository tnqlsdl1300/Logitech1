package member.model;

public class MemberVO {
	
	private int memberno;
	private String userid;
	private String pwd;
	private String name;
	private String email;
	private String mobile;
	private String birthday;
	private String postcode;
	private String address;
	private String detailaddress;
	private String extraaddress;
	private String agreeemail;
	private String agreesms;
	private String agreethird;
	private String fk_membershipname;
	private int point;
	private String registerday;
	private String lastpwdchangeday;
	private int idle;	// 휴면유무(0: 활동중 / 1: 휴면중)
	private int status;			// 회원탈퇴 유무 (1: 사용가능 / 0:사용불능)
	private String dropday;
						
	
	///////////////////////////////
	
	// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지나지 않았으면 false
	private boolean requirePwdChange = false;
	
	
	///////////////////////////////
	
	public MemberVO() {	}
	
	/////////////////////////////////////////
	
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	
	/////////////////////////////////////

	public int getMemberno() {
		return memberno;
	}

	public void setMemberno(int memberno) {
		this.memberno = memberno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getAgreeemail() {
		return agreeemail;
	}

	public void setAgreeemail(String agreeemail) {
		this.agreeemail = agreeemail;
	}

	public String getAgreesms() {
		return agreesms;
	}

	public void setAgreesms(String agreesms) {
		this.agreesms = agreesms;
	}

	public String getAgreethird() {
		return agreethird;
	}

	public void setAgreethird(String agreethird) {
		this.agreethird = agreethird;
	}

	public String getFk_membershipname() {
		return fk_membershipname;
	}

	public void setFk_membershipname(String fk_membershipname) {
		this.fk_membershipname = fk_membershipname;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getLastpwdchangeday() {
		return lastpwdchangeday;
	}

	public void setLastpwdchangeday(String lastpwdchangeday) {
		this.lastpwdchangeday = lastpwdchangeday;
	}

	public int getIdle() {
		return idle;
	}

	public void setIdle(int idle) {
		this.idle = idle;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getDropday() {
		return dropday;
	}

	public void setDropday(String dropday) {
		this.dropday = dropday;
	}
	
	
	/////////////////////////////////////////
	
	
	
	
	

}
