package pack_goods;

public class MyBasket {
	 
	private String addDate;
	private String goodsName;
	private int Scount;
	private int Mcount;
	private int Lcount;
	private int XLcount;
	private int Allcount;
	private int calcRes;
	private int Zip;
	private String Addr1;
	private String Addr2;
	private String phone;
	private String notice;
	private int delivery;
	
	public String getAddDate() {
		return addDate;
	}
	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public int getScount() {
		return Scount;
	}
	public void setScount(int scount) {
		Scount = scount;
	}
	public int getMcount() {
		return Mcount;
	}
	public void setMcount(int mcount) {
		Mcount = mcount;
	}
	public int getLcount() {
		return Lcount;
	}
	public void setLcount(int lcount) {
		Lcount = lcount;
	}
	public int getXLcount() {
		return XLcount;
	}
	public void setXLcount(int xLcount) {
		XLcount = xLcount;
	}
	public int getAllcount() {
		return Allcount;
	}
	public void setAllcount(int allcount) {
		Allcount = allcount;
	}
	public int getCalcRes() {
		return calcRes;
	}
	public void setCalcRes(int calcRes) {
		this.calcRes = calcRes;
	}
	
	///////////////배송정보////////////////
	public int getZip() {
		return Zip;
	}
	public void setZip(int zip) {
		Zip = zip;
	}
	public String getAddr1() {
		return Addr1;
	}
	public void setAddr1(String addr1) {
		Addr1 = addr1;
	}
	public String getAddr2() {
		return Addr2;
	}
	public void setAddr2(String addr2) {
		Addr2 = addr2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}

	
	
}
