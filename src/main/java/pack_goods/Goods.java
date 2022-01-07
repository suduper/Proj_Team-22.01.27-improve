package pack_goods;
 
public class Goods {
	
	private int goodsNum;        //상품 번호
	private String goodsName; //상품 이름
	private String goodsWarehousing;
	private String goodsType;   //상품 종류
	private int goodsPrice;       //상품 판매 가격
	private int goodsSPrice;    //상품 세일 가격
	private String goodsThumbnail;
	private String goodsImages; // 상품 이미지
	private String goodsContent; //상품 내용
	private String regDate;         // 상품 등록일
	private int inventoryS	;       // S사이즈 재고
	private int inventoryM;		// M사이즈 재고
	private int inventoryL;		// L사이즈 재고
	private int inventoryXL;		// XL사이즈 재고
	private int wCount;			// 조회수
	
	public int getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(int goodsNum) {
		this.goodsNum = goodsNum;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getGoodsWarehousing() {
		return goodsWarehousing;
	}
	public void setGoodsWarehousing(String goodsWarehousing) {
		this.goodsWarehousing = goodsWarehousing;
	}
	public String getGoodsType() {
		return goodsType;
	}
	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public int getGoodsSPrice() {
		return goodsSPrice;
	}
	public void setGoodsSPrice(int goodsSPrice) {
		this.goodsSPrice = goodsSPrice;
	}
	public String getGoodsThumbnail() {
		return goodsThumbnail;
	}
	public void setGoodsThumbnail(String goodsThumbnail) {
		this.goodsThumbnail = goodsThumbnail;
	}
	public String getGoodsImages() {
		return goodsImages;
	}
	public void setGoodsImages(String goodsImages) {
		this.goodsImages = goodsImages;
	}
	public String getGoodsContent() {
		return goodsContent;
	}
	public void setGoodsContent(String goodsContent) {
		this.goodsContent = goodsContent;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getInventoryS() {
		return inventoryS;
	}
	public void setInventoryS(int inventoryS) {
		this.inventoryS = inventoryS;
	}
	public int getInventoryM() {
		return inventoryM;
	}
	public void setInventoryM(int inventoryM) {
		this.inventoryM = inventoryM;
	}
	public int getInventoryL() {
		return inventoryL;
	}
	public void setInventoryL(int inventoryL) {
		this.inventoryL = inventoryL;
	}
	public int getInventoryXL() {
		return inventoryXL;
	}
	public void setInventoryXL(int inventoryXL) {
		this.inventoryXL = inventoryXL;
	}
	public int getwCount() {
		return wCount;
	}
	public void setwCount(int wCount) {
		this.wCount = wCount;
	}
	
	
	


}
