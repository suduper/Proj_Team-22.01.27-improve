package pack_goods;

import java.io.File;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;

public class GoodsProc {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER ="C:/Users/TridentK/git/"
															   + "Project_Lofi_Co-op/"
															   + "src/main/webapp/"
															   + "Resource/GoodsImg/"; // 경로명 반드시 변경
	private static String encType = "UTF-8";
	private static int maxSize = 100*1024*1024;
	
	 Date now = new Date();
	 SimpleDateFormat fm = new SimpleDateFormat("_yyMMddhhmm");
	 String add = fm.format(now);
	 
	 Encoder encoder = Base64.getEncoder();
	 Decoder decoder = Base64.getDecoder();
	
	public GoodsProc() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}
	}
	
	//              상품     등록     시작        //
	public void regGoods(HttpServletRequest req) {		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql 					=		null;
		
		///////////////////////////////////////////////////////////////////
		String inputID = null; // id
		String properties = null; // id 의 내용
		String filename = null; //이미지 하나의 이름
		
		String goodsName = null; // 상품 이름
		String goodsWarehousing = null; // 상품 입고일
		String goodsType = null; // 상품 종류
		String goodsPrice = null; // 상품 판매가격
		String goodsSPrice = null; // 상품 세일가격
		String goodsThumbnail = null; // 상품 썸네일 이름
		String goodsImages = null; // 상품 이미지 이름
		String allImages = ""; // 모든 상품 이미지 이름
		String goodsContent = null; //상품 내용
		 									
											// 재고 량
		int inventoryS = 0;
		int inventoryM = 0;
		int inventoryL = 0;
		int inventoryXL = 0;
		
		String goodsFolder = null; // 상품 폴더 초기화
		
		String encoName = null;	
		String Nonly = null;
		String ext = null;
		byte[] Byte = null;
		///////////////////////////////////////////////////////////////////
		
		
		try {
			
		DiskFileUpload upload = new DiskFileUpload();
		upload.setRepositoryPath(SAVEFOLDER);
		upload.setSizeMax(100*1024 * 1024); // 최대 10메가
		upload.setSizeThreshold(1024 * 100); // 한번에 100Kb 까지는 메모리에 저장
		List items = upload.parseRequest(req);
		Iterator params = items.iterator();
		while (params.hasNext()) {
			FileItem fileItem = (FileItem) params.next();
			
			inputID = (String) fileItem.getFieldName(); //input name 요소
			filename = fileItem.getName(); //input 에 넣은 파일 이름요소 
			
			////////////////////////////////////////////
			if (fileItem.isFormField()) { // 파일이 아닌경우
				properties = fileItem.getString("UTF-8"); //파일이름 UTF-8로 인코딩
				
				if(inputID.equals("goodsName")){
					goodsName = properties;
					
					Byte = goodsName.getBytes();
					encoName = encoder.encodeToString(Byte)+add;
					encoName = encoName.replaceAll("/", "\\{");
					goodsFolder = SAVEFOLDER + (encoName);
					File goodsFile = new File(goodsFolder);
					if(!goodsFile.exists()){
						goodsFile.mkdirs();
					}
					File goodsThumb = new File(goodsFolder + "/thumb");
					if(!goodsThumb.exists()){
						goodsThumb.mkdirs();
					}					
				}
				
				if(inputID.equals("goodsWarehousing")) {
					goodsWarehousing = properties;
				
				}
				if(inputID.equals("goodsType")){
					goodsType = properties;
					
				}
				if(inputID.equals("goodsPrice")){
					goodsPrice = properties;
					
				}
				if(inputID.equals("goodsSPrice")){
					goodsSPrice = properties;
					
				}
				if(inputID.equals("goodsContent")){
					goodsContent = properties;
					
				}
				if(inputID.equals("inventoryS")){
					inventoryS = Integer.parseInt(properties) ;
			
				}
				if(inputID.equals("inventoryM")){
					inventoryM = Integer.parseInt(properties) ;
					
				}
				if(inputID.equals("inventoryL")){
					inventoryL = Integer.parseInt(properties) ;
					
				}
				if(inputID.equals("inventoryXL")){
					inventoryXL = Integer.parseInt(properties) ;
					
				}
				
				
			}
			////////////////////////////////////////////
			////////////////////////////////////////////
			if (!fileItem.isFormField()) { //파일인경우
				
				filename = fileItem.getName();				
				Nonly = FilenameUtils.removeExtension(filename); //파일 이름 추출
				ext = FilenameUtils.getExtension(filename); //파일 확장자 추출
				Byte = Nonly.getBytes(); //파일 이름 바이트로 변환
				goodsFolder = SAVEFOLDER + (encoName); // 저장 디렉토리 위치
				
				if(inputID.equals("goodsThumbnail")){ //썸네일의 경우
					if (filename != null) {
						goodsThumbnail = encoder.encodeToString(Byte)+"."+ext ; // 바이트로 변환된 썸네일 이름 인코딩
						File thumb = new File(goodsFolder + "/thumb/thumb_" + goodsThumbnail);//썸네일 파일앞에 thumb_추가로 썸네일 표기
						fileItem.write(thumb);
					}
					
					
				} else if(inputID.equals("goodsImages")){ //이미지의 경우
					if (filename != null) {
						goodsImages = encoder.encodeToString(Byte)+"."+ext; // 바이트로 변환된 이미지 이름 인코딩
						allImages += goodsImages +" / ";
						File Images = new File(goodsFolder + "/" + goodsImages);
						fileItem.write(Images);
					}
					
				}
				
			}
			////////////////////////////////////////////
		}
		
		System.out.println("이름: "+goodsName+add);
		System.out.println("입고일: "+goodsWarehousing);
		System.out.println("종류:"+goodsType);
		System.out.println("가격:"+goodsPrice);
		System.out.println("할인가:"+goodsSPrice);
		System.out.println("썸네일:"+goodsThumbnail);
		System.out.println("이미지:"+allImages);
		System.out.println("내용:"+goodsContent);

			objConn = pool.getConnection();

			sql = "insert into GoodsInfo ("
					+ "goodsName,"
					+ "goodsWarehousing,"
					+ "goodsType,"
					+ "goodsPrice,"
					+ "goodsSPrice,"
					+ "goodsThumbnail,"
					+ "goodsImages,"					
					+ "goodsContent,"
					+ "regDate,"
					+ "inventoryS,"
					+ "inventoryM,"
					+ "inventoryL,"
					+ "inventoryXL"
					+ ")values(?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?, ?)";
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, goodsName+add);
			objPstmt.setString(2, goodsWarehousing);
			objPstmt.setString(3, goodsType);
			objPstmt.setInt(4, Integer.parseInt(goodsPrice) );
			objPstmt.setInt(5, Integer.parseInt(goodsSPrice) );
			objPstmt.setString(6, goodsThumbnail);
			objPstmt.setString(7, allImages);
			objPstmt.setString(8, goodsContent );
			objPstmt.setInt(9, inventoryS);
			objPstmt.setInt(10, inventoryM);
			objPstmt.setInt(11, inventoryL);
			objPstmt.setInt(12, inventoryXL);
			objPstmt.executeUpdate();
			
		
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
	}
	//  			상품 등록      끝       //
	
	// 저장된 상품 리스트 불러오기 시작 //
	public Vector<Goods> getBoardList() {

		Vector<Goods> GoodsList = new Vector<>();
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;

		try {
			objConn = pool.getConnection();   // DB연동구문 사용
			sql = "select * from goodsInfo order by goodsnum desc limit ?, ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, 0);
			objPstmt.setInt(2, 20);
			objRs = objPstmt.executeQuery(); 
	 
			while (objRs.next()) {
				Goods list = new Goods();
				list.setGoodsNum(objRs.getInt("goodsNum"));
				list.setGoodsName(objRs.getString("goodsName"));
				list.setGoodsType(objRs.getString("goodsType"));
				list.setGoodsPrice(objRs.getInt("goodsPrice"));
				list.setGoodsSPrice(objRs.getInt("goodsSPrice"));
				list.setGoodsThumbnail(objRs.getString("goodsThumbnail"));
				list.setRegDate(objRs.getString("regDate"));
				list.setwCount(objRs.getInt("wcount"));
				GoodsList.add(list);
			}
		
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return GoodsList;
	}
	// 저장된 상품 리스트 불러오기 종료 //

	// 상품 조회수 증가 시작 //
	
	public void upCount(String goodsName) {
		// 조회수 증가 시작
		Connection					objConn			=	null;
		PreparedStatement 		objPstmt 			= 	null;
		String								sql 				=	null;
		
		try {
			objConn = pool.getConnection();   // DB연동
			sql = "update GoodsInfo set wCount = wCount+1 where goodsName=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, goodsName);
			objPstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}
		
	}
	
	// 상품 조회수 증가 끝 //
	
	// 상품 정보 전송 시작 //
	public Goods getGoodsView(String goodsName) {

		Connection					objConn			=	null;
		PreparedStatement 		objPstmt 			= 	null;
		String								sql 				=	null;
		ResultSet						  objRs				=	null;							
		
		Goods View = new Goods();
		try {
			objConn = pool.getConnection();   // DB연동
			sql = "select * from goodsInfo where goodsName=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, goodsName);
			objRs = objPstmt.executeQuery();
			
			if (objRs.next()) {
				
				
				View.setGoodsNum(objRs.getInt("goodsNum"));
				View.setGoodsName(objRs.getString("goodsName"));
				View.setGoodsWarehousing(objRs.getString("goodsWarehousing"));
				View.setGoodsType(objRs.getString("goodsType"));
				View.setGoodsPrice(objRs.getInt("goodsPrice"));
				View.setGoodsSPrice(objRs.getInt("goodsSPrice"));
				View.setGoodsThumbnail(objRs.getString("goodsThumbnail"));
				View.setGoodsImages(objRs.getString("goodsImages"));
				View.setGoodsContent(objRs.getString("goodsContent"));
				View.setRegDate(objRs.getString("regDate"));
				View.setInventoryS(objRs.getInt("inventoryS"));
				View.setInventoryM(objRs.getInt("inventoryM"));
				View.setInventoryL(objRs.getInt("inventoryL"));
				View.setInventoryXL(objRs.getInt("inventoryXL"));
				View.setwCount(objRs.getInt("wcount"));
				
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return View;
	} 

	// 상품 정보 전송 끝 //

	
	// 상품 정보 업데이트 시작 //
	public void updateGoods(HttpServletRequest req,
										String oldGoodsInfo) {		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql 					=		null;
		
		///////////////////////////////////////////////////////////////////
		String OGN = null; //이전 상품 전체 이름
		String OGT = null; //이전 상품 썸네일
		String OGI = null; //이전 상품 이미지
		
		/*
		 OGN = URLEncoder.encode(OGN,"UTF-8"); System.out.println(OGN);
		 
		 OGN = URLDecoder.decode(OGN,"UTF-8"); System.out.println(OGN);
		 */
		
		String[] InfoArray = oldGoodsInfo.split("//"); //가져온 정보 쪼개기
		int IAC = InfoArray.length; //쪼갠 횟수 (3번)
		for (int i = 0; i < InfoArray.length; i++) { //쪼갠정보 저장
			if(i == 0) { OGN= InfoArray[0];}
			if(i == 1) { OGT= InfoArray[1];}
			if(i == 2) { OGI= InfoArray[2];}
		}
		int NL = OGN.length();	 // Name Length = 서버내 상품이름길이
		int TL = NL - 11;    // True length = 서버내 상품이름에서 날짜 빼기
		String OriginName = OGN.substring(0,TL);  // 이전상품 이름
		String OriginDate = OGN.substring(TL,NL); // 이전상품 등록날짜
		
		
		System.out.println("이름  " +OGN);
		System.out.println("썸네일  "+OGT);
		System.out.println("이미지  "+OGI);		
		System.out.println("원래 이름  :  "+OriginName);
		System.out.println("원래 날짜  :  "+OriginDate);

		String inputID = null; // 가져온 속성의 id
		String properties = null; // id 의 내용
		String filename = null; //이미지 하나의 이름
		
		String goodsName = null; // 상품 이름
		String goodsWarehousing = null; // 상품 입고일
		String goodsType = null; // 상품 종류
		String goodsPrice = null; // 상품 판매가격
		String goodsSPrice = null; // 상품 세일가격
		String goodsThumbnail = null; // 상품 썸네일 이름
		String goodsImages = null; // 상품 이미지 이름
		String allImages = ""; // 모든 상품 이미지 이름
		String goodsContent = null; //상품 내용
		
		String goodsFolder = null; // 상품 폴더 초기화
		
		String encoName = null;	
		String Nonly = null;
		String ext = null;
		byte[] Byte = null;
		
		File OrigFolder = null;
		File ChgFolder = null;
		
		int ImgLoop = 1; 
		
		String[] OimgArray = OGI.split(" / ");
		///////////////////////////////////////////////////////////////////
		
		try {
			objConn = pool.getConnection();
			sql = "select * from goodsInfo where goodsName=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, OGN);
			objRs = objPstmt.executeQuery();

			if (objRs.next()) {
				System.out.println(objRs.getString("goodsName"));
				System.out.println(objRs.getString("goodsThumbnail"));
				System.out.println(objRs.getString("goodsImages"));				
			}
			
		DiskFileUpload upload = new DiskFileUpload();
		upload.setRepositoryPath(SAVEFOLDER);
		upload.setSizeMax(100*1024 * 1024); // 최대 100메가
		upload.setSizeThreshold(1024 * 100); // 한번에 100Kb 까지는 메모리에 저장
		List items = upload.parseRequest(req);
		Iterator params = items.iterator();
		while (params.hasNext()) {
			FileItem fileItem = (FileItem) params.next();
			inputID = (String) fileItem.getFieldName(); //input name 요소
			filename = fileItem.getName(); //input 에 넣은 파일 이름요소 
			
			////////////////////////////////////////////
			if (fileItem.isFormField()) { // 파일이 아닌경우
			properties = fileItem.getString("UTF-8"); //파일이름 UTF-8로 인코딩
				
				if(inputID.equals("goodsName")){
					goodsName = properties+OriginDate;
					System.out.println("Prop"+ properties);
					System.out.println(goodsName);
					
					if(goodsName.equals(objRs.getString("goodsName"))) {
						System.out.println("상품이름 같다!!!");
						byte[] way = OriginName.getBytes();
						String NCD = SAVEFOLDER+encoder.encodeToString(way)+OriginDate;
						System.out.println(NCD);
						ChgFolder = new File(NCD);
					}
					if(!goodsName.equals(objRs.getString("goodsName"))) {
						System.out.println("상품이름 다르다 : " + goodsName);
						byte[] OrigN = OriginName.getBytes();
						String EncOrig = encoder.encodeToString(OrigN);
						System.out.println("ORIG "+ EncOrig);
						byte[] ChgN = properties.getBytes();
						String EncChg = encoder.encodeToString(ChgN);
						System.out.println("ENC " + EncChg);
						OrigFolder = new File(SAVEFOLDER+EncOrig+OriginDate);
						ChgFolder = new File(SAVEFOLDER+EncChg+OriginDate);
						if(!OrigFolder.renameTo(ChgFolder)) {
							System.out.println("파일명 변경 불가능 :" + EncOrig);
						}
						
					}
				}
				
				if(inputID.equals("goodsWarehousing")) {
					goodsWarehousing = properties;
				}
				if(inputID.equals("goodsType")){
					goodsType = properties;
				}
				if(inputID.equals("goodsPrice")){
					goodsPrice = properties;
				}
				if(inputID.equals("goodsSPrice")){
					goodsSPrice = properties;
				}
				if(inputID.equals("goodsContent")){
					goodsContent = properties;
				}
			}
			////////////////////////////////////////////
			////////////////////////////////////////////
			if (!fileItem.isFormField()) { //파일인경우

				filename = fileItem.getName();				
				Nonly = FilenameUtils.removeExtension(filename); //파일 이름 추출
				ext = FilenameUtils.getExtension(filename); //파일 확장자 추출
				Byte = Nonly.getBytes(); //파일 이름 바이트로 변환
				goodsFolder = SAVEFOLDER + ChgFolder; // 저장 디렉토리 위치
				
				if(inputID.equals("goodsThumbnail")){ //썸네일의 경우
					if (filename == "") {
						System.out.println("썸네일 변경없음 : "  +filename);
						goodsThumbnail = OGT;

					}
					if(filename != "") {
						System.out.println("파일명 " +filename);
						goodsThumbnail = encoder.encodeToString(Byte)+"."+ext;
						System.out.println("GT : "+goodsThumbnail);
						System.out.println("OGT : " + OGT);
						System.out.println(ChgFolder);
						File forDel = new File(ChgFolder+"/thumb/thumb_" + OGT);
						System.out.println(forDel);
						if(forDel.delete()){
					  		System.out.println("기존 썸네일 삭제됨 : " + forDel);
					  	}
					  	File forTUp = new File(ChgFolder + "/thumb/thumb_" + goodsThumbnail);
					  	fileItem.write(forTUp);
					}
					
				} else if(inputID.equals("goodsImages")){ //이미지의 경우
					if(filename == "") {
						System.out.println("이미지 변경 없음 : " +filename);
						goodsImages = OGI;
					}
					if(filename != "") {
						for (int i = 0; i < OimgArray.length - 1; i++) {
							if( ImgLoop == 1) {
								System.out.println("저장된 파일 수 : " + OimgArray.length);
								for (int j = 0; j < OimgArray.length; j++) {
									File forImgDel = new File(ChgFolder+"/"+OimgArray[j]); 
									System.out.println(forImgDel);
									if(forImgDel.delete()) {
										System.out.println("이미지 삭제됨 : " + OimgArray[j]); 
									} 
								}
								System.out.println(ImgLoop + "회 제거실행");
								ImgLoop++;
							}
						}
						goodsImages = encoder.encodeToString(Byte)+"."+ext;
						System.out.println("GI : " + goodsImages);
						File forIUp = new File(ChgFolder +"/"+ goodsImages);
						allImages += goodsImages + " / ";
						fileItem.write(forIUp);
					}
				}
			}
			////////////////////////////////////////////
		}
		sql = "update GoodsInfo set "
				+ " goodsName = ?,"
				+ " goodsWarehousing = ?,"
				+ " goodsType = ?,"
				+ " goodsPrice = ?,"
				+ " goodsSPrice = ?,"
				+ " goodsThumbnail = ?,"
				+ " goodsImages = ?,"
				+ " goodsContent = ?"
				+ " where goodsName = ?";
		
		objPstmt = objConn.prepareStatement(sql);
		objPstmt.setString(1, goodsName);
		objPstmt.setString(2, goodsWarehousing);
		objPstmt.setString(3, goodsType);
		objPstmt.setInt(4, Integer.parseInt(goodsPrice));
		objPstmt.setInt(5, Integer.parseInt(goodsSPrice));
		objPstmt.setString(6, goodsThumbnail);
		objPstmt.setString(7, allImages);
		objPstmt.setString(8, goodsContent );
		objPstmt.setString(9, OGN);
		objPstmt.executeUpdate();
		
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
	}
	// 상품 정보 업데이트 끝 //
	
	// 옷바구니 정보 추가 및 업데이트 시작 //
	public int addBasket(String uID, 
									 String goodsName,
									 String Scount, 
									 String Mcount, 
									 String Lcount, 
									 String XLcount, 
									 String Allcount, 
									 String calcRes) {
		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql 					=		null;
		
		System.out.println(goodsName);
		System.out.println(uID);
		
		try {
			objConn = pool.getConnection();
			sql = "select exists ("
					+ "select * from userBasket "
					+ "where uID = '"+uID+"'"
					+ "and goodsName = '"+goodsName +"'"
					+ "and ordered = 0 "
					+ "limit 1) as RES;";
			
			objPstmt = objConn.prepareStatement(sql);	
			objRs = objPstmt.executeQuery(sql);
			if(objRs.next()) {
				if(objRs.getInt(1) == 0) { // 옷바구니에 같은 상품이 없다면
					System.out.println(uID + "의 옷바구니 목록 추가");
					sql = "insert into userBasket value (?,now(), ?, ?, ?, ?, ?, ?, ?, 0)";
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, uID);
					System.out.println(1);
					objPstmt.setString(2, goodsName);
					System.out.println(2);
					objPstmt.setInt(3, Integer.parseInt(Scount));
					System.out.println(3);
					objPstmt.setInt(4, Integer.parseInt(Mcount));
					System.out.println(4);
					objPstmt.setInt(5, Integer.parseInt(Lcount));
					System.out.println(5);
					objPstmt.setInt(6, Integer.parseInt(XLcount));
					System.out.println(6);
					objPstmt.setInt(7, Integer.parseInt(Allcount));
					System.out.println(7);
					objPstmt.setInt(8, Integer.parseInt(calcRes)); 
					System.out.println(8);
					objPstmt.executeUpdate();
					return 1;
				} else if(objRs.getInt(1) == 1) { // 옷바구니에 같은 상품이 있다면
					System.out.println(uID + "의 옷바구니 업데이트됨");
					sql = "update userBasket set "
							+ "Scount = ? , "
							+ "Mcount = ? ,  "
							+ "Lcount = ? , "
							+ "XLcount = ? ,  "
							+ "Allcount = ? , "
							+ "calcRes = ? "
							+ "where uID = ? and "
							+ "goodsName = ? ;";
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setInt(1, Integer.parseInt(Scount));
					objPstmt.setInt(2, Integer.parseInt(Mcount));
					objPstmt.setInt(3, Integer.parseInt(Lcount));
					objPstmt.setInt(4, Integer.parseInt(XLcount));
					objPstmt.setInt(5, Integer.parseInt(Allcount));
					objPstmt.setInt(6, Integer.parseInt(calcRes)); 
					objPstmt.setString(7, uID);
					objPstmt.setString(8, goodsName);
					objPstmt.executeUpdate();
					return 2;	
				} else { 
					return -1;
				}
			}		
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return 0;
		
	}
	
	// 옷바구니 안 상품 개수 시작 //
	public int BasketCount(String uID) {
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql 					=		null;
		
		try {
			objConn = pool.getConnection();
			sql = "select count(*) from userbasket where uID = ? ";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery();
			if(objRs.next()) {
				return objRs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
	
		
		return 0;	
	}
	// 옷바구니 안 상품 개수 끝 //
	
	// 옷바구니 정보 추가 및 업데이트 끝//
	
	// 옷바구니 보기 시작 //
	public Vector<MyBasket> showBasket(String uID) {

		Vector<MyBasket> BasketList = new Vector<>();
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;

		try {
			objConn = pool.getConnection();   // DB연동구문 사용
			sql = "select * from userBasket where uID =? and ordered = 0";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery(); 
	 
			while (objRs.next()) {
				MyBasket BList = new MyBasket();
				BList.setAddDate(objRs.getString("addDate"));
				BList.setGoodsName(objRs.getString("goodsName"));
				BList.setScount(objRs.getInt("Scount"));
				BList.setMcount(objRs.getInt("Mcount"));
				BList.setLcount(objRs.getInt("Lcount"));
				BList.setXLcount(objRs.getInt("XLcount"));
				BList.setAllcount(objRs.getInt("Allcount"));
				BList.setCalcRes(objRs.getInt("calcRes"));
				BasketList.add(BList);
			}
		
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return BasketList;
	}
	// 옷바구니 보기 끝 //
	
	
	// 상품 주문 시작 //
	public String userOrder(String uID,
									   String orderName, 
								  	   String info,
								  	   int Zip,
								  	   String Addr1,
								  	   String Addr2,
								  	   String phone,
								  	   String notice) {
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;
		
		System.out.println(info);
		String[] info_split = info.split(" / ");
		System.out.println(info_split[0]); //addDate
		System.out.println(info_split[1]); //goodsName
		System.out.println(info_split[2]); //Ss
		System.out.println(info_split[3]); //Ms
		System.out.println(info_split[4]); //Ls
		System.out.println(info_split[5]); //XLs
		System.out.println(info_split[6]); //calcRes
		System.out.println(Addr1);
		System.out.println(Addr2);
		try {
			objConn = pool.getConnection();
			sql= "insert into userOrder values(?, now(),?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objPstmt.setString(2, info_split[0]);
			objPstmt.setString(3, orderName);
			objPstmt.setString(4, info_split[1]);
			objPstmt.setInt(5, Integer.parseInt(info_split[2]));
			objPstmt.setInt(6, Integer.parseInt(info_split[3]));
			objPstmt.setInt(7, Integer.parseInt(info_split[4]));
			objPstmt.setInt(8, Integer.parseInt(info_split[5]));
			objPstmt.setInt(9, Integer.parseInt(info_split[6]));
			objPstmt.setInt(10, Zip);
			objPstmt.setString(11, Addr1);
			objPstmt.setString(12, Addr2);
			objPstmt.setString(13, phone);
			objPstmt.setString(14, notice);
			objPstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		System.out.println(info_split[1]+" 장바구니 삭제로 보냄");
		return info_split[1];
	}
	// 상품 주문 끝 //
	
	// 주문상품 장바구니 삭제 시작//
	public int set0Basket(String uID, String goodsName) {
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;
		int res = 0;
		try {
			objConn = pool.getConnection();
			
			sql= "update userBasket set ordered = 1 where uID = ? and goodsName = ? and ordered = 0";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objPstmt.setString(2, goodsName);
			res = objPstmt.executeUpdate();
			System.out.println(goodsName + "장바구니에서 삭제됨");
			return res;
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return 0;
	}
	// 주문상품 장바구니 삭제 끝//
	
	// 구매리스트 보기 시작 //
	public Vector<MyBasket> showBuyList(String uID) {

			Vector<MyBasket> MyBuyList = new Vector<>();
			Connection					objConn		=	null;
			PreparedStatement 		objPstmt 		= 	null;
			ResultSet						objRs			=	null;
			String							sql 				=	null;

			try {
				objConn = pool.getConnection();   // DB연동구문 사용
				sql = "select * from userOrder where uID =? ";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, uID);
				objRs = objPstmt.executeQuery(); 
		 
				while (objRs.next()) {
					MyBasket BuyList = new MyBasket();
					BuyList.setAddDate(objRs.getString("addDate"));
					BuyList.setGoodsName(objRs.getString("goodsName"));
					BuyList.setScount(objRs.getInt("Scount"));
					BuyList.setMcount(objRs.getInt("Mcount"));
					BuyList.setLcount(objRs.getInt("Lcount"));
					BuyList.setXLcount(objRs.getInt("XLcount"));
					BuyList.setCalcRes(objRs.getInt("calcRes"));
					BuyList.setZip(objRs.getInt("Zip"));
					BuyList.setAddr1(objRs.getString("Addr1"));
					BuyList.setAddr2(objRs.getString("Addr2"));
					BuyList.setDelivery(objRs.getInt("delivery"));
					MyBuyList.add(BuyList);
				}
			
			} catch (SQLException e) {
				System.out.println("SQL 이슈 : " + e.getMessage());
			} catch (Exception e) {
				System.out.println("DB 접속이슈 : " + e.getMessage());
			} finally {
				pool.freeConnection(objConn, objPstmt, objRs);
			}
			return MyBuyList;
		}
		// 구매리스트 보기 끝 //
	
}







