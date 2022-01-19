package pack_user;

public class User {
	
	private String Nationality;
	private String Certify;
	private String uID;
	private String uPw;
	private String uZip;
	private String uAddr1;
	private String uAddr2;
	private String authority;
	private String Wallet;
	
	
	public String getNationality() {
		return Nationality;
	}
	public void setNationality(String nationality) {
		Nationality = nationality;
	}
	public String getCertify() {
		return Certify;
	}
	public void setCertify(String certify) {
		Certify = certify;
	}
	public String getuID() {
		return uID;
	}
	public void setuID(String uID) {
		this.uID = uID;
	}
	public String getuPw() {
		return uPw;
	}
	public void setuPw(String uPw) {
		this.uPw = uPw;
	}
	public String getuZip() {
		return uZip;
	}
	public void setuZip(String uZip) {
		this.uZip = uZip;
	}
	public String getuAddr1() {
		return uAddr1;
	}
	public void setuAddr1(String uAddr1) {
		this.uAddr1 = uAddr1;
	}
	public String getuAddr2() {
		return uAddr2;
	}
	public void setuAddr2(String uAddr2) {
		this.uAddr2 = uAddr2;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getWallet() {
		return Wallet;
	}
	public void setWallet(String wallet) {
		Wallet = wallet;
	}
	
	
}
